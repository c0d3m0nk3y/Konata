package Events
{
	import starling.events.Event;
	
	public class ShipEvent extends Event {
		public static const KILLED_BY_WEAPON:String = "KilledByWeapon";
		public static const KILLED_BY_COLLISION:String = "KilledByCollision";
		
		private var _result:Boolean;
		
		public function ShipEvent(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
			_result = bubbles;
		}
		
		public function get result():Boolean { return _result; }
	}
}