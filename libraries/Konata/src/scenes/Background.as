package scenes {
	import objects.AnimatedGameObject;
	
	import starling.display.Image;
	
	public class Background extends AnimatedGameObject {
		public static const HILLS_BACKGROUND:String = "hills_background";
		public static const TEMPLE_LANE:String = "templelane";
		
		public function Background(spriteSheetName:String, frames:int) {
			super(spriteSheetName, frames, Constants.GameWidth, Constants.GameHeight);
			fps = 3;
			
			_secondImages = new Vector.<Image>();
			
			for each(var image:Image in _images) {
				var secondImage:Image = new Image(image.texture);
				secondImage.width = image.width;
				secondImage.height = image.height;
				
				secondImage.y = image.width;
				
				_secondImages.push(secondImage);
			}
		}
		
		private var _secondImages:Vector.<Image>;
		
		override protected function addCurrentFrame():void {
			addChild(_images[_currentFrame]);
			addChild(_secondImages[_currentFrame]);
		}
		
		override protected function removeCurrentFrame():void {
			removeChild(_images[_currentFrame]);
			removeChild(_secondImages[_currentFrame]);
		}
	}
}
