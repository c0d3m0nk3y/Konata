package objects {
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	
	public class Enemy extends GameObject {
		private var _enemy:MovieClip;
		private var _yTarget:Number;
		
		public function Enemy() {
			super();
			
			solid = true;
			_velocity.x = randomVelocity();
			
			name = "Enemy";
			
			_enemy = new MovieClip(Assets.getTextures("enemy_"), randomFPS());
			_enemy.x = Math.ceil(-_enemy.width/2);
			_enemy.y = Math.ceil(-_enemy.height/2);
			Starling.juggler.add(_enemy);
			
			x = randomStartPosition();
			y = randomYTarget();
			_yTarget = randomYTarget();
		}
		
		private function randomFPS():Number {
			return 0.5 + Math.random() * 4;
		}
		
		public function randomVelocity():int {
			return 100 + Math.random() * 450;
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
		}
		
		private function shoot():void {
			var laser:Laser = new Laser("red");
			laser.x = x - laser.width;
			laser.y = y;
			laser.scaleX = laser.scaleY = -1/2;
			laser.velocity.x = -650;
			parent.addChild(laser);
			
			Sounds.playAtVolume(Sounds.PEW, 0.1);
		}
		
		private function randomStartPosition():int {
			return Constants.GameWidth + width + Math.random() * Constants.GameWidth;
		}
		
		private function move(time:Number):void {
			x -= time * _velocity.x;
			
			y -= (y - _yTarget) * 0.1;
			
			if(y > _yTarget - 1 && y < _yTarget + 1) {
				shoot();
				_yTarget = randomYTarget();
			}
			
			if(x < -width) {
				_velocity.x = randomVelocity();
				x = randomStartPosition();
				_enemy.fps = randomFPS();
			}
		}
	}
}
