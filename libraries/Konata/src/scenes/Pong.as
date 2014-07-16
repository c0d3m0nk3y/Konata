package scenes {
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class Pong extends Scene {
		private var player:Quad;
		
		private var enemy:Quad;
		
		private var ball:Quad;
		private var ballXVelocity:int;
		private var ballYVelocity:int;
		
		private var touch:Touch;
		private var touchY:Number;
		
		public function Pong() {
			super();
			
			touchY = 0;
			
			ballXVelocity = 10;
			ballYVelocity = 10;
			
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
		
		override protected function onTick(e:Event=null):void {
			super.onTick(e);
			
			player.y -= (player.y - touchY) * 0.1;
			
			// clamp player inside game area
			if(player.y < player.height * 0.5) player.y = player.height * 0.5;
			if(player.y > Constants.GameHeight - player.height * 0.5) player.y = Constants.GameHeight - player.height * 0.5;
			
			ball.x += ballXVelocity;
//			ball.y += ballYVelocity;
			
			if(ball.y <= ball.height * 0.5) {
				ball.y = ball.height * 0.5 + 1;
				ballYVelocity = 10;
			}
			
			if(ball.y >= Constants.GameHeight - ball.height * 0.5) {
				ball.y = Constants.GameHeight - ball.height * 0.5 - 1;
				ballYVelocity = -10;
			}
			
			if(ball.bounds.intersects(enemy.bounds)) {
				ball.x = enemy.x - enemy.width * 0.5 -1;
				ballXVelocity = -10;
			}
			
			if(ball.bounds.intersects(player.bounds)) {
				ball.x = player.x + player.width * 0.5 + 1;
				ballXVelocity = 10;
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
