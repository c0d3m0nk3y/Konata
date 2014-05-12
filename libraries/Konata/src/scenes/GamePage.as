package scenes {
	import objects.Enemy;
	import objects.GameObject;
	import objects.Laser;
	import objects.Player;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class GamePage extends Scene {
		
		public static var scrollSpeed:int = 8;
		
		private var _background:Background;
		private var _player:Player;
		private var _touch:Touch;
		private var _touchY:Number;
		private var _timeSinceLastShot:int = 0;
		private var _timeBetweenShots:int = 7;
		private var _leftShot:Boolean;
		private var _enemies:Vector.<Enemy>;
		private var _numEnemies:int = 3;
		private var _screenShakeFactor:int = 30;
		
		public function GamePage() {
			super();
			
			makeObjects();
		}
		
		private function makeObjects():void {
			_player = new Player();
			_player.x = Constants.GameWidth * 0.15;
			_player.y = Constants.GameHeight * 0.5;
			
			_background = new Background();
			
			_enemies = new Vector.<Enemy>();
			for(var i:int = 0; i < _numEnemies; i++) {
				var enemy:Enemy = new Enemy();
				_enemies.push(enemy);
			}
		}
		
		override protected function onTouch(touchEvent:TouchEvent=null):void {
			super.onTouch(touchEvent);
			
			_touch = touchEvent.getTouch(stage);
			
			if(_touch) {
				_touchY = _touch.globalY;
			}
		}
		
		override protected function onTick(e:Event=null):void {
			if(_player.alive) {
				_player.followCursor(_touchY);
				
				shootLasers();
			}
		}
		
		private function shakeScreen():void {
			if(_screenShakeFactor > 0) {
				this.x = Math.random() * _screenShakeFactor;
				this.y = Math.random() * _screenShakeFactor;
				_screenShakeFactor--;
			} else if(this.x != 0) {
				this.x = 0;
				this.y = 0;
			}
		}
		
		private function shootLasers():void {
			_timeSinceLastShot++;
			
			if(_timeSinceLastShot > _timeBetweenShots) {
				shootNewLaser();
				_timeSinceLastShot = 0;
			}
		}
		
		private function shootNewLaser():void {
			Sounds.playAtVolume(Sounds.PEW, 0.4);
			
			if(_leftShot) {
				var leftlaser:Laser = new Laser();
				leftlaser.x = _player.x + _player.width * 0.1;
				leftlaser.y = _player.y - _player.height * 0.2;
				addChild(leftlaser);
			} else {
				var rightlaser:Laser = new Laser();
				rightlaser.x = _player.x + _player.width * 0.1;
				rightlaser.y = _player.y + _player.height * 0.55;
				addChild(rightlaser);
			}
			
			_leftShot = !_leftShot;
		}
		
		override protected function onAddedToStage():void {
			super.onAddedToStage();
			
			addChild(_background);
			
			for each(var enemy:Enemy in _enemies) {
				addChild(enemy);
			}
			
			addChild(_player);
		}
	}
}
