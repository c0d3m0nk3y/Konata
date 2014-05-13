package {
	import utils.AudioManager;
	
	public class Music {
		public static const SPACE:String = "spacemusic";
		
		private static var _volume:int;
		
		public static function playSong(name:String=SPACE):void {
			AudioManager.playSong(name);
		}
		
		public static function stop():void {
			AudioManager.stopMusic();
		}
		
		public static function set volume(value:int):void {
			_volume = value;
		}
		
		public function Music() {
			throw new Error("No need to instantiate an Music object, do not call the constructor directly.");
		}
	}
}
