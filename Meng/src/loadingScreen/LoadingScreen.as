package loadingScreen
{
	import flash.filesystem.File;
	
	import getAssets.GetAsset;
	
	import lzm.starling.STLConstant;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.formatString;
	import controls.GameManager;
	import gameEvent.GameEvent;
	
	public class LoadingScreen extends Sprite
	{
		public function LoadingScreen()
		{
			super();
		}
		private static var _instance:LoadingScreen;
		
		/**
		 *资源背景 
		 * @param imgAssets 资源类
		 * @param bgImgName 背景图片名字
		 * 
		 */		
		private function view(imgAssets:Class,bgImgName:String):void
		{ 
			if(!imgAssets)return;
			var bgImg:Image = new Image(GetAsset.getTexture(imgAssets,bgImgName));
			addChild(bgImg);
			bgImg.y = 100;
		}
		
		public static function getInstance():LoadingScreen{
			if(!_instance)_instance = new LoadingScreen();
			return _instance;
		}
		
		private var textfield:TextField;
		private var _screenName:String;
		public function show(container:DisplayObjectContainer, urlArr:Array,screenName:String, bgImgClass:Class=null, bgImg:String=""):void{
			if(!urlArr.length)return;
			view(bgImgClass,bgImg);
			container.addChild(this);
			if(!textfield)textfield = new TextField(200,100,"Loading...","黑体",14,0xffffff);
			textfield.x = (STLConstant.StageWidth - textfield.width)/2+100;
			textfield.y = (STLConstant.StageHeight - textfield.height)/2+50;
			addChild(textfield);
			_screenName = screenName;
			var file:File;
			var root:String;
			for(var i:String in urlArr){
				root = formatString("assets/{0}x/"+urlArr[i]+"/",STLConstant.scale);
//				trace("root: "+root);
				file = File.applicationDirectory.resolvePath(root);
				//排入列队
				GameManager.getInstance().assetMgr.enqueue(urlArr[i],[file],40);
			}		
//			GameManager.getInstance().assetMgr.enqueueWithArray([["role",["role"],40],["map",["map"],0]]);
			GameManager.getInstance().assetMgr.verbose = true;
			GameManager.getInstance().assetMgr.loadQueue(loadFunc);
		}
		
		private function loadFunc(ratio:Number):void
		{
			textfield.text = "loading...." + int(ratio*100)+"%";
			if(ratio == 1)
			{
				this.removeSelf();
				GameManager.getInstance().dispatchEvent(new GameEvent(_screenName));
			}
		}
		
		public function removeSelf(isDelete:Boolean=false):void
		{
			this.removeFromParent(isDelete);
		}
	}
}