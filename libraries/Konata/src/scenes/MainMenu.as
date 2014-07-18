package scenes {
	import avmplus.getQualifiedClassName;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class MainMenu extends Sprite {
		
		public function MainMenu() {
			var pong:Button = new Button(Texture.fromColor(Constants.GameWidth * 0.25, Constants.GameHeight * 0.25), "Pong");
			pong.x = (Constants.GameWidth - pong.width) * 0.25;
			pong.y = (Constants.GameHeight - pong.height) * 0.5;
			pong.name = getQualifiedClassName(Pong);
			addChild(pong);
			
			var breakout:Button = new Button(Texture.fromColor(Constants.GameWidth * 0.25, Constants.GameHeight * 0.25), "Breakout");
			breakout.x = (Constants.GameWidth - breakout.width) * 0.75;
			breakout.y = (Constants.GameHeight - breakout.height) * 0.5;
			breakout.name = getQualifiedClassName(Breakout);
			addChild(breakout);
		}
	}
}
