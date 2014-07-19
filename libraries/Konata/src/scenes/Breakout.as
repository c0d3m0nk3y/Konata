package scenes
{
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;

	public class Breakout extends Scene
	{
		private var player:Quad;
		
		private var ball:Quad;
		private var ballXVelocity:Number;
		private var ballYVelocity:Number;
		
		private var touch:Touch;
		private var touchX:Number;
		
		public function Breakout() {
			super();
			
			player = new Quad(Constants.GameWidth * 0.05, Constants.GameHeight * 0.025);
			player.pivotX = player.width * 0.5;
			player.pivotY = player.height * 0.5;
			player.x = Constants.GameWidth * 0.5;
			player.y = Constants.GameHeight * 0.95;
			addChild(player);
			
			ball = new Quad(Constants.GameHeight * 0.025, Constants.GameHeight * 0.025);
			ball.pivotX = ball.width * 0.5;
			ball.pivotY = ball.height * 0.5;
			ball.x = Constants.GameWidth * 0.1;
			ball.y = Constants.GameHeight * 0.5;
			addChild(ball);
			
			touchX = Constants.GameWidth * 0.5;
			
			ballXVelocity = 5;
			ballYVelocity = 5;
		}
		
		private function ballY():void {
			if(ballYVelocity < 0) {
				ballYVelocity -= 0.5;
			} else {
				ballYVelocity += 0.5;
			}
			
			ballYVelocity *= -1;
		}
		
		private function ballX():void {
			if(ballXVelocity < 0) {
				ballXVelocity -= 0.5;
			} else {
				ballXVelocity += 0.5;
			}
			
			ballXVelocity *= -1;
		}
		
		override protected function onTick(e:Event=null):void {
			super.onTick(e);
			
			// move player towards touch
			player.x -= (player.x - touchX) * 0.45;
			// clamp player inside game area
			if(player.x < player.width * 0.5) player.x = player.width * 0.5;
			if(player.x > Constants.GameWidth - player.width * 0.5) player.x = Constants.GameWidth - player.width * 0.5;
			
			ball.x += ballXVelocity;
			ball.y += ballYVelocity;
			
			if(ball.x < ball.width * 0.5) {
				ball.x = ball.width * 0.5 + 1;
				ballX();
			}
			
			if(ball.x > Constants.GameWidth - ball.width * 0.5) {
				ball.x = Constants.GameWidth - ball.width * 0.5 - 1;
				ballX();
			}
			
			if(ball.y < ball.height * 0.5) {
				ball.y = ball.height * 0.5 + 1;
				ballY();
			}
			
			if(ball.bounds.intersects(player.bounds)) {
				ball.y = player.y - player.height * 0.5 - 1;
				ballY();
			}
		}
		
		override protected function onTouch(touchEvent:TouchEvent=null):void {
			super.onTouch(touchEvent);
			
			touch = touchEvent.getTouch(stage);
			
			if(touch) {
				touchX = touchEvent.getTouch(stage).globalX;
			}
		}
	}
}