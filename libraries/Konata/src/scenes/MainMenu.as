package scenes {
	import avmplus.getQualifiedClassName;
	
	import starling.display.Button;
	import starling.display.Sprite;
	
	public class MainMenu extends Sprite {
		public static var instance:MainMenu;
		
		public function MainMenu() {
			instance = this;
			
			var start:Button = new Button(Assets.getTexture("big"), "Start");
			start.x = (Constants.GameWidth - start.width) * 0.5;
			start.y = (Constants.GameHeight - start.height) * 0.5;
			start.name = getQualifiedClassName(GamePage);
			addChild(start);
		}
	}
}
