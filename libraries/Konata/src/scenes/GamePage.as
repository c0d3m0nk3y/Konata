package scenes {
	import flash.media.SoundTransform;
	
	import objects.Laser;
	import objects.Player;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class GamePage extends Scene {
		
		public static var scrollSpeed:int = 8;
		
		public function GamePage() {
			super();
			
			makeObjects();
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
			
			shootLasers();
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
		
		private var _background:Background;
		private var _player:Player;
		private var _touch:Touch;
		private var _touchY:Number;
		private var _timeSinceLastShot:int = 0;
		private var _timeBetweenShots:int = 7;
		private var _leftShot:Boolean;
		
		override protected function onAddedToStage():void {
			super.onAddedToStage();
			
			addChild(_background);
			addChild(_player);
		}
		
		private function makeObjects():void {
			_player = new Player();
			_player.x = Constants.GameWidth * 0.15;
			_player.y = Constants.GameHeight * 0.5;
			
			_background = new Background();
		}
	}
}
