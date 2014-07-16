package scenes {
	import avmplus.getQualifiedClassName;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class MainMenu extends Sprite {
		
		public function MainMenu() {
			var start:Button = new Button(Texture.fromColor(Constants.GameWidth * 0.5, Constants.GameHeight * 0.5), "Start");
			start.x = (Constants.GameWidth - start.width) * 0.5;
			start.y = (Constants.GameHeight - start.height) * 0.5;
			start.name = getQualifiedClassName(Pong);
			addChild(start);
		}
	}
}
