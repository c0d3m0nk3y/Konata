package objects {
	import flash.ui.Keyboard;
	
	public class Player extends AnimatedGameObject {
		private static const JUMP_POWER:Number = 2;
		
		public function Player() {
			super("cherub", 12);
			
			pivotX = width * 0.5;
			pivotY = height * 0.5;
			
			_weight = 1;
		}
		
		private var _jumping:Boolean;
		
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
		
		private function moveLeft(timeDelta):void {
			if (KeyRegister.isKeyDown(Keyboard.LEFT)) {
				x -= timeDelta * 100;
			}
		}
		
		private function moveRight(timeDelta):void {
			if (KeyRegister.isKeyDown(Keyboard.RIGHT)) {
				x += timeDelta * 100;
			}
		}
		
		private function startJump():void {
			_jumping = true;
			_velocity.y = -JUMP_POWER;
		}
	}
}
