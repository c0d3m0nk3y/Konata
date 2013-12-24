package scenes
{
	import com.greensock.TweenMax;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	
	import utils.BackgroundFactory;
	
    public class Scene extends Sprite
    {
        protected var mBackButton:Button;
		protected var backArrow:Image;
		
        public function Scene()
        {
			super();
			
			setBackground(Background.GRAND_TECH);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        }
		
		protected function setBackground(name):void
		{
			addChildAt(BackgroundFactory.get(name), 0);
		}
		
		protected function onTouch(touchEvent:TouchEvent=null):void
		{
		}
		
		protected function onKeyDown(keyboardEvent:KeyboardEvent):void
		{
		}
		
		public function destroy():void
		{
			// REMOVE EVENT LISTENERS
			removeEventListeners();
			TweenMax.killAll();
			removeAllDelayedCalls();
			
			// CLEAR ANY STATICS
			
		}
		
		protected function removeAllDelayedCalls():void
		{
			Starling.juggler.purge();
		}
    }
	
	
}
