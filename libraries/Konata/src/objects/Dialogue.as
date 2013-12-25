package objects {
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.text.TextField;
	
	public class Dialogue extends DisplayObjectContainer {
		public function Dialogue(text:String) {
			var textField:TextField = new TextField(Constants.GameWidth * 0.9, Constants.GameHeight * 0.4, text, "Verdana", 24, 0xffffff);
			var background:Quad = new Quad(textField.width, textField.height, 0x777777, true);
			background.x = textField.x = Constants.GameWidth * 0.05;
			background.y = textField.y = Constants.GameHeight * 0.55;
			background.alpha = 0.4;
			addChild(background);
			addChild(textField);
		}
	}
}
