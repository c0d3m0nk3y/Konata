package objects {
	import flash.ui.Keyboard;
	
	public class Player extends AnimatedGameObject {
		private static const JUMP_POWER:Number = 10;
		
		private static const LEFT:int = 1;
		private static const RIGHT:int = 2;
		private static const STANDING_FRAME:int = 10;
		private static const WALK_END_FRAME:int = 11;
		private static const WALK_START_FRAME:int = 9;
		
		public function Player() {
			super("cherub", 12);
			
			_weight = 20;
			_moveSpeed = 200;
			_standing = true;
			_walking = false;
			solid = true;
			
			name = "Player";
		}
		
		private var _direction:int;
		
		private var _moveSpeed:int;
		private var _standing:Boolean;
		private var _walking:Boolean;
		
		override protected function nextImage():void {
			if (_walking) {
				_standing = false;
				super.nextImage();
			} else {
				stand();
			}
		}
		
		override protected function update(time:Number):void {
			super.update(time);
			
			move(time);
			
			detectWalking();
			
			flipOnDirectionChange();
		}
		
		override protected function wrapFrames():void {
			if (_currentFrame > WALK_END_FRAME)
				_currentFrame = WALK_START_FRAME;
		}
		
		private function detectWalking():void {
			_walking = (KeyRegister.isKeyDown(Keyboard.LEFT) || KeyRegister.isKeyDown(Keyboard.RIGHT));
		}
		
		private function flipLeft():void {
			if (_direction == RIGHT) {
				flipHorizontally();
				x -= width;
			}
			_direction = LEFT;
		}
		
		private function flipOnDirectionChange():void {
			if (KeyRegister.isKeyDown(Keyboard.LEFT)) {
				flipLeft();
			} else if (KeyRegister.isKeyDown(Keyboard.RIGHT)) {
				flipRight();
			}
		}
		
		private function flipRight():void {
			if (_direction == LEFT) {
				flipHorizontally();
				x += width;
			}
			_direction = RIGHT;
		}
		
		private function jump():void {
			if (jumpReady()) {
				startJump();
			}
		}
		
		private function jumpPressed():Boolean {
			return KeyRegister.isKeyDown(Keyboard.UP);
		}
		
		private function jumpReady():Boolean {
			return surfaceBelow() && jumpPressed() && !_jumping;
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
		
		private function stand():void {
			if (!_standing) {
				_standing = true;
				
				removeCurrentFrame();
				_currentFrame = STANDING_FRAME;
				addCurrentFrame();
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
