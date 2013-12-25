package scenes {
	import com.greensock.TweenMax;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	
	import utils.BackgroundFactory;
	
	public class Scene extends Sprite {
		
		public function Scene() {
			super();
			
			setBackground(Background.GRAND_TECH);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		protected var backArrow:Image;
		protected var mBackButton:Button;
		
		public function destroy():void {
			// REMOVE EVENT LISTENERS
			removeEventListeners();
			TweenMax.killAll();
			removeAllDelayedCalls();
		
			// CLEAR ANY STATICS
		
		}
		
		protected function onKeyDown(keyboardEvent:KeyboardEvent):void {
		}
		
		protected function onTouch(touchEvent:TouchEvent=null):void {
		}
		
		protected function removeAllDelayedCalls():void {
			Starling.juggler.purge();
		}
		
		protected function setBackground(name):void {
			addChildAt(BackgroundFactory.get(name), 0);
		}
	}


}
