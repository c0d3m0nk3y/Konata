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
			
			initialise();
			
			if (texture)
				setImage(texture);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		protected var _jumping:Boolean;
		protected var _velocity:Point;
		protected var _weight:Number;
		private var _image:Image;
		private var _solid:Boolean;
		
		public function advanceTime(time:Number):void {
			gravity(time);
			update(time);
		}
		
		override public function dispose():void {
			Collidables.removeCollidable(this);
			
			super.dispose();
		}
		
		public function set solid(value:Boolean):void {
			_solid = value;
			
			updateCollidables();
		}
		
		public function set weight(value:Number):void {
			_weight = value;
		}
		
		protected function surfaceBelow():Boolean {
			return Collidables.collides(this, Collidables.DOWN);
		}
		
		protected function update(time:Number):void {
		
		}
		
		private function addImage():void {
			if (_image) {
				addChild(_image);
			}
		}
		
		private function applyGravity(time:Number):void {
			_velocity.y += _weight * time;
			
			y += _velocity.y;
		}
		
		private function enableJump():void {
			_jumping = false;
		}
		
		private function gravity(time:Number):void {
			if (weightless)
				return;
			
			if (surfaceBelow()) {
				enableJump();
			} else {
				applyGravity(time);
			}
		}
		
		private function initialise():void {
			_weight = 0;
			_velocity = new Point(0, 0);
			_solid = false;
			_jumping = false;
		}
		
		private function onAddedToStage(event:Event=null):void {
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
		
		private function updateCollidables():void {
			if (_solid) {
				Collidables.addCollidable(this);
			} else {
				Collidables.removeCollidable(this);
			}
		
		}
		
		private function get weightless():Boolean {
			return _weight == 0;
		}
	}
}
