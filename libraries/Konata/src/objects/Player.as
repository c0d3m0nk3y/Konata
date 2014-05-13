package objects {
	import scenes.GamePage;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	
	
	public class Player extends GameObject {
		private var _ship:MovieClip;
		private var _alive:Boolean;
		private var _lasers:Vector.<Laser>;
		private var _timeSinceLastShot:Number;
		private var _secondsBetweenShots:Number;
		private var _maxShield:int;
		private var _shield:int;
		private var _secondsBetweenShieldRegen:Number;
		private var _timeSinceLastShieldRegen:Number;
		private var _shields:Vector.<Image>;
		private var _score:int;
		
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
			
			_shield = _maxShield = 3;
			_timeSinceLastShieldRegen = 0;
			_secondsBetweenShieldRegen = 1;
			
			_score = 0;
			
			var shield0:Image = new Image(Assets.getTexture("shield0"));
			shield0.x = Math.ceil(-shield0.width/2);
			shield0.y = Math.ceil(-shield0.height/2);
			var shield1:Image = new Image(Assets.getTexture("shield1"));
			shield1.x = Math.ceil(-shield1.width/2);
			shield1.y = Math.ceil(-shield1.height/2);
			var shield2:Image = new Image(Assets.getTexture("shield2"));
			shield2.x = Math.ceil(-shield2.width/2);
			shield2.y = Math.ceil(-shield2.height/2);
			
			_shields = new Vector.<Image>();
			_shields.push(shield0);
			_shields.push(shield1);
			_shields.push(shield2);
			
			setShield();
		}
		
		override protected function onAddedToStage(event:Event=null):void {
			super.onAddedToStage(event);
			
			addChild(_ship);
			
			for each(var shield:Image in _shields) {
				addChild(shield);
			}
		}
		
		override public function advanceTime(time:Number):void {
			super.advanceTime(time);
			
			regenShield(time);
			
			shootLasers(time);
			
			laserHitsEnemy();
			
			collideWithEnemy();
			
			removeOldLasers();
		}
		
		private function regenShield(time:Number):void {
			if(!_alive) return;
			
			if(_shield < _maxShield) {
				_timeSinceLastShieldRegen += time;
				
				if(_timeSinceLastShieldRegen >= _secondsBetweenShieldRegen) {
					_timeSinceLastShieldRegen -= _secondsBetweenShieldRegen;
					
					_shield++;
					setShield();
				}
			} else {
				_timeSinceLastShieldRegen = 0;
			}
		}
		
		private function collideWithEnemy():void {
			var collisions:Vector.<GameObject> = Collidables.getCollisions(this);
			
			if(collisions) {
				for each(var gameObject:GameObject in collisions) {
					var enemy:Enemy = gameObject as Enemy;
					if(enemy) {
						takeHit();
						enemy.kill();
					}
				}
			}
		}
		
		private function laserHitsEnemy():void {
			var laserCollisions:Vector.<GameObject>;
			
			for each(var laser:Laser in _lasers) {
				laserCollisions = Collidables.getCollisions(laser);
				
				if(laserCollisions) {
					for each(var collisionObject:GameObject in laserCollisions) {
						var enemy:Enemy = collisionObject as Enemy;
						if(enemy) {
							enemy.kill();
							_score++;
							laser.remove();
						}
					}
				}
			}
		}
		
		private function shootLasers(time):void {
			_timeSinceLastShot += time;
			
			if(_timeSinceLastShot > _secondsBetweenShots) {
				_timeSinceLastShot -= _secondsBetweenShots;
				shoot();
			}
		}
		
		private function shoot():void {
			if(!_alive) return;
			
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
					laser.remove();
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
		
		public function takeHit():void {
			if(_alive) (parent as GamePage).startScreenShake();
			
			if(_shield > 0) {
				_shield--;
				_timeSinceLastShieldRegen = 0;
				
				setShield();
			} else {
				kill();
			}
		}
		
		private function setShield():void {
			removeAllShields();
			if(_shield == 3) {
				_shields[0].visible = true;
			} else if(_shield == 2) {
				_shields[1].visible = true;
			} else if(_shield == 1) {
				_shields[2].visible = true;
			}
		}
		
		private function removeAllShields():void {
			for each(var shield:Image in _shields) {
				shield.visible = false;
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

		public function get score():int
		{
			return _score;
		}


	}
}
