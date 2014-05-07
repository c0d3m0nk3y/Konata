package objects {
	
	public class Enemy extends GameObject {
		private static const WALK_END_FRAME:int = 11;
		private static const WALK_START_FRAME:int = 9;
		private static const LEFT:int = 1;
		private static const RIGHT:int = 2;
		private var _direction:int;
		
		public function Enemy() {
			super();
			
			solid = true;
			_velocity.x = 200;
			_direction = LEFT;
			
			name = "Enemy";
		}
		
		override public function advanceTime(time:Number):void {
			super.advanceTime(time);
			
			move(time);
		}
		
		private function move(time:Number):void {
			x -= time * _velocity.x;
		}
	}
}
