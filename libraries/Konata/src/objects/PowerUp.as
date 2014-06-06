package objects {
	import starling.display.Image;
	import starling.events.Event;
	
	public class PowerUp extends GameObject {
		public static const RANDOM:int = 0;
		public static const SHIELD:int = 1;
		public static const LASER:int = 2;
		public static const SPEED:int = 3;
		
		private var _powerUp:Image;
		private var _type:int;
		
		public function PowerUp(type:int=RANDOM) {
			if(type == RANDOM) { // no type specified
				_type = 1 + Math.random() * 3; // random type
			} else {
				_type = type;
			}
			
			_powerUp = new Image(Assets.getTexture("powerup_" + _type));
		}
		
		override protected function onAddedToStage(event:Event=null):void {
			super.onAddedToStage(event);
		}
	}
}
