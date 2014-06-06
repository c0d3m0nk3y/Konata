package scenes {
	import Events.ShipEvent;
	
	import objects.Enemy;
	import objects.GameOverPanel;
	import objects.MessageBar;
	import objects.Player;
	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Quad;
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
		private var _screenShakeFactor:int;
		private var _screenShaking:Boolean;
		
		private var _starting:Boolean;
		
		private var _txtStats:TextField;
		private var _gameOverShown:Boolean;
		
		private var _greyCover:Quad;
		
		private var _messageBar:MessageBar;
		private var _nextLevelDelayedCall:DelayedCall;
		
		public function GamePage() {
			super();
			
			_starting = true;
			
			_screenShaking = false;
			_screenShakeFactor = 0;
			
			_player = new Player();
			
			_background = new Background();
			
			createEnemies();
			
			_txtStats = new TextField(Constants.GameWidth * 0.9, Constants.GameHeight * 0.1, "", "Veranda", 16, 0xffffff, true);
			_txtStats.x = Constants.GameWidth * 0.1;
			_txtStats.hAlign = HAlign.LEFT;
			
			_greyCover = new Quad(Constants.GameWidth, Constants.GameHeight, 0x0);
			_greyCover.touchable = false;
			_greyCover.alpha = 0.7;
			
			_messageBar = new MessageBar();
			_messageBar.touchable = false;
		}
		
		private function createEnemies():void {
			_enemies = new Vector.<Enemy>();
			for(var i:int = 0; i < _numEnemies; i++) {
				var enemy:Enemy = new Enemy();
				_enemies.push(enemy);
				enemy.addEventListener(ShipEvent.DEATH, onEnemyDeath);
			}
		}
		
		private function onEnemyDeath(event:Event=null):void{
			Support.log("foo");
		}
		
		private function showMessage(message:String, delay:Number=5):void {
			_messageBar.setMessage(message);
			addChild(_messageBar);
			Starling.juggler.add(new DelayedCall(removeMessageBar, delay));
		}
		
		private function startLevelTimer():void {
			_nextLevelDelayedCall = new DelayedCall(nextLevel, 30);
			Starling.juggler.add(_nextLevelDelayedCall);
		}
		
		protected function nextLevel():void {
			if(!_player.alive) return;
			
			showMessage("Enemy reinforcements are arriving!");
			_numEnemies++;
			var enemy:Enemy = new Enemy();
			_enemies.push(enemy);
			addChild(enemy);
			
			startLevelTimer();
		}
		
		private function removeMessageBar():void {
			removeChild(_messageBar);
		}
		
		public function startScreenShake():void {
			_screenShaking = true;
			_screenShakeFactor = (4 - _player.shield) * 10;
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
			
			if(!_player.alive && !_gameOverShown) {
				_gameOverShown = true;
				warpAllEnemiesOff();
				Starling.juggler.add(new DelayedCall(showGameOver,2));
			}
		}
		
		override protected function onAddedToStage():void {
			super.onAddedToStage();
			
			addChild(_background);
			
			tweenPlayerIn();
			
			addChild(_txtStats);
		}
		
		private function tweenPlayerIn():void {
			_player.x = -_player.width * 2;
			_player.y = Constants.GameHeight * 0.5;
			var playerIntroTween:Tween = new Tween(_player, 1, Transitions.EASE_OUT);
			playerIntroTween.onComplete = onPlayerIntroTween;
			playerIntroTween.animate("x", Constants.GameWidth * 0.15);
			Starling.juggler.add(playerIntroTween);
			addChild(_player);
		}
		
		private function restartGame():void {
			removeChild(_greyCover);
			
			_player.restore();
			_gameOverShown = false;
			tweenPlayerIn();
			
			for each(var enemy:Enemy in _enemies) {
				enemy.restore();
			}
		}
		
		private function showGameOver():void {
			addChild(_greyCover);
			
			restoreNumEnemiesToDefault();
			
			var gameOverPanel:GameOverPanel = new GameOverPanel(restartGame);
			gameOverPanel.pivotX = gameOverPanel.width / 2;
			gameOverPanel.pivotY = gameOverPanel.height / 2;
			gameOverPanel.x = Constants.GameWidth / 2;
			gameOverPanel.y = Constants.GameHeight / 2;
			gameOverPanel.scaleX = 0;
			gameOverPanel.scaleY = 0;
			
			addChild(gameOverPanel);
			
			var gameOverTween:Tween = new Tween(gameOverPanel, 0.5, Transitions.EASE_IN);
			gameOverTween.animate("scaleX", 1);
			gameOverTween.animate("scaleY", 1);
			Starling.juggler.add(gameOverTween);
			
			Starling.juggler.remove(_nextLevelDelayedCall);
		}
		
		private function restoreNumEnemiesToDefault():void {
			while(_enemies.length > 3) {
				var enemy:Enemy = _enemies.pop();
				enemy.removeFromParent(true);
				_numEnemies = 3;
			}
		}
		
		private function warpAllEnemiesOff():void {
			for each(var enemy:Enemy in _enemies) {
				enemy.velocity.x *= 3;
				enemy.kill();
			}
		}
		
		private function onPlayerIntroTween():void {
			_starting = false;
			
			for each(var enemy:Enemy in _enemies) {
				addChild(enemy);
			}
			
			startLevelTimer();
		}
	}
}
