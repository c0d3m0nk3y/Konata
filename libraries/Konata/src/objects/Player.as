package objects {
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	
	
	public class Player extends GameObject {
		private var _ship:MovieClip;
		
		public function Player() {
			super();
			
			solid = true;
			
			name = "Player";
			
			_ship = new MovieClip(Assets.getTextures("ship_"), 6);
			_ship.x = Math.ceil(-_ship.width/2);
			_ship.y = Math.ceil(-_ship.height/2);
			Starling.juggler.add(_ship);
		}
		
		override protected function onAddedToStage(event:Event=null):void {
			super.onAddedToStage(event);
			
			addChild(_ship);
		}
		
		public function followCursor(cursorY:Number):void {
			flyTowardsCursor(cursorY);
			keepWithinScreenBounds();
		}
		
		private function flyTowardsCursor(cursorY:Number):void {
			if(!isNaN(cursorY)) {
				y -= (y - cursorY) * 0.075;
			}
		}
		
		private function keepWithinScreenBounds():void {
			if(y > Constants.GameHeight - height * 0.5) {
				y = Constants.GameHeight - height * 0.5;
			} else if(y < height * 0.5) {
				y = height * 0.5;
			}
		}
	}
}
