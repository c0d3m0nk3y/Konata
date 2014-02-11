package scenes {
	import objects.GameObject;
	import objects.Player;
	
	import starling.display.Image;
	
	public class GamePage extends Scene {
		private var _upButton:Image;
		
		public function GamePage() {
			super();
		}
		
		private var player:Player;
		
		override protected function initialise():void {
			super.initialise();
			
			if(Support.isMobile()) {
				_upButton = new Image(Assets.getTexture("big"));
				_upButton.x = _upButton.width * 0.5;
				_upButton.y = Constants.GameHeight - _upButton.height * 2;
				addChild(_upButton);
			}
			
			makePlayer();
			
			var goLeft:GameObject = new GameObject(Assets.getTexture("small"));
			goLeft.width = Constants.GameWidth * 0.4;
			goLeft.height = Constants.GameHeight * 0.25;
			goLeft.y = Constants.GameHeight * 0.75;
			goLeft.solid = true;
			addChild(goLeft);
			
			var goRight:GameObject = new GameObject(Assets.getTexture("small"));
			goRight.width = Constants.GameWidth * 0.4;
			goRight.height = Constants.GameHeight * 0.25;
			goRight.x = Constants.GameWidth * 0.6;
			goRight.y = Constants.GameHeight * 0.75;
			goRight.solid = true;
			addChild(goRight);
		}
		
		private function makePlayer():void {
			player = new Player();
			player.fps = 6;
			player.x = 0;
			player.y = Constants.CenterY;
			addChild(player);
		}
	}
}
