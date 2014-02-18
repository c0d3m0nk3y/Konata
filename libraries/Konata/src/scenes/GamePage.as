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
		private var enemies:Vector.<Enemy>;
		
		private var goLeft:GameObject;
		
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
			
			for each(var enemy:Enemy in enemies) {
				addChild(enemy);
			}
			
			addChild(player);
		}
		
		private function makeObjects():void {
			goLeft = new GameObject(Assets.getTexture("small"));
			goLeft.width = Constants.GameWidth * 0.8;
			goLeft.height = Constants.GameHeight * 0.25;
			goLeft.y = Constants.GameHeight * 0.75;
			goLeft.x = Constants.GameWidth * 0.15;
			goLeft.solid = true;
			
			player = new Player();
			player.fps = 6;
			player.x = Constants.GameWidth * 0.8;
			player.y = 0;
			
			enemy = new Enemy("cherub", 12);
			enemy.x = Constants.GameWidth * 0.2;
			
			enemies = new Vector.<Enemy>();
			for(var enemyIndex:int = 0; enemyIndex < 1; enemyIndex++) {
				var enemy:Enemy = new Enemy("cherub", 12);
				enemy.x = Math.random() * Constants.GameWidth;
				enemies.push(enemy);
			}
		}
	}
}
