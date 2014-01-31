package objects {
	import flash.geom.Point;
	
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class GameObject extends Sprite implements IAnimatable {
		protected var _weight:Number;
		protected var _velocity:Point;
		private var _image:Image;
		private var _solid:Boolean;
		
		public function GameObject(texture:Texture=null) {
			super();
			
			initialise();
			
			if(texture) setImage(texture);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage(event:Event=null):void {
			Starling.current.juggler.add(this);
			updateCollidables();
		}
		
		private function onRemovedFromStage(event:Event=null):void {
			Starling.current.juggler.remove(this);
			Collidables.removeCollidable(this);
		}
		
		private function setImage(texture:Texture):void {
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
			_solid = false;
		}
		
		public function advanceTime(time:Number):void {
			gravity(time);
			update(time);
		}
		
		protected function update(time:Number):void {
			
		}
		
		private function gravity(time:Number):void {
			if(_weight == 0) return;
			
			if(surfaceBelow()) {
				
			} else {
				applyGravity(time);
			}
		}
		
		private function surfaceBelow():Boolean {
			return Collidables.collides(this, Collidables.DOWN);
		}
		
		private function applyGravity(time:Number):void {
			_velocity.y += _weight * time;
			
			y += _velocity.y;
		}

		public function set weight(value:Number):void {
			_weight = value;
		}

		public function set solid(value:Boolean):void {
			_solid = value;
			
			updateCollidables();
		}

		private function updateCollidables():void {
			if(_solid) {
				Collidables.addCollidable(this);
			} else {
				Collidables.removeCollidable(this);
			}
			
		}
	}
}