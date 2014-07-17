package scenes {
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class Pong extends Scene {
		private var player:Quad;
		
		private var enemy:Quad;
		
		private var ball:Quad;
		private var ballXVelocity:Number;
		private var ballYVelocity:Number;
		
		private var touch:Touch;
		private var touchY:Number;
		
		private var bounceCounter:int;
		
		public function Pong() {
			super();
			
			touchY = 0;
			
			ballXVelocity = 5;
			ballYVelocity = 5;
			
			bounceCounter = 0;
			
			player = new Quad(Constants.GameWidth * 0.01, Constants.GameHeight * 0.1);
			player.pivotX = player.width * 0.5;
			player.pivotY = player.height * 0.5;
			player.x = Constants.GameWidth * 0.05;
			player.y = Constants.GameHeight * 0.5;
			addChild(player);
			
			enemy = new Quad(Constants.GameWidth * 0.01, Constants.GameHeight * 0.1);
			enemy.pivotX = enemy.width * 0.5;
			enemy.pivotY = enemy.height * 0.5;
			enemy.x = Constants.GameWidth - Constants.GameWidth * 0.05 - enemy.width;
			enemy.y = Constants.GameHeight * 0.5;
			addChild(enemy);
			
			ball = new Quad(Constants.GameHeight * 0.025, Constants.GameHeight * 0.025);
			ball.pivotX = ball.width * 0.5;
			ball.pivotY = ball.height * 0.5;
			ball.x = Constants.GameWidth * 0.1;
			ball.y = Constants.GameHeight * 0.5;
			addChild(ball);
		}
		
		private function ballY():void {
			bounceCounter++;
			
			if(bounceCounter == 3) {
				bounceCounter = 0;
				
				if(ballYVelocity < 0) {
					ballYVelocity -= 0.5;
				} else {
					ballYVelocity += 0.5;
				}
			}
			
			ballYVelocity *= -1;
		}
		
		private function ballX():void {
			bounceCounter++;
			
			if(bounceCounter == 3) {
				bounceCounter = 0;
				
				if(ballXVelocity < 0) {
					ballXVelocity -= 0.5;
				} else {
					ballXVelocity += 0.5;
				}
			}
			
			ballXVelocity *= -1;
		}
		
		override protected function onTick(e:Event=null):void {
			super.onTick(e);
			
			// move player towards touch
			player.y -= (player.y - touchY) * 0.45;
			// clamp player inside game area
			if(player.y < player.height * 0.5) player.y = player.height * 0.5;
			if(player.y > Constants.GameHeight - player.height * 0.5) player.y = Constants.GameHeight - player.height * 0.5;
			
			// move ai towards ball
			enemy.y -= (enemy.y - ball.y) * 0.45;
			// clamp ai inside game area
			if(enemy.y < enemy.height * 0.5) enemy.y = enemy.height * 0.5;
			if(enemy.y > Constants.GameHeight - enemy.height * 0.5) enemy.y = Constants.GameHeight - enemy.height * 0.5;
			
			ball.x += ballXVelocity;
			ball.y += ballYVelocity;
			
			if(ball.y <= ball.height * 0.5) {
				ball.y = ball.height * 0.5 + 1;
				ballY();
			}
			
			if(ball.y >= Constants.GameHeight - ball.height * 0.5) {
				ball.y = Constants.GameHeight - ball.height * 0.5 - 1;
				ballY();
			}
			
			if(ball.bounds.intersects(enemy.bounds)) {
				ball.x = enemy.x - enemy.width * 0.5 -1;
				ballX();
			}
			
			if(ball.bounds.intersects(player.bounds)) {
				ball.x = player.x + player.width * 0.5 + 1;
				ballX();
			}
		}
		
		override protected function onTouch(touchEvent:TouchEvent=null):void {
			super.onTouch(touchEvent);
			
			touch = touchEvent.getTouch(stage);
			
			if(touch) {
				touchY = touchEvent.getTouch(stage).globalY;
			}
		}
	}
}
