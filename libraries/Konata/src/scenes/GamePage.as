package scenes {
	import objects.Player;
	
	import starling.core.Starling;
	import starling.extensions.PDParticleSystem;
	
	public class GamePage extends Scene {
		
		public function GamePage() {
			super();
		}
		
		protected var particles:Vector.<PDParticleSystem>;
		
		private var player:Player;
		
		override public function destroy():void {
			while (particles.length > 0) {
				particles.pop().removeFromParent(true);
			}
			
			super.destroy();
		}
		
		override protected function initialise():void {
			super.initialise();
			
			initialiseVariables();
			makeParticles();
		}
		
		private function initialiseVariables():void {
			makePlayer();
			addChild(player);
		}
		
		private function makeParticles():void {
			particles = new Vector.<PDParticleSystem>();
			for (var i:int = 0; i < 10; i++) {
				var particle:PDParticleSystem = new PDParticleSystem(XML(new ParticleAssets.ParticleXML()), Assets.getTexture("small"));
				Starling.juggler.add(particle);
				particle.scaleX = 0.5;
				particle.scaleY = 0.5;
				this.addChild(particle);
				particles.push(particle);
			}
		}
		
		private function makePlayer():void {
			player = new Player();
			player.fps = 6;
			player.x = Constants.CenterX;
			player.y = Constants.CenterY;
		}
	}
}
