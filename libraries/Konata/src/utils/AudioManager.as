package utils
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import starling.core.Starling;
	
	public class AudioManager
	{
		private var music:Sound;
		private var pop:Sound;
		
		public static const MUSIC_LEVEL:Number = 0.25;
		
		private var musicChannel:SoundChannel;
		
		private var transform:SoundTransform = new SoundTransform(AudioManager.MUSIC_LEVEL);
		
		public function AudioManager()
		{
			pop = Konata.assets.getSound("pop");
			
		}
		
		public function playPop():void
		{
			pop.play();
		}
		
		public function setMusic(sound:Sound):void
		{
			music = sound;
		}
		
		public function setMusicVolume(vol:Number):void
		{
			musicChannel.soundTransform.volume = vol;
		}
		
		public function pauseMusic():void {
			SoundMixer.soundTransform = new SoundTransform(0);
		}
		
		public function resumeMusic():void {
			SoundMixer.soundTransform = new SoundTransform(1);
		}
		
		public function playMusic():void
		{
			stopMusic();
			SoundMixer.soundTransform = new SoundTransform(1);
			musicChannel = music.play(0, 9999, transform);
		}
		
		public function stopMusic():void
		{
			musicChannel.stop();
		}
		
		public function playDelayedSounds(soundFunction:Function, delay:Number, repeat:int, repeatDelay:Number):void
		{
			//			Support.log("OSounds.playDelayedSounds delay " + delay + ", repeat " + repeat + ", repeatDelay " + repeatDelay); 
			Starling.juggler.delayCall(startSoundTimer, delay, soundFunction, repeat, repeatDelay);
		}
		
		private function startSoundTimer(soundFunction:Function, repeat:int, delay:Number):void
		{
			//			Support.log("OSounds.startSoundTimer delay " + delay + ", repeat " + repeat);
			for(var i:int = 0; i < repeat; i++)
			{
				Starling.juggler.delayCall(soundFunction, delay + i * delay);
			}
		}
	}
}