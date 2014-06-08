package Effects {
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	
	
	public class Effect implements IAnimatable {
		private var _type:String;
		private var _duration:Number;
		private var _elapsed:Number=0;
		
		public function Effect(type:String, duration:Number) {
			_type = type;
			_duration = duration;
			
			Starling.juggler.add(this);
		}
		
		public function applyEffect():void{
			
		}
		
		public function advanceTime(time:Number):void {
			_elapsed += time;
			if(_elapsed >= _duration) {
				_elapsed -= _duration;
				durationReached();
			}
		}
		
		protected function durationReached():void {
			
		}

		public function get type():String {
			return _type;
		}

	}
}
