package scenes {
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class Pong extends Scene {
		private var player:Quad;
		
		private var touch:Touch;
		private var touchX:Number;
		private var touchY:Number;
		
		public function Pong() {
			super();
			
			touchX = 0;
			touchY = 0;
			
			player = new Quad(Constants.GameWidth * 0.01, Constants.GameHeight * 0.1);
			player.pivotX = player.width * 0.5;
			player.pivotY = player.height * 0.5;
			player.x = Constants.GameWidth * 0.05;
			player.y = Constants.GameHeight * 0.5;
			addChild(player);
		}
		
		override protected function onTick(e:Event=null):void {
			super.onTick(e);
			
			player.y -= (player.y - touchY) * 0.1;
		}
		
		override protected function onTouch(touchEvent:TouchEvent=null):void {
			super.onTouch(touchEvent);
			
			touch = touchEvent.getTouch(stage);
			
			if(touch) {
				touchY = touch.globalY;
			}
		}
	}
}
