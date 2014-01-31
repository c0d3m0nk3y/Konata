package {
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import utils.AudioManager;
	
	public class Sounds {
		public static const POP:String = "pop";
		
		public static function play(name:String, startTime:Number=0, loops:int=0, transform:SoundTransform=null):SoundChannel {
			return AudioManager.playSound(name, startTime, loops, transform);
		}
		
		public function Sounds() {
			throw new Error("No need to instantiate an Sounds object, do not call the constructor directly.");
		}
	}
}
