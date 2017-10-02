package loadingScreen
{
	import com.greensock.TweenLite;
	
	import flash.filesystem.File;
	
	import controls.GameManager;
	
	import gameEvent.GameEvent;
	
	import getAssets.GetAsset;
	
	import lzm.starling.STLConstant;
	import lzm.starling.swf.display.SwfScale9Image;
	import lzm.starling.swf.display.SwfSprite;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.formatString;
	
	public class LoadingScreen extends Sprite
	{
		private var textfield:TextField;
		private var _screenNameEvent:String;
		private var _urlArr:Array;
		private var logoImage:Image;
		
		public function LoadingScreen()
		{
			super();
		}
		
		private static var _instance:LoadingScreen;
		public static function getInstance():LoadingScreen{
			if(!_instance)_instance = new LoadingScreen();
			return _instance;
		}
		
		/**
		 * 1.显示图片logo 
		 * 2.默认后台加载loading需要的资源
		 * 3.图片渐隐
		 * 4.进入loading 界面 开始loading资源
		 * 
		 * loading 显示流程   logo渐隐 后 渐显loading 开始loading
		 */
		public function loadLoadingPage(container:DisplayObjectContainer, urlArr:Array,screenNameEvent:String, bgImgClass:Class=null, bgImgName:String=""):void{
			if(!urlArr.length)return;
			container.addChild(this);
			_urlArr = urlArr;
			_screenNameEvent = screenNameEvent;
			view(bgImgClass,bgImgName);
		}
		
		/**
		 *资源背景 
		 * @param imgAssets 资源类
		 * @param bgImgName 背景图片名字
		 * 
		 */		
		private function view(imgAssets:Class,bgImgName:String):void
		{ 
			if(!imgAssets)return;
			logoImage = new Image(GetAsset.getTexture(imgAssets,bgImgName));
			addChild(logoImage);
			logoImage.scaleX = logoImage.scaleY =  STLConstant.scale*0.5;
			logoImage.x = (STLConstant.StageWidth - logoImage.width)*0.5;
			logoImage.y = (STLConstant.StageHeight - logoImage.height)*0.5;
			logoImage.alpha = 0;
			TweenLite.to(logoImage,1,{"alpha":1,"onComplete":cComplete});
		}
		
		private function cComplete():void{
			var file:File;
			var root:String;
			for(var i:String in _urlArr){
				root = formatString("assets/{0}x/"+_urlArr[i]+"/",STLConstant.scale);
				//				trace("root: "+root);
				file = File.applicationDirectory.resolvePath(root);
				//排入列队
				GameManager.getInstance().assetMgr.enqueue(_urlArr[i],[file],60);
			}		
			GameManager.getInstance().assetMgr.verbose = true;
			GameManager.getInstance().assetMgr.loadQueue(loadingAssetsOver);
		}
		
		private function loadingAssetsOver(ratio:Number):void
		{
			if(ratio == 1){
				TweenLite.to(logoImage,1,{"alpha":0,"onComplete":logoHide});
			}
		}		
		
		private function logoHide():void{
			logoImage.removeFromParent();
			showLoadPage();
		}
		
		
		private var _bg:SwfScale9Image;
		private var _sc:SwfSprite;
		private var _tiao:SwfScale9Image;
		private var _loadingBar:SwfSprite;
		private function showLoadPage():void
		{
			if(!_bg){
				_bg = GameManager.getInstance().assetMgr.createS9Image("s9_loadingPage_bg");
			}
			addChild(_bg);
			_bg.width = STLConstant.StageWidth;
			_bg.height = STLConstant.StageHeight;
			
			_bg.alpha = 0;
			TweenLite.to(_bg,1,{"alpha":1,"onComplete":bgShowOver});
			
		}
		
		private function bgShowOver():void{
			_sc = GameManager.getInstance().assetMgr.createSprite("spr_loadingPage_sc");
			addChild(_sc);
			_sc.alpha = 0;
			_sc.x = (STLConstant.StageWidth - _sc.width)*0.5;
			_sc.y = (STLConstant.StageHeight - _sc.height)*0.5;
			TweenLite.to(_sc,1,{"alpha":1,"onComplete":scShowOver});
		}
		
		private function scShowOver():void{
			_loadingBar = _sc.getSprite("bar");
			_tiao = _loadingBar.getScale9Image("tiao"); 
			GameManager.getInstance().dispatchEvent(new GameEvent(GameEvent.THELOADINGPAGE));
		}
		
		
		
		
		
		public function show(container:DisplayObjectContainer, urlArr:Array,screenNameEvent:String, bgImgClass:Class=null, bgImgName:String=""):void{
			if(!urlArr.length)return;
			view(bgImgClass,bgImgName);
			container.addChild(this);
			if(!textfield)textfield = new TextField(100,100,"","黑体",38,0x382B2B);
			if(_sc){
				textfield.x = _sc.x+412;
				textfield.y = _sc.y+358;	
			}
			
			addChild(textfield);
			_screenNameEvent = screenNameEvent;
			var file:File;
			var root:String;
			for(var i:String in urlArr){
				root = formatString("assets/{0}x/"+urlArr[i]+"/",STLConstant.scale);
//				trace("root: "+root);
				file = File.applicationDirectory.resolvePath(root);
				//排入列队
				GameManager.getInstance().assetMgr.enqueue(urlArr[i],[file],60);
			}		
//			GameManager.getInstance().assetMgr.enqueueWithArray([["role",["role"],40],["map",["map"],0]]);
			GameManager.getInstance().assetMgr.verbose = true;
			GameManager.getInstance().assetMgr.loadQueue(loadFunc);
		}
		
		private function loadFunc(ratio:Number):void
		{
			textfield.text = "" + int(ratio*100)+"%";
			trace(textfield.text);
			if(_tiao)_tiao.width  = int(ratio*100)/100*_loadingBar.width-5;
			if(ratio == 1)
			{
				this.removeSelf();
				GameManager.getInstance().dispatchEvent(new GameEvent(_screenNameEvent));
			}
		}
		
		public function removeSelf(isDelete:Boolean=false):void
		{
			this.removeFromParent(isDelete);
		}
	}
}