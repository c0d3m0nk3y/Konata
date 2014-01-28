package objects {
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class AnimatedGameObject extends Sprite implements IAnimatable {
		
		public function AnimatedGameObject(spriteSheetName:String, frames:int, frameWidth:Number=0, frameHeight:Number=0) {
			super();
			
			this.frames = frames;
			images = new Vector.<Image>();
			
			for (var imageIndex:int = 0; imageIndex < frames; imageIndex++) {
				var framesString:String = "000" + imageIndex;
				framesString = framesString.substr(framesString.length - 3);
				
				var image:Image = new Image(Assets.getTexture(spriteSheetName + "_" + framesString));
				if (frameWidth != 0)
					image.width = frameWidth;
				if (frameHeight != 0)
					image.height = frameHeight;
				
				images.push(image);
			}
			nextImage();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private var _fps:Number = 12;
		private var currentFrame:int;
		private var elapsedTime:Number = 0;
		private var frames:int;
		private var images:Vector.<Image>;
		
		public function advanceTime(timeDelta:Number):void {
			incrementElapsedTime(timeDelta);
			
			if (elapsedTimeExceededFPSThreshold()) {
				nextImage();
				resetElapsedTime();
			}
		}
		
		public function destroy():void {
			Starling.current.juggler.remove(this);
			
			while (images.length > 0) {
				images.pop().removeFromParent(true);
			}
			images = null;
		}
		
		public function get fps():Number {
			return _fps;
		}
		
		public function set fps(value:Number):void {
			_fps = value;
		}
		
		protected function onAddedToStage(event:Event=null):void {
			Starling.current.juggler.add(this);
		}
		
		protected function onRemovedFromStage(event:Event=null):void {
			Starling.current.juggler.remove(this);
		}
		
		private function elapsedTimeExceededFPSThreshold():Boolean {
			return elapsedTime > 1 / fps;
		}
		
		private function incrementElapsedTime(timeDelta:Number):void {
			elapsedTime += timeDelta;
		}
		
		private function nextImage():void {
			removeChild(images[currentFrame]);
			currentFrame++;
			if (currentFrame >= frames)
				currentFrame = 0;
			addChild(images[currentFrame]);
		}
		
		private function resetElapsedTime():void {
			elapsedTime = 0;
		}
	}
}
