package objects {
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	
	public class MessageBar extends Sprite {
		private var nextWave:TextField;
		
		public function MessageBar() {
			super();
			
			var bgQuad:Quad = new Quad(Constants.GameWidth, Constants.GameHeight / 5);
			bgQuad.alpha = 0.1;
			addChild(bgQuad);
			
			nextWave = new TextField(Constants.GameWidth, bgQuad.height, "No Message Set", "Corbel", BitmapFont.NATIVE_SIZE, 0xffffff);
			addChild(nextWave);
			
			y = Constants.GameHeight - (bgQuad.height * 1.2);
		}
		
		public function setMessage(message:String):void {
			nextWave.text = message;
		}
	}
}
