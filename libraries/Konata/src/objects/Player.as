package objects {
	import scenes.GamePage;
	
	public class Player extends AnimatedGameObject {
		
		public function Player() {
			super("playership", 1);
			
			_alive = true;
			_moveSpeed = 400;
			solid = true;
			
			name = "Player";
		}
		
		private var _moveSpeed:int;
		private var _alive:Boolean;
		
		override public function advanceTime(time:Number):void {
			super.advanceTime(time);
			
			if(!_alive) return;
		}
		
		private function die():void {
			_alive = false;
			GamePage.scrollSpeed = 0;
		}
	}
}
