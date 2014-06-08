package Effects {
	import objects.Player;
	
	public class PlayerAttackSpeedEffect extends Effect {
		public static const TYPE:String = "PlayerAttackSpeed";
		private static const DEFAULT_DURATION:Number=15;
		private var _player:Player;
		
		public function PlayerAttackSpeedEffect(player:Player, duration:Number=DEFAULT_DURATION) {
			super(TYPE, duration);
			_player = player;
		}
		
		override public function applyEffect():void {
			super.applyEffect();
			
			_player.secondsBetweenShots = Player.SECONDS_BETWEEN_SHOTS_DEFAULT * 0.5;
		}
		
		override protected function durationReached():void {
			super.durationReached();
			_player.secondsBetweenShots = Player.SECONDS_BETWEEN_SHOTS_DEFAULT;
			_player.removeEffect(this);
		}
	}
}
