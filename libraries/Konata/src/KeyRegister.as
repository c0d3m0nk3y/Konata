package {
	import starling.core.Starling;
	import starling.events.KeyboardEvent;
	
	public class KeyRegister {
		private static const KEYS_TO_REGISTER:int = 255;
		
		private static var _keyDown:Vector.<Boolean>;
		
		public static function destroy():void {
			Starling.current.stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, onKeyDown);
			Starling.current.stage.removeEventListener(starling.events.KeyboardEvent.KEY_UP, onKeyUp);
			
			_keyDown = null;
		}
		
		public static function initialise():void {
			initialiseKeyStates();
			addEventListeners();
		}
		
		public static function isKeyDown(key):Boolean {
			if (keyIsInValidRange(key)) {
				return _keyDown[key];
			} else {
				return false;
			}
		}
		
		public static function setKeyDown(key:int, value:Boolean):void {
			if (keyIsInValidRange(key)) {
				_keyDown[key] = value;
			}
		}
		
		private static function addEventListeners():void {
			Starling.current.stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, onKeyDown);
			Starling.current.stage.addEventListener(starling.events.KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private static function initialiseKeyStates():void {
			if (!_keyDown) {
				_keyDown = new Vector.<Boolean>();
				
				for (var keyIndex:int = 0; keyIndex < KEYS_TO_REGISTER; keyIndex++) {
					_keyDown.push(false);
				}
			}
		}
		
		private static function keyIsInValidRange(key:int):Boolean {
			return (key >= 0 && key <= KEYS_TO_REGISTER);
		}
		
		private static function onKeyDown(event:starling.events.KeyboardEvent):void {
			setKeyDown(event.keyCode, true);
		}
		
		private static function onKeyUp(event:starling.events.KeyboardEvent):void {
			setKeyDown(event.keyCode, false);
		}
	}
}
