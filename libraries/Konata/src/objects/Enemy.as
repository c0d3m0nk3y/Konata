package objects {
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	
	public class Enemy extends GameObject {
		private var _alive:Boolean;
		private var _enemy:MovieClip;
		private var _yTarget:Number;
		private var _lasers:Vector.<Laser>;
		private var _score:int;
		
		public function Enemy() {
			super();
			
			_alive = true;
			solid = true;
			_velocity.x = randomVelocity();
			_velocity.y = randomVelocity(0.005,0.1);
			
			name = "Enemy";
			
			_enemy = new MovieClip(Assets.getTextures("enemy_"), randomFPS());
			_enemy.x = Math.ceil(-_enemy.width/2);
			_enemy.y = Math.ceil(-_enemy.height/2);
			Starling.juggler.add(_enemy);
			
			x = randomStartPosition();
			y = randomYTarget();
			_yTarget = randomYTarget();
			
			_lasers = new Vector.<Laser>();
			
			_score = 100;
		}
		
		private function randomFPS():Number {
			return 0.5 + Math.random() * 4;
		}
		
		public function randomVelocity(start:Number=100,range:Number=450):Number {
			return start + Math.random() * range;
		}
		
		private function randomYTarget():Number {
			return Constants.GameHeight * 0.1 + (Math.random() * (Constants.GameHeight * 0.9 - height));
		}
		
		override protected function onAddedToStage(event:Event=null):void {
			super.onAddedToStage(event);
			
			addChild(_enemy);
		}
		
		override public function advanceTime(time:Number):void {
			super.advanceTime(time);
			
			move(time);
			
			if(_alive) {
				moveTowardsYTarget();
				
				if(arrivedAtYTarget()) {
					setRandomYTarget();
					shoot();
				}
				
				if(leftScreen()) {
					resetPosition();
				}
			}
			
			laserHitPlayer();
			
			removeOldLasers();
		}
		
		private function laserHitPlayer():void {
			var laserCollisions:Vector.<GameObject>
			
			for each(var laser:Laser in _lasers) {
				laserCollisions = Collidables.getCollisions(laser);
				
				if(laserCollisions) {
					for each(var collisionObject:GameObject in laserCollisions) {
						var player:Player = collisionObject as Player;
						if(player) {
							player.takeHit();
							laser.remove();
						}
					}
				}
			}
		}
		
		private function removeOldLasers():void {
			var laser:Laser;
			for(var laserIndex:int=0; laserIndex < _lasers.length; laserIndex++) {
				laser = _lasers[laserIndex];
				
				if(laser.x < -laser.width) {
					_lasers.splice(laserIndex, 1);
					laserIndex--;
					laser.remove();
					laser = null;
				}
			}
		}
		
		private function shoot():void {
			var laser:Laser = new Laser(Math.random() * 3);
			laser.x = x - laser.width;
			laser.y = y;
			laser.scaleX = laser.scaleY = -1/2;
			laser.velocity.x = -650;
			parent.addChild(laser);
			_lasers.push(laser);
			
			Sounds.playAtVolume(Sounds.PEW, 0.1);
		}
		
		private function randomStartPosition():int {
			return Constants.GameWidth + width + (Math.random() * (Constants.GameWidth * 0.5));
		}
		
		private function move(time:Number):void {
			x -= time * _velocity.x;
		}
		
		private function moveTowardsYTarget():void {
			y -= (y - _yTarget) * _velocity.y;
		}
		
		private function setRandomYTarget():void {
			_yTarget = randomYTarget();
		}
		
		private function arrivedAtYTarget():Boolean {
			return y > _yTarget - 1 && y < _yTarget + 1;
		}
		
		public function resetPosition():void {
			if(!_alive) return;
			
			_velocity.x = randomVelocity();
			_velocity.y = randomVelocity(0.005,0.1);
			x = randomStartPosition();
			_enemy.fps = randomFPS();
		}
		
		private function leftScreen():Boolean {
			return x < -width;
		}
		
		public function kill():void {
			_alive = false;
		}
		
		public function restore():void{
			_alive = true;
			resetPosition();
		}

		public function get score():int
		{
			return _score;
		}

	}
}
