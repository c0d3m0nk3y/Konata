package objects {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Collidables {
		public static const DOWN:int = 2;
		public static const LEFT:int = 3;
		public static const RIGHT:int = 1;
		public static const UP:int = 0;
		
		private static var _instance:Collidables;
		
		public static function addCollidable(collidable:GameObject):void {
			instance.addCollidable(collidable);
		}
		
		/**
		 * Returns true if any collision found in the given direction.
		 *
		 * @param direction use Collidables.UP/RIGHT/DOWN/LEFT
		 */
		public static function collides(gameObject:GameObject, direction:int):Boolean {
			return instance.collides(gameObject, direction);
		}
		
		public static function removeCollidable(collidable:GameObject):void {
			instance.removeCollidable(collidable);
		}
		
		/**
		 * Returns the Y position of the first collision found, or -1 if no collision found.
		 */
		public static function topYOfFirstDownwardCollision(gameObject:GameObject):Number {
			return instance.topYOfFirstDownwardCollision(gameObject);
		}
		
		/**
		 * Returns a collection of all solid GameObjects intersecting.
		 */
		public static function getCollisions(gameObject:GameObject):Vector.<GameObject> {
			return instance.getCollisions(gameObject);
		}
		
		private function getCollisions(gameObject:GameObject):Vector.<GameObject> {
			var collisionObjects:Vector.<GameObject> = new Vector.<GameObject>();
			
			for each(var collidable:GameObject in _collidables) {
				if(gameObject.bounds.intersects(collidable.bounds)) {
					collisionObjects.push(collidable);
				}
			}
			
			return collisionObjects;
		}
		
		private static function get instance():Collidables {
			return _instance ? _instance : new Collidables();
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
			if (_collidables.indexOf(collidable) == -1) {
				_collidables.push(collidable);
			}
		}
		
		private function collides(gameObject:GameObject, direction:int):Boolean {
			var collisionPoint:Point = makeCollisionPoint(gameObject, direction);
			var collidableRect:Rectangle;
			
			for each (var collidable:GameObject in _collidables) {
				if (gameObject != collidable) {
					collidableRect = makeCollidableRect(collidable);
					
					if (collidableRect.containsPoint(collisionPoint)) {
						return true;
					}
				}
			}
			
			return false;
		}
		
		private function destroy():void {
			while (_collidables.length > 0) {
				_collidables.pop();
			}
			
			_collidables = null;
			
			_instance = null;
		}
		
		private function init():void {
			_collidables = new Vector.<GameObject>();
		}
		
		private function makeCollidableRect(collidable:GameObject):Rectangle {
			var xOffset:Number = 0;
			var yOffset:Number = 0;
			if (collidable.scaleX < 0)
				xOffset = collidable.width * -collidable.scaleX;
			if (collidable.scaleY < 0)
				yOffset = collidable.height * -collidable.scaleY;
			
			return new Rectangle(collidable.x - xOffset, collidable.y - yOffset, collidable.width, collidable.height);
		}
		
		private function makeCollisionPoint(gameObject:GameObject, direction:int):Point {
			var collisionPoint:Point;
			
			if (direction == UP) {
				collisionPoint = new Point(gameObject.x + (gameObject.width * gameObject.scaleX) * 0.5,
											gameObject.y - 1);
			} else if (direction == DOWN) {
				collisionPoint = new Point(gameObject.x + (gameObject.width * gameObject.scaleX) * 0.5,
											gameObject.y + (gameObject.height * gameObject.scaleY) + 1);
			} else if (direction == LEFT) {
				collisionPoint = new Point(gameObject.x - 1,
											gameObject.y + (gameObject.height * gameObject.scaleY) * 0.5);
			} else if (direction == RIGHT) {
				collisionPoint = new Point(gameObject.x + (gameObject.width * gameObject.scaleX) + 1,
											gameObject.y + (gameObject.height * gameObject.scaleY) * 0.5);
			}
			
			return collisionPoint;
		}
		
		private function removeCollidable(collidable:GameObject):void {
			_collidables.splice(_collidables.indexOf(collidable), 1);
		}
		
		private function topYOfFirstDownwardCollision(gameObject:GameObject):Number {
			var collisionPoint:Point = makeCollisionPoint(gameObject, DOWN);
			var collidableRect:Rectangle;
			
			for each (var collidable:GameObject in _collidables) {
				if (gameObject != collidable) {
					collidableRect = makeCollidableRect(collidable);
					
					if (collidableRect.containsPoint(collisionPoint)) {
						return collidable.y;
					}
				}
			}
			
			return -1;
		}
	}
}
