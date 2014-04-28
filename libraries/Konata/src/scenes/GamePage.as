package scenes {
	import objects.Player;
	import objects.Terrain;
	
	import starling.display.Image;
	
	public class GamePage extends Scene {
		
		public static var scrollSpeed:int = 4;
		
		public function GamePage() {
			super();
			
			makeObjects();
		}
		
		private var _upButton:Image;
		
		private var _player:Player;
		
		override protected function initialise():void {
			super.initialise();
			
			if (Support.isMobile()) {
				_upButton = new Image(Assets.getTexture("grass"));
				_upButton.x = _upButton.width * 0.5;
				_upButton.y = Constants.GameHeight - _upButton.height * 2;
				addChild(_upButton);
			}
			
			addChild(_player);
		}
		
		private function makeObjects():void {
			for(var i:int = 0; i < 50; i++) {
				var t:Terrain = new Terrain(12, 2);
				t.x = (t.width * 1.5) * i;
				t.y = Constants.GameHeight - t.height;
				addChild(t);
			}
			
			_player = new Player();
			_player.fps = 6;
			_player.x = Constants.GameWidth * 0.25;
			_player.y = t.y - _player.height;
		}
	}
}
