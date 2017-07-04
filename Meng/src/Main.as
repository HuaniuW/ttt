package
{
	
	import controls.GameManager;
	
	import gameEvent.GameEvent;
	
	import loadingScreen.LoadingScreen;
	
	import lzm.starling.STLMainClass;
	import lzm.starling.swf.Swf;
	
	import screens.GameScreen;
	

	public class Main extends STLMainClass
	{
		private var _gMgr:GameManager;
		public function Main()
		{
			super();
			Swf.init(this);
			_gMgr = GameManager.getInstance();
			trace(">萌萌");
			//note5 2560×1440
			addEvent();
			LoadingScreen.getInstance().loadLoadingPage(this,["loadingPage"],GameEvent.THELOADINGPAGE,LogoAssets,"GameLogo");
		}
		
		
		private function addEvent():void
		{
			_gMgr.addEventListener(GameEvent.THELOADINGPAGE,getLoadingPage);
			_gMgr.addEventListener(GameEvent.LODINGOVER,onLoadingOver);
		}
		
		private function getLoadingPage(e:GameEvent):void
		{
			LoadingScreen.getInstance().show(this,["UI","rolejc2","texiao"],GameEvent.LODINGOVER);
		}
		
		private function onLoadingOver(e:GameEvent):void
		{
			trace(">资源加载完毕");
			this.view();
		}
		
		private function view():void
		{
			GameScreen.getInstance().onParent(this);
		}
	}
}