package scenes {
	import objects.Enemy;
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
		
		override protected function onTouch(touchEvent:TouchEvent=null):void {
			super.onTouch(touchEvent);
			
			_touch = touchEvent.getTouch(stage);
			
			if(_touch) {
				_touchY = _touch.globalY;
			}
		}
		
		override protected function onTick(e:Event=null):void {
			_player.followCursor(_touchY);
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
