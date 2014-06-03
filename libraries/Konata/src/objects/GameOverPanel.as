package objects {
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class GameOverPanel extends Sprite {
		private var _restartFunction:Function;
		
		public function GameOverPanel(restartFunction:Function) {
			super();
			
			_restartFunction = restartFunction;
			
			addChild(new Image(Assets.getTexture("purplebox")));
			
			addChild(new TextField(width, height/2, "Game Over", "Corbel", BitmapFont.NATIVE_SIZE, 0xffffff));
			
			var button:Button = new Button(Texture.fromColor(width / 3, height / 3, 0x00000000),"Play Again");
			button.fontColor = 0xffffff;
			button.fontName = "Corbel";
			button.fontSize = BitmapFont.NATIVE_SIZE;
			button.pivotX = button.width / 2;
			button.pivotY = button.height / 2;
			button.x = width / 2;
			button.y = height * 3/5;
			button.addEventListener(Event.TRIGGERED, onButtonClicked);
			addChild(button);
		}
		
		private function onButtonClicked(event:Event=null):void {
			_restartFunction();
			removeFromParent(true);
		}
	}
}
