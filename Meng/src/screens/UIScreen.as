package screens
{
	
	import game.myGame.ScreenBase;
	
	import lzm.starling.STLConstant;
	
	import screens.ui.tilitiao.Tilitiao;
	import screens.ui.xuetiao.Xuetiao;
	
	public class UIScreen extends ScreenBase
	{
		public function UIScreen()
		{
			super();
			init();
		}
		
		private static var _instance:UIScreen;
		public static function getInstance():UIScreen{
			if(!_instance)_instance = new UIScreen();
			return _instance;
		}
		
		
		public var _xuetiao1:Xuetiao;
		public var _xuetiao2:Xuetiao;
		private function init():void{
//			Xuetiao.getInstance().onParent(this,30,30);
			if(!this._xuetiao1)this._xuetiao1 = new Xuetiao();
			_xuetiao1.onParent(this,30,30);
			
			if(!this._xuetiao2)this._xuetiao2 = new Xuetiao();
			_xuetiao2.onParent(this,STLConstant.StageWidth - 30 ,80);
			_xuetiao2.getScaleX(-1);
			
//			Xuetiao.getInstance().getXChange(-80);
			
			Tilitiao.getInstance().onParent(this,30,70);
//			Tilitiao.getInstance().tiliChange(-80);
//			Tilitiao.getInstance().rest(80);
		}
		
		
		
	}
}