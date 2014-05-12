package objects
{
	import starling.display.Image;
	import starling.events.Event;
	
	
	public class Laser extends GameObject
	{
		private var _laser:Image;
		
		public static const RED:int = 0;
		public static const GREEN:int = 1;
		public static const BLUE:int = 2;
		
		public function Laser(type:int=BLUE) {
			super();
			
			solid = true;
			
			_velocity.x = 1000;
			
			_laser = new Image(Assets.getTexture("laser" + type));
			_laser.x = Math.ceil(-_laser.width/2);
			_laser.y = Math.ceil(-_laser.width/2);
		}
		
		override protected function onAddedToStage(event:Event=null):void {
			super.onAddedToStage(event);
			
			addChild(_laser);
		}
		
		override public function advanceTime(time:Number):void {
			super.advanceTime(time);
			
			x += _velocity.x * time;
		}
	}
}