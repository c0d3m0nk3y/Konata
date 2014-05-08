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
			_velocity.x = 200;
			
			name = "Enemy";
			
			_enemy = new MovieClip(Assets.getTextures("enemy_"), 1);
			_enemy.x = Math.ceil(-_enemy.width/2);
			_enemy.y = Math.ceil(-_enemy.height/2);
			Starling.juggler.add(_enemy);
			
			x = Constants.GameWidth + width;
			y = randomYTarget();
			_yTarget = randomYTarget();
		}
		
		private function randomYTarget():Number {
			return Math.random() * (Constants.GameHeight - height);
		}
		
		override protected function onAddedToStage(event:Event=null):void {
			super.onAddedToStage(event);
			
			addChild(_enemy);
		}
		
		override public function advanceTime(time:Number):void {
			super.advanceTime(time);
			
			move(time);
		}
		
		private function move(time:Number):void {
			x -= time * _velocity.x;
			
			y -= (y - _yTarget) * 0.2;
			
			if(y > _yTarget - 1 && y < _yTarget + 1) {
				_yTarget = randomYTarget();
			}
			
			if(x - width < 0) {
				x = Constants.GameWidth + width;
			}
		}
	}
}
