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
			_direction = LEFT;
			
			name = "Enemy";
		}
		
		override protected function wrapFrames():void {
			if(_currentFrame > WALK_END_FRAME)
				_currentFrame = WALK_START_FRAME;
		}
		
		override public function advanceTime(time:Number):void {
			super.advanceTime(time);
			
			move(time);
		}
		
		private function move(time:Number):void {
			x += time * _velocity.x;
		}
	}
}
