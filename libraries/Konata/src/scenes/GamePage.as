package scenes {
	import objects.GameObject;
	import objects.Player;
	
	import starling.display.Image;
	
	public class GamePage extends Scene {
		private var upButton:Image;
		
		public function GamePage() {
			super();
		}
		
		private var player:Player;
		
		override protected function initialise():void {
			super.initialise();
			
			if(Support.isMobile()) {
				upButton = new Image(Assets.getTexture("big"));
				upButton.x = upButton.width * 0.5;
				upButton.y = Constants.GameHeight - upButton.height * 2;
				addChild(upButton);
			}
			
			makePlayer();
			
			var go:GameObject = new GameObject(Assets.getTexture("small"));
			go.width = Constants.GameWidth;
			go.height = Constants.GameHeight * 0.25;
			go.y = Constants.GameHeight * 0.75;
			addChild(go);
		}
		
		private function makePlayer():void {
			player = new Player();
			player.fps = 6;
			player.x = Constants.CenterX;
			player.y = Constants.CenterY;
			addChild(player);
		}
	}
}
