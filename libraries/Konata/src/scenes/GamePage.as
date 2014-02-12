package scenes {
	import objects.Enemy;
	import objects.GameObject;
	import objects.Player;
	
	import starling.display.Image;
	
	public class GamePage extends Scene {
		
		public function GamePage() {
			super();
			
			makeObjects();
		}
		
		private var _upButton:Image;
		private var enemy:Enemy;
		private var enemy2:Enemy;
		private var enemy3:Enemy;
		
		private var goLeft:GameObject;
		private var goRight:GameObject;
		
		private var player:Player;
		
		override protected function initialise():void {
			super.initialise();
			
			if (Support.isMobile()) {
				_upButton = new Image(Assets.getTexture("big"));
				_upButton.x = _upButton.width * 0.5;
				_upButton.y = Constants.GameHeight - _upButton.height * 2;
				addChild(_upButton);
			}
			
			addChild(goLeft);
			addChild(goRight);
			
			addChild(enemy);
			addChild(enemy2);
			addChild(enemy3);
			
			addChild(player);
		}
		
		private function makeObjects():void {
			goLeft = new GameObject(Assets.getTexture("small"));
			goLeft.width = Constants.GameWidth * 0.4;
			goLeft.height = Constants.GameHeight * 0.25;
			goLeft.y = Constants.GameHeight * 0.75;
			goLeft.x = Constants.GameWidth * 0.15;
			goLeft.solid = true;
			
			goRight = new GameObject(Assets.getTexture("small"));
			goRight.width = Constants.GameWidth * 0.1;
			goRight.height = Constants.GameHeight * 0.25;
			goRight.x = Constants.GameWidth * 0.8;
			goRight.y = Constants.GameHeight * 0.75;
			goRight.solid = true;
			
			player = new Player();
			player.fps = 6;
			player.x = Constants.GameWidth * 0.8;
			player.y = 0;
			
			enemy = new Enemy("cherub", 12);
			enemy.x = Constants.GameWidth * 0.2;
			
			enemy2 = new Enemy("cherub", 12);
			enemy2.x = Constants.GameWidth * 0.4;
			
			enemy3 = new Enemy("cherub", 12);
			enemy3.x = Constants.GameWidth * 0.6;
		}
	}
}
