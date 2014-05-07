package scenes {
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
		}
		
		private var _player:Player;
		private var _touch:Touch;
		private var _touchY:Number;
		
		override protected function onAddedToStage():void {
			super.onAddedToStage();
			
			addChild(_player);
		}
		
		private function makeObjects():void {
			_player = new Player();
			_player.x = Constants.GameWidth * 0.25;
			_player.y = Constants.GameHeight * 0.5;
		}
	}
}
