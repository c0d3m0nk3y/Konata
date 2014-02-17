package objects {
	
	public class Enemy extends AnimatedGameObject {
		public function Enemy(spriteSheetName:String, frames:int, frameWidth:Number=0, frameHeight:Number=0) {
			super(spriteSheetName, frames, frameWidth, frameHeight);
			
			solid = true;
			_velocity.x = 200;
			_weight = 20;
			
			name = "Enemy";
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
			reverseHorizontalDirection();
		}
		
		private function reverseHorizontalDirection():void {
			_velocity.x *= -1;
		}
	}
}
