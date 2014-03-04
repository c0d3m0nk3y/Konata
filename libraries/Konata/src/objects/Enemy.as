package objects {
	
	public class Enemy extends AnimatedGameObject {
		private static const WALK_END_FRAME:int = 11;
		private static const WALK_START_FRAME:int = 9;
		private static const LEFT:int = 1;
		private static const RIGHT:int = 2;
		private var _direction:int;
		
		public function Enemy(spriteSheetName:String, frames:int, frameWidth:Number=0, frameHeight:Number=0) {
			super(spriteSheetName, frames, frameWidth, frameHeight);
			
			solid = true;
			_velocity.x = -200;
			_weight = 20;
			_direction = LEFT;
			
			name = "Enemy";
		}
		
		override protected function wrapFrames():void {
			if(_currentFrame > WALK_END_FRAME)
				_currentFrame = WALK_START_FRAME;
		}
		
		override protected function update(time:Number):void {
			super.update(time);
			
			move(time);
			
			avoidFallingOffEdge(time);
		
			avoidBumping(time);
		}
		
		private function avoidBumping(time:Number):void {
			if (bump()) {
				reverseDirection(time);
			}
		}
		
		private function avoidFallingOffEdge(time:Number):void {
			if (!surfaceBelow()) {
				reverseDirection(time);
			}
		}
		
		private function bump():Boolean {
			return Collidables.collides(this, _velocity.x > 0 ? Collidables.RIGHT : Collidables.LEFT);
		}
		
		private function move(time:Number):void {
			x += time * _velocity.x;
		}
		
		private function moveBackwards(time:Number):void {
			x -= time * _velocity.x;
		}
		
		private function reverseDirection(time:Number):void {
			moveBackwards(time);
			invertHorizontalVelocity();
			flipHorizontally();
			if(_direction == LEFT) {
				x += width;
				_direction = RIGHT;
			} else if(_direction == RIGHT) {
				x -= width;
				_direction = LEFT;
			}
		}
		
		private function invertHorizontalVelocity():void {
			_velocity.x *= -1;
		}
	}
}
