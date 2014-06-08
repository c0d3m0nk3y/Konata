package objects {
	import flash.geom.Point;
	
	import Effects.Effect;
	
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class GameObject extends Sprite implements IAnimatable {
		
		protected var _alreadyHit:Boolean;
		protected var _velocity:Point;
		private var _image:Image;
		private var _solid:Boolean;
		private var _effects:Vector.<Effect>
		
		public function GameObject(texture:Texture=null) {
			super();
			
			touchable = false;
			
			initialise();
			
			if (texture)
				setImage(texture);
			
			_effects = new Vector.<Effect>();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		public function advanceTime(time:Number):void {
			applyEffects();
		}
		
		private function applyEffects():void {
			for each(var effect:Effect in _effects) {
				effect.applyEffect();
			}
		}
		
		protected function addEffect(effect:Effect):void {
			_effects.push(effect);
		}
		
		public function removeEffect(effect:Effect): void {
			for(var effectIndex:int = 0; effectIndex < _effects.length; effectIndex++) {
				if(_effects[effectIndex] == effect) {
					_effects.splice(effectIndex, 1);
					Starling.juggler.remove(effect);
					effectIndex--;
				}
			}
		}
		
		protected function hasEffect(type:String):Boolean {
			for each(var effect:Effect in _effects) {
				if(effect.type == type) return true;
			}
			
			return false;
		}
		
		override public function dispose():void {
			Collidables.removeCollidable(this);
			
			super.dispose();
		}
		
		public function set solid(value:Boolean):void {
			_solid = value;
			
			updateCollidables();
		}
		
		public function get solid():Boolean {
			return _solid;
		}
		
		private function addImage():void {
			if (_image) {
				addChild(_image);
			}
		}
		
		private function initialise():void {
			_velocity = new Point(0, 0);
			_solid = false;
			_alreadyHit = false;
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
