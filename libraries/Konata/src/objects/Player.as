package objects {
	import flash.ui.Keyboard;
	
	public class Player extends AnimatedGameObject {
		private static const JUMP_POWER:Number = 10;
		
		public function Player() {
			super("cherub", 12);
			
			pivotX = width * 0.5;
			pivotY = height * 0.5;
		}
		
		private var _jumping:Boolean;
		private var _yVelocity:Number;
		
		override public function advanceTime(timeDelta:Number):void {
			super.advanceTime(timeDelta);
			
			move(timeDelta);
		}
		
		private function jump(timeDelta:Number):void {
			startJumpIfNotJumping();
			
			fakeJump(timeDelta);
		}
		
		// TODO: Gravity and collision will halt the jump.
		// _jumping should go to false when such a collision is detected.
		private function fakeJump(timeDelta:Number):void {
			if (_jumping) {
				y += _yVelocity;
				
				_yVelocity += timeDelta * 50;
				
				if (_yVelocity >= JUMP_POWER) {
					_jumping = false;
				}
			}
		}
		
		private function jumpPressed():Boolean {
			return KeyRegister.isDown(Keyboard.UP);
		}
		
		private function move(timeDelta:Number):void {
			moveLeft(timeDelta);
			moveRight(timeDelta);
			jump(timeDelta);
		}
		
		private function moveLeft(timeDelta):void {
			if (KeyRegister.isDown(Keyboard.LEFT)) {
				x -= timeDelta * 100;
			}
		}
		
		private function moveRight(timeDelta):void {
			if (KeyRegister.isDown(Keyboard.RIGHT)) {
				x += timeDelta * 100;
			}
		}
		
		private function startJump():void {
			_jumping = true;
			_yVelocity = -JUMP_POWER;
		}
		
		private function startJumpIfNotJumping():void {
			if (jumpPressed() && !_jumping) {
				startJump();
			}
		}
	}
}
