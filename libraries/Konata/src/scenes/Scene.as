package scenes {
	import com.greensock.TweenMax;
	
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	public class Scene extends Sprite {
		
		public function Scene() {
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function destroy():void {
			removeEventListeners();
			TweenMax.killAll();
			removeAllDelayedCalls();
		}
		
		protected function onAddedToStage():void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			addChildAt(new Quad(Constants.GameWidth, Constants.GameHeight, 0x0),0);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		protected function onTick(e:Event=null):void {
		}
		
		protected function onTouch(touchEvent:TouchEvent=null):void {
		}
		
		protected function removeAllDelayedCalls():void {
			Starling.juggler.purge();
		}
	}


}
