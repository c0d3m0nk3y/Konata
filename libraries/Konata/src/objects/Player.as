package objects {
	import flash.ui.Keyboard;
	
	public class Player extends AnimatedGameObject {
		private static const JUMP_POWER:Number = 10;
		
		public function Player() {
			super("cherub", 12);
			
			_weight = 20;
			_moveSpeed = 200;
			
			solid = true;
		}
		
		private var _moveSpeed:int;
		
		override protected function update(time:Number):void {
			super.update(time);
			
			move(time);
		}
		
		private function jump():void {
			if (jumpPressed() && !_jumping) {
				startJump();
			}
		}
		
		private function jumpPressed():Boolean {
			return KeyRegister.isKeyDown(Keyboard.UP);
		}
		
		private function move(timeDelta:Number):void {
			moveLeft(timeDelta);
			moveRight(timeDelta);
			jump();
		}
		
		private function moveLeft(timeDelta:Number):void {
			if (KeyRegister.isKeyDown(Keyboard.LEFT)) {
				x -= timeDelta * _moveSpeed;
			}
		}
		
		private function moveRight(timeDelta:Number):void {
			if (KeyRegister.isKeyDown(Keyboard.RIGHT)) {
				x += timeDelta * _moveSpeed;
			}
		}
		
		private function startJump():void {
			if (!_jumping)
				y += -JUMP_POWER;
			_jumping = true;
			_velocity.y = -JUMP_POWER;
		}
	}
}
