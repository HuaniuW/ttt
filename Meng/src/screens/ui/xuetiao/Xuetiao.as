package screens.ui.xuetiao
{
	import controls.GameManager;
	
	import elements.I.Ibiont;
	import elements.role.RoleLive;
	
	import game.engine.Engine;
	import game.myGame.ScreenBase;
	
	import lzm.starling.swf.display.SwfScale9Image;
	import lzm.starling.swf.display.SwfSprite;
	
	public class Xuetiao extends ScreenBase implements IUIXuetiao
	{
		public function Xuetiao()
		{
			super();
			init();
		}
		
//		private static var _instance:Xuetiao;
//		public static function getInstance():Xuetiao{
//			if(!_instance)_instance = new Xuetiao();
//			return _instance;
//		}
		
		private var _theChangdu:Number = 100;
		
		private var _xuetiao:SwfSprite;
		private var bar1:SwfScale9Image;
		private var bar2:SwfScale9Image;
		private var d:SwfScale9Image;
		private function init():void{
			if(!this._xuetiao)this._xuetiao = GameManager.getInstance().assetMgr.createSprite("spr_UI_xuetiao1");	
			this.addChild(this._xuetiao);
			bar1 = this._xuetiao.getScale9Image("bar1");
			bar2 = this._xuetiao.getScale9Image("bar2");
			d = this._xuetiao.getScale9Image("d");
			this.setChangdu();
			bar1.y = bar2.y = 3;
			bar1.x = bar2.x = 3;
			
			Engine.createEngine().push(action);
		}
		
		public function getScaleX(_sx:int = 1):void{
			if(this._xuetiao)this._xuetiao.scaleX = _sx;
		}
		
		private function action():void{
			if(!_roleLive)return;
			getXChange();
			if(bar1.width>bar2.width+1){
				bar1.width+=(bar2.width-bar1.width)*0.05;
//				bar1.width-=2;
			}else{
				bar1.width = bar2.width;
				bar1.visible = bar2.visible;
			}
		}
		
		private var _roleLive:RoleLive;
		public function getRoleLive(biont:Ibiont):void{
			this._roleLive = biont.getRoleLive();
		}
		
		
		public function getXChange():void
		{
			if(_roleLive.curLive>_roleLive.maxLive){
				_roleLive.curLive = _roleLive.maxLive;
			}
			if(_roleLive.curLive<=0){
				_roleLive.curLive = 0;
				bar2.visible = false;
			}
			bar2.width = _roleLive.curLive/_roleLive.maxLive*_theChangdu;
		}
		
		public function setGaodu(num:Number=0):void
		{
			/**小于30会错位变形*/
			if(num<30)num = 30;
			if(num!=0){
				_xuetiao.height = num;
			}
			bar1.height = bar2.height = _xuetiao.height;
		}
		
		
		public function setChangdu(num:Number=0):void
		{
			if(num!=0){
				d.width = num;
			}
			
			_theChangdu = bar1.width = bar2.width = d.width-7;
			
		}
		
	}
}