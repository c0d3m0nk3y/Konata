package Events
{
	import starling.events.Event;
	
	public class ShipEvent extends Event {
		public static const DEATH:String = "Death";
		
		private var _result:Boolean;
		
		public function ShipEvent(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
			_result = bubbles;	
		}
		
		public function get result():Boolean { return _result; }
	}
}