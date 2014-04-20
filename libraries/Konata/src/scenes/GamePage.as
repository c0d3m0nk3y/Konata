package scenes {
	import objects.Enemy;
	import objects.Player;
	import objects.Terrain;
	
	import starling.display.Image;
	
	public class GamePage extends Scene {
		
		public function GamePage() {
			super();
			
			makeObjects();
		}
		
		private var _upButton:Image;
		private var enemies:Vector.<Enemy>;
		
		private var _terrain:Terrain;
		
		private var player:Player;
		
		override protected function initialise():void {
			super.initialise();
			
			if (Support.isMobile()) {
				_upButton = new Image(Assets.getTexture("grass"));
				_upButton.x = _upButton.width * 0.5;
				_upButton.y = Constants.GameHeight - _upButton.height * 2;
				addChild(_upButton);
			}
			
			addChild(_terrain);
			
			for each(var enemy:Enemy in enemies) {
				addChild(enemy);
			}
			
			addChild(player);
		}
		
		private function makeObjects():void {
			_terrain = new Terrain(8, 3);
			_terrain.x = (Constants.GameWidth - _terrain.width) * 0.5;
			_terrain.y = Constants.GameHeight - _terrain.height;
			player = new Player();
			player.fps = 6;
			player.x = Constants.GameWidth * 0.8;
			player.y = 0;
			
			enemy = new Enemy("cherub", 12);
			enemy.x = Constants.GameWidth * 0.2;
			
			enemies = new Vector.<Enemy>();
			for(var enemyIndex:int = 0; enemyIndex < 1; enemyIndex++) {
				var enemy:Enemy = new Enemy("cherub", 12);
				enemy.x = Constants.GameWidth * 0.5;
				enemies.push(enemy);
			}
		}
	}
}
