package objects {
	import flash.geom.Point;
	
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class GameObject extends Sprite implements IAnimatable {
		
		public function GameObject(texture:Texture=null) {
			super();
			
			touchable = false;
			
			initialise();
			
			if (texture)
				setImage(texture);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		protected var _velocity:Point;
		private var _image:Image;
		private var _solid:Boolean;
		
		public function advanceTime(time:Number):void {
			
		}
		
		override public function dispose():void {
			Collidables.removeCollidable(this);
			
			super.dispose();
		}
		
		public function set solid(value:Boolean):void {
			_solid = value;
			
			updateCollidables();
		}
		
		private function addImage():void {
			if (_image) {
				addChild(_image);
			}
		}
		
		private function initialise():void {
			_velocity = new Point(0, 0);
			_solid = false;
		}
		
		private function landAt(yLocation:Number):void {
			y = yLocation - height;
		}
		
		protected function onAddedToStage(event:Event=null):void {
			Starling.current.juggler.add(this);
			updateCollidables();
		}
		
		private function onRemovedFromStage(event:Event=null):void {
			Starling.current.juggler.remove(this);
			Collidables.removeCollidable(this);
		}
		
		private function removeImage():void {
			if (_image) {
				_image.removeFromParent(true);
				_image = null;
			}
		}
		
		private function setImage(texture:Texture):void {
			removeImage();
			setImageFromTexture(texture);
			addImage();
		}
		
		private function setImageFromTexture(texture:Texture):void {
			_image = new Image(texture);
		}
		
		private function topOfSurfaceBelow():Number {
			return Collidables.topYOfFirstDownwardCollision(this);
		}
		
		private function updateCollidables():void {
			if (_solid) {
				Collidables.addCollidable(this);
			} else {
				Collidables.removeCollidable(this);
			}
		
		}

		public function set velocity(value:Point):void {
			_velocity = value;
		}
		
		public function get velocity():Point {
			return _velocity;
		}

	}
}
