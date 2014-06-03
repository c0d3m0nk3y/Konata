package {
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import utils.AudioManager;
	
	public class Sounds {
		public static const PEW:String = "pew";
		public static const EXPLOSION:String = "small_explosion";
		
		public static function play(name:String, startTime:Number=0, loops:int=0, transform:SoundTransform=null):SoundChannel {
			return AudioManager.playSound(name, startTime, loops, transform);
		}
		
		public static function playAtVolume(name:String, volume:Number, startTime:Number=0, loops:int=0):SoundChannel {
//			if(volume < 0 || volume > 1) throw new Error("Volume must be between 0 and 1 inclusive");
			return AudioManager.playSound(name, startTime, loops, new SoundTransform(volume));
		}
		
		public function Sounds() {
			throw new Error("No need to instantiate an Sounds object, do not call the constructor directly.");
		}
	}
}
