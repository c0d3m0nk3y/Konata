package objects {
	import flash.ui.Keyboard;

	public class Player extends AnimatedGameObject {
		private var _jumping:Boolean;
		private var _yVelocity:Number;
		private static const JUMP_POWER:Number=10;
		
		public function Player() {
			super("cherub", 12);
			
			pivotX = width * 0.5;
			pivotY = height * 0.5;
		}
		
		override public function advanceTime(timeDelta:Number):void {
			super.advanceTime(timeDelta);
			
			if(KeyRegister.isDown(Keyboard.LEFT)) {
				x -= timeDelta * 100;
			}
			
			if(KeyRegister.isDown(Keyboard.RIGHT)) {
				x += timeDelta * 100;
			}
			
			if(KeyRegister.isDown(Keyboard.UP)) {
				if(!_jumping) {
					_jumping = true;
					
					_yVelocity = -JUMP_POWER;
				}
			}
			
			if(_jumping) {
				y += _yVelocity;
				
				_yVelocity += timeDelta * 50;
				
				if(_yVelocity >= JUMP_POWER) {
					_jumping = false;
				}
			}
		}
	}
}
