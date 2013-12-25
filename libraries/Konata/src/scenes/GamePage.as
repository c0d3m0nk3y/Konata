package scenes {
	import objects.Player;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.extensions.PDParticleSystem;
	
	public class GamePage extends Scene {
		
		public function GamePage() {
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected var particles:Vector.<PDParticleSystem>;
		
		private var player:Player;
		
		/**
		 * Need to dispose stuff and stop any timers.
		 */
		override public function destroy():void {
			while (particles.length > 0) {
				particles.pop().removeFromParent(true);
			}
			
			super.destroy();
		}
		
		protected function initialise():void {
			initialiseVariables();
			makeUI();
			makeParticles();
		}
		
		protected function initialiseVariables():void {
			player = new Player();
			addChild(player);
		}
		
		protected function makeParticles():void {
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
		
		protected function makeUI():void {
		}
		
		protected function onAddedToStage():void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			initialise();
			
			this.addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		override protected function onKeyDown(keyboardEvent:KeyboardEvent):void {
			if (keyboardEvent.charCode == 13) {
			}
		}
		
		protected function onTick(e:Event=null):void {
		
		}
		
		override protected function onTouch(touchEvent:TouchEvent=null):void {
			var touch:Touch = touchEvent.getTouch(this);
			
			if (touch) {
				player.x = touch.globalX;
				player.y = touch.globalY;
			}
		}
	}
}
