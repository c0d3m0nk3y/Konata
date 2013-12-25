package utils {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	public class AudioManager {
		
		public static const MUSIC_LEVEL:Number = 0.25;
		
		private static var _instance:AudioManager;
		
		public static function playMusic():void {
			instance.playMusic();
		}
		
		public static function playSound(name:String, startTime:Number=0, loops:int=0, transform:SoundTransform=null):SoundChannel {
			return instance.playSound(name, startTime, loops, transform);
		}
		
		public static function silenceAll():void {
			instance.silenceAll();
		}
		
		public static function unsilenceAll():void {
			instance.unsilenceAll();
		}
		
		private static function get instance():AudioManager {
			return _instance ? _instance : new AudioManager();
		}
		
		public function AudioManager() {
			if (_instance) {
				throw new Error("AudioManager is a singleton, do not call the constructor directly.");
			}
			_instance = this;
		}
		
		private var music:Sound;
		private var musicChannel:SoundChannel;
		
		private var transform:SoundTransform = new SoundTransform(AudioManager.MUSIC_LEVEL);
		
		private function silenceAll():void {
			SoundMixer.soundTransform.volume = 0;//new SoundTransform(0);
		}
		
		private function unsilenceAll():void {
			SoundMixer.soundTransform.volume = 1;//new SoundTransform(1);
		}
		
		private function pauseMusic():void {
			SoundMixer.soundTransform = new SoundTransform(0);
		}
		
		private function playMusic():void {
			stopMusic();
			SoundMixer.soundTransform = new SoundTransform(1);
			musicChannel = music.play(0, 9999, transform);
		}
		
		private function playSound(name:String, startTime:Number=0, loops:int=0, transform:SoundTransform=null):SoundChannel {
			return Assets.playSound(name, startTime, loops, transform);
		}
		
		private function resumeMusic():void {
			SoundMixer.soundTransform = new SoundTransform(1);
		}
		
		private function setMusic(sound:Sound):void {
			music = sound;
		}
		
		private function setMusicVolume(vol:Number):void {
			musicChannel.soundTransform.volume = vol;
		}
		
		private function stopMusic():void {
			musicChannel.stop();
		}
	}
}
