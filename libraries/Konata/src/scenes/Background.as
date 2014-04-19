package scenes {
	import objects.AnimatedGameObject;
	
	import starling.display.Image;
	
	public class Background extends AnimatedGameObject {
		public static const HILLS_BACKGROUND:String = "hills_background";
		public static const TEMPLE_LANE:String = "templelane";
		
		public function Background(spriteSheetName:String, frames:int) {
			super(spriteSheetName, frames, Constants.GameWidth, Constants.GameHeight);
			fps = 3;
			_scrollSpeed = 5;
			
			_secondImages = new Vector.<Image>();
			
			for each (var image:Image in _images) {
				var secondImage:Image = new Image(image.texture);
				secondImage.width = image.width;
				secondImage.height = image.height;
				
				secondImage.x = image.width;
				
				_secondImages.push(secondImage);
			}
		}
		
		private var _scrollSpeed:int;
		
		private var _secondImages:Vector.<Image>;
		
		override protected function addCurrentFrame():void {
			addChild(_images[_currentFrame]);
			addChild(_secondImages[_currentFrame]);
		}
		
		override protected function destroy():void {
			super.destroy();
			
			while (_secondImages.length > 0) {
				_secondImages.pop().removeFromParent(true);
			}
			
			_secondImages = null;
		}
		
		override protected function removeCurrentFrame():void {
			removeChild(_images[_currentFrame]);
			removeChild(_secondImages[_currentFrame]);
		}
		
		override protected function update(time:Number):void {
			super.update(time);
			scrollBackgrounds();
		}
		
		private function resetBackgroundPositions():void {
			setBackgroundPositions(0);
		}
		
		private function scrollBackgrounds():void {
			setBackgroundPositions(_images[_currentFrame].x - _scrollSpeed);
			
			wrapBackground();
		}
		
		private function secondImageFallingOffScreen():Boolean {
			return _secondImages[_currentFrame].x <= 0;
		}
		
		private function setBackgroundPositions(xPos:int):void {
			for each (var image:Image in _images) {
				image.x = xPos;
			}
			
			for each (var secondImage:Image in _secondImages) {
				secondImage.x = xPos + secondImage.width;
			}
		}
		
		private function wrapBackground():void {
			if (secondImageFallingOffScreen()) {
				resetBackgroundPositions();
			}
		}
	}
}
