package objects {
	import starling.core.Starling;
	import starling.display.Image;
	
	public class AnimatedGameObject extends GameObject {
		
		public function AnimatedGameObject(spriteSheetName:String, frames:int, frameWidth:Number=0, frameHeight:Number=0) {
			super();
			
			this._frames = frames;
			_images = new Vector.<Image>();
			
			for (var imageIndex:int = 0; imageIndex < frames; imageIndex++) {
				var framesString:String = "000" + imageIndex;
				framesString = framesString.substr(framesString.length - 3);
				
				var image:Image = new Image(Assets.getTexture(spriteSheetName + "_" + framesString));
				if (frameWidth != 0)
					image.width = frameWidth;
				if (frameHeight != 0)
					image.height = frameHeight;
				
				_images.push(image);
			}
			nextImage();
		}
		
		protected var _currentFrame:int;
		private var _elapsedTime:Number = 0;
		private var _fps:Number = 12;
		private var _frames:int;
		private var _images:Vector.<Image>;
		
		override public function dispose():void {
			destroy();
			
			super.dispose()
		}
		
		public function get fps():Number {
			return _fps;
		}
		
		public function set fps(value:Number):void {
			_fps = value;
		}
		
		protected function addCurrentFrame():void {
			addChild(_images[_currentFrame]);
		}
		
		protected function nextImage():void {
			removeCurrentFrame();
			_currentFrame++;
			wrapFrames();
			addCurrentFrame();
		}
		
		protected function removeCurrentFrame():void {
			removeChild(_images[_currentFrame]);
		}
		
		override protected function update(time:Number):void {
			incrementElapsedTime(time);
			
			if (elapsedTimeExceededFPSThreshold()) {
				nextImage();
				resetElapsedTime();
			}
		}
		
		protected function wrapFrames():void {
			if (_currentFrame >= _frames)
				_currentFrame = 0;
		}
		
		private function destroy():void {
			Starling.current.juggler.remove(this);
			
			while (_images.length > 0) {
				_images.pop().removeFromParent(true);
			}
			_images = null;
		}
		
		
		private function elapsedTimeExceededFPSThreshold():Boolean {
			return _elapsedTime > 1 / fps;
		}
		
		private function incrementElapsedTime(time:Number):void {
			_elapsedTime += time;
		}
		
		private function resetElapsedTime():void {
			_elapsedTime = 0;
		}
	}
}
