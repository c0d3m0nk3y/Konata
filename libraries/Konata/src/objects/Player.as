package objects {
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	
	
	public class Player extends GameObject {
		private var _ship:MovieClip;
		
		public function Player() {
			super();
			
			_alive = true;
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
		
		private var _alive:Boolean;
		
		override public function advanceTime(time:Number):void {
			super.advanceTime(time);
			
			if(!_alive) return;
		}
		
		private function die():void {
			_alive = false;
		}
		
		public function followCursor(cursorY:Number):void {
			flyTowardsCursor(cursorY);
			keepWithinScreenBounds();
		}
		
		private function flyTowardsCursor(cursorY:Number):void {
			if(!isNaN(cursorY)) {
				y -= (y - cursorY) * 0.1;
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
