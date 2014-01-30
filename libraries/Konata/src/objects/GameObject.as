package objects {
	import flash.geom.Point;
	
	import starling.animation.IAnimatable;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class GameObject extends Sprite implements IAnimatable {
		protected var _weight:Number;
		protected var _velocity:Point;
		private var _image:Image;
		
		public function GameObject(texture:Texture=null) {
			super();
			
			initialise();
			
			setImage(texture);
		}
		
		public function setImage(texture:Texture):void {
			removeImage();
			setImageFromTexture(texture);
			addImage();
		}
		
		private function setImageFromTexture(texture:Texture):void {
			_image = new Image(texture);
		}
		
		private function removeImage():void {
			if(_image) {
				_image.removeFromParent(true);
				_image = null;
			}
		}
		
		private function addImage():void {
			if(_image) {
				addChild(_image);
			}
		}
		
		private function initialise():void {
			_weight = 0;
			_velocity = new Point(0,0);
		}
		
		public function advanceTime(time:Number):void {
			gravity(time);
			update(time);
		}
		
		protected function update(time:Number):void {
			
		}
		
		private function gravity(time:Number):void {
			_velocity.y += _weight * time;
			
			y += _velocity.y;
		}
	}
}