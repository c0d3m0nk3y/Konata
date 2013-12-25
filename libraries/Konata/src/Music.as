package {
	import utils.AudioManager;
	
	public class Music {
		public static const RETRO:String = "retro";
		
		private static var _volume:int;
		
		public static function playSong(name:String):void {
			AudioManager.playSong(name);
		}
		
		public static function set volume(value:int):void {
			_volume = value;
		}
		
		public function Music() {
			throw new Error("No need to instantiate an Music object, do not call the constructor directly.");
		}
	}
}
