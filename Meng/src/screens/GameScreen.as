package screens
{
	import controls.Globals;
	import controls.Napes;
	
	import game.engine.Engine;
	import game.joyStick.MyKeyBoardTest;
	import game.myGame.ScreenBase;
	
	import gameEvent.BtnEvent;
	import gameEvent.BtnEventDispancher;
	
	import starling.core.Starling;
	
	public class GameScreen extends ScreenBase
	{
		
		public function GameScreen()
		{
			super();
			trace(">GameScreen");
			
			view();
		}
		
		private function view():void
		{
			
			GameMapScreen.getInstance().onParent(this);
			UIScreen.getInstance().onParent(this);
			/**键盘控制器*/
			controlBar();
			Engine.createEngine().push(upDate);
		}
		private function upDate():void{
			Napes.instance.space.step(1/60,30);
			if(Globals.isKeyBorad)gameControl();
		}
		
		private function gameControl():void{
			if(MyKeyBoardTest.up)Globals.player.jump();
			Globals.player.isRunLeft = MyKeyBoardTest.left;
			Globals.player.isRunRight = MyKeyBoardTest.right;
			if(MyKeyBoardTest.atk){
				if(!Globals.player._isDongzuoing)Globals.player.atk();
			}
			if(MyKeyBoardTest.avoid){
				if(!Globals.player._isDongzuoing)Globals.player.avoid();
			}
			if(MyKeyBoardTest.btn1C){
				if(!Globals.player._isDongzuoing){
					BtnEventDispancher.getInstance().dispatchEvent(new BtnEvent(BtnEvent.BTN_CLICK,false,{"_name":"chongjijian"}));
				}
			}
		}
		
		private static var _instance:GameScreen;
		public static function getInstance():GameScreen{
			if(!_instance)_instance = new GameScreen();
			return _instance;
		}
		
		private function controlBar():void
		{
			if(Globals.isKeyBorad){
				MyKeyBoardTest.getInstance().init(Starling.current.stage);	
			}else{
				BtnUI.getInstance().getRole(Globals.player);
				BtnUI.getInstance().onStage(this);
			}
		}
		
		
		
		
		
		
	}
}