package objects
{
	import starling.display.Image;
	import starling.events.Event;
	
	
	public class Laser extends GameObject
	{
		private var _laser:Image;
		
		public function Laser(colour:String)
		{
			super();
			
			_velocity.x = 1000;
			
			_laser = new Image(Assets.getTexture(colour + "laser"));
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
			
			if(x > Constants.GameWidth + width || x < -width) {
				removeFromParent(true);
			}
		}
	}
}