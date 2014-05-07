package scenes {
	import com.greensock.TweenMax;
	
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	import utils.BackgroundFactory;
	
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
			
			setBackground(Background.DEFAULT);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		protected function onTick(e:Event=null):void {
		}
		
		protected function onTouch(touchEvent:TouchEvent=null):void {
			trace("foo");
		}
		
		protected function removeAllDelayedCalls():void {
			Starling.juggler.purge();
		}
		
		protected function setBackground(name):void {
//			addChildAt(BackgroundFactory.getBG(name), 0);
			addChildAt(new Quad(Constants.GameWidth, Constants.GameHeight, 0xffffff),0);
		}
	}


}
