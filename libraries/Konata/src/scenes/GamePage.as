package scenes {
	import objects.Enemy;
	import objects.Player;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class GamePage extends Scene {
		
		public static var scrollSpeed:int = 8;
		
		private var _background:Background;
		private var _player:Player;
		private var _touch:Touch;
		private var _touchY:Number;
		private var _timeSinceLastShot:int = 0;
		private var _timeBetweenShots:int = 7;
		private var _leftShot:Boolean;
		private var _enemies:Vector.<Enemy>;
		private var _numEnemies:int = 3;
//		private var _screenShakeIncrement:int;
		private var _screenShakeFactor:int;
		private var _screenShaking:Boolean;
		
		private var _starting:Boolean;
		
		private var _txtStats:TextField;
		
		public function GamePage() {
			super();
			
			_starting = true;
			
			_screenShaking = false;
			_screenShakeFactor = 0;
			
			_player = new Player();
			_player.x = -_player.width * 2;
			_player.y = Constants.GameHeight * 0.5;
			
			_background = new Background();
			
			_enemies = new Vector.<Enemy>();
			for(var i:int = 0; i < _numEnemies; i++) {
				var enemy:Enemy = new Enemy();
				_enemies.push(enemy);
			}
			
			_txtStats = new TextField(Constants.GameWidth * 0.9, Constants.GameHeight * 0.1, "", "Veranda", 16, 0xffffff, true);
			_txtStats.x = Constants.GameWidth * 0.1;
			_txtStats.hAlign = HAlign.LEFT;
		}
		
		public function startScreenShake():void {
			_screenShaking = true;
			_screenShakeFactor = (4 - _player.shield) * 10;//_screenShakeIncrement;
		}
		
		private function shakeScreen():void {
			if(!_screenShaking) return;
			
			if(_screenShakeFactor > 0) {
				this.x = Math.random() * _screenShakeFactor;
				this.y = Math.random() * _screenShakeFactor;
				_screenShakeFactor--;
			} else if(this.x != 0) {
				_screenShaking = false;
				this.x = 0;
				this.y = 0;
			}
		}
		
		override protected function onTouch(touchEvent:TouchEvent=null):void {
			super.onTouch(touchEvent);
			
			if(_starting) return;
			
			_touch = touchEvent.getTouch(stage);
			
			if(_touch) {
				_touchY = _touch.globalY;
			}
		}
		
		override protected function onTick(e:Event=null):void {
			if(_starting) return;
			
			_player.followCursor(_touchY);
			
			shakeScreen();
			
			_txtStats.text = "Score " + _player.score;
		}
		
		override protected function onAddedToStage():void {
			super.onAddedToStage();
			
			addChild(_background);
			
			var playerIntroTween:Tween = new Tween(_player, 1, Transitions.EASE_OUT);
			playerIntroTween.onComplete = onPlayerIntroTween;
			playerIntroTween.animate("x", Constants.GameWidth * 0.15);
			Starling.juggler.add(playerIntroTween);
			addChild(_player);
			
			addChild(_txtStats);
		}
		
		private function onPlayerIntroTween():void {
			_starting = false;
			
			for each(var enemy:Enemy in _enemies) {
				addChild(enemy);
			}
		}
	}
}
