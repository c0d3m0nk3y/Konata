package scenes {
	import objects.AnimatedGameObject;
	
	public class Background extends AnimatedGameObject {
		public static const GRAND_TECH:String = "grandtech";
		public static const RACING_TRACK:String = "racingtrack";
		public static const TEMPLE_LANE:String = "templelane";
		
		public function Background(spriteSheetName:String, frames:int) {
			super(spriteSheetName, frames, Constants.GameWidth, Constants.GameHeight);
			fps = 3;
		}
	}
}
