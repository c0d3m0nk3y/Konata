package objects {
	import starling.display.Image;
	import starling.events.Event;
	
	public class PowerUp extends GameObject {
		public static const RANDOM:int = -1;
		public static const SHIELD:int = 0;
		public static const LASER:int = 1;
		public static const SPEED:int = 2;
		
		private var _powerUp:Image;
		private var _type:int;
		
		public function PowerUp(xVelocity:Number, type:int=RANDOM) {
			super();
			
			_velocity.x = xVelocity;
			
			if(type == RANDOM) { // no type specified
				_type = Math.random() * 3; // random type
			} else {
				_type = type;
			}
			
			_powerUp = new Image(Assets.getTexture("powerup_" + _type));
			_powerUp.x = Math.ceil(-_powerUp.width/2);
			_powerUp.y = Math.ceil(-_powerUp.height/2);
		}
		
		override protected function onAddedToStage(event:Event=null):void {
			super.onAddedToStage(event);
			
			addChild(_powerUp);
		}
		
		private function detectPlayerPickup():void {
			var collisions:Vector.<GameObject> = Collidables.getCollisions(this);
			
			for each(var collision:GameObject in collisions) {
				var player:Player = collision as Player;
				if(player) {
					player.enablePowerUp(_type);
					destroy();
				}
			}
		}
		
		private function destroy():void {
			if(contains(_powerUp)) removeChild(_powerUp, true);
			removeFromParent(true);
		}
		
		override public function advanceTime(time:Number):void {
			super.advanceTime(time);
			
			detectPlayerPickup();
			
			move(time);
		}
		
		private function move(time:Number):void {
			x -= time * _velocity.x;
		}
	}
}
