package objects {
	import flash.geom.Rectangle;
	
	public class Collidables {
		public static const UP:int = 0;
		public static const RIGHT:int = 1;
		public static const DOWN:int = 2;
		public static const LEFT:int = 3;
		
		private static var _instance:Collidables;
		
		public static function addCollidable(collidable:GameObject):void {
			instance.addCollidable(collidable);
		}
		
		public static function get instance():Collidables {
			return _instance ? _instance : new Collidables();
		}
		
		public static function removeCollidable(collidable:GameObject):void {
			instance.removeCollidable(collidable);
		}
		
		/**
		 * Detect any collision in the given direction.
		 * 
		 * @param direction use Collidables.UP/RIGHT/DOWN/LEFT
		 */
		public static function collides(gameObject:GameObject, direction:int):Boolean {
			return instance.collides(gameObject, direction);
		}
		
		private function collides(gameObject:GameObject, direction:int):Boolean {
			var collisionRect:Rectangle = makeCollisionRect(gameObject, direction);
			
			for each(var collidable:GameObject in _collidables) {
				if(gameObject != collidable) {
					if(collisionRect.intersects(new Rectangle(collidable.x, collidable.y, collidable.width, collidable.height))) {
						return true;
					}
				}
			}
			
			return false;
		}
		
		private function makeCollisionRect(gameObject:GameObject, direction:int):Rectangle {
			var collisionRect:Rectangle;
			
			if(direction == UP) {
				collisionRect = new Rectangle(gameObject.x, gameObject.y - 1, gameObject.width, gameObject.height);
			} else if(direction == DOWN) {
				collisionRect = new Rectangle(gameObject.x, gameObject.y + 1, gameObject.width, gameObject.height);
			} else if(direction == LEFT) {
				collisionRect = new Rectangle(gameObject.x - 1, gameObject.y, gameObject.width, gameObject.height);
			} else if(direction == RIGHT) {
				collisionRect = new Rectangle(gameObject.x + 1, gameObject.y, gameObject.width, gameObject.height);
			}
			
			return collisionRect;
		}
		
		public function Collidables() {
			if (!_instance) {
				init();
				_instance = this;
			} else {
				throw Error("This is a singleton!  Do not call the constructor directly");
			}
		}
		
		private var _collidables:Vector.<GameObject>;
		
		private function addCollidable(collidable:GameObject):void {
			if(_collidables.indexOf(collidable) == -1) {
				_collidables.push(collidable);
			}
		}
		
		private function init():void {
			_collidables = new Vector.<GameObject>();
		}
		
		private function removeCollidable(collidable:GameObject):void {
			_collidables.splice(_collidables.indexOf(collidable), 1);
		}
	}
}
