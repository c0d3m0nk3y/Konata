package objects {
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	
	
	public class Player extends GameObject {
		private var _ship:MovieClip;
		private var _alive:Boolean;
		private var _lasers:Vector.<Laser>;
		private var _timeSinceLastShot:Number;
		private var _secondsBetweenShots:Number;
		
		public function Player() {
			super();
			
			solid = true;
			
			name = "Player";
			
			_alive = true;
			
			_ship = new MovieClip(Assets.getTextures("ship_"), 6);
			_ship.x = Math.ceil(-_ship.width/2);
			_ship.y = Math.ceil(-_ship.height/2);
			Starling.juggler.add(_ship);
			
			_lasers = new Vector.<Laser>();
			
			_timeSinceLastShot = 0;
			_secondsBetweenShots = 1;
		}
		
		override protected function onAddedToStage(event:Event=null):void {
			super.onAddedToStage(event);
			
			addChild(_ship);
		}
		
		override public function advanceTime(time:Number):void {
			super.advanceTime(time);
			
			shootLasers(time);
		}
		
		private function shootLasers(time):void {
			_timeSinceLastShot += time;
			
			if(_timeSinceLastShot > _secondsBetweenShots) {
				_timeSinceLastShot -= _secondsBetweenShots;
				shoot();
			}
			
			removeOldLasers();
		}
		
		private function shoot():void {
			Sounds.playAtVolume(Sounds.PEW, 0.4);
			
			var laser:Laser = new Laser();
			laser.x = x + width * 0.5;
			laser.y = y + (height * 0.25) - (laser.height * 0.5);
			parent.addChild(laser);
			_lasers.push(laser);
		}
		
		private function removeOldLasers():void {
			var laser:Laser;
			for(var laserIndex:int=0; laserIndex < _lasers.length; laserIndex++) {
				laser = _lasers[laserIndex];
				
				if(laser.x > Constants.GameWidth) {
					_lasers.splice(laserIndex, 1);
					laserIndex--;
					laser.removeFromParent(true);
					laser = null;
				}
			}
		}
		
		public function followCursor(cursorY:Number):void {
			if(!_alive) return;
			
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
		
		public function kill():void {
			_alive = false;
		}

		public function get alive():Boolean {
			return _alive;
		}

		public function set alive(value:Boolean):void {
			_alive = value;
		}
	}
}
