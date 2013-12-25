package objects {
	
	public class Player extends AnimatedGameObject {
		public function Player() {
			super("cherub", 12);
			
			pivotX = width * 0.5;
			pivotY = height * 0.5;
		}
	}
}
