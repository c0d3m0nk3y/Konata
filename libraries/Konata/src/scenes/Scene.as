package scenes {
	import starling.core.Starling;
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
			removeAllDelayedCalls();
		}
		
		protected function initialise():void {
			addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		protected function onAddedToStage():void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			initialise();
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
