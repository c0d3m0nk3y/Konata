package objects {
	import starling.display.Image;
	import starling.events.Event;
	
	public class PowerUp extends GameObject {
		public static const RANDOM:int = -1;
		public static const SHIELD:int = 0;
		public static const LASER:int = 1;
		public static const SPEED:int = 2;
		
		private var _powerUp:Image;
		private var _type:int;
		
		public function PowerUp(type:int=RANDOM) {
			if(type == RANDOM) { // no type specified
				_type = Math.random() * 3; // random type
			} else {
				_type = type;
			}
			
			_powerUp = new Image(Assets.getTexture("powerup_" + _type));
			
			addChild(_powerUp);
		}
		
		override protected function onAddedToStage(event:Event=null):void {
			super.onAddedToStage(event);
		}
	}
}
