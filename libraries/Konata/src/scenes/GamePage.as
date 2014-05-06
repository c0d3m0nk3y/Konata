package scenes {
	import objects.Player;
	
	public class GamePage extends Scene {
		
		public static var scrollSpeed:int = 8;
		
		public function GamePage() {
			super();
			
			makeObjects();
		}
		
		private var _player:Player;
		
		override protected function initialise():void {
			super.initialise();
			
			addChild(_player);
		}
		
		private function makeObjects():void {
			_player = new Player();
			_player.fps = 6;
			_player.x = Constants.GameWidth * 0.25;
			_player.y = Constants.GameHeight * 0.5;
		}
	}
}
