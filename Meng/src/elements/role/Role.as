package elements.role
{
	import Lir.GetJson;
	
	import controls.GameManager;
	import controls.Globals;
	
	import elements.jineng.JinengObj;
	import elements.texiao.GJTexiao1;
	
	import game.myGame.PifuChange;
	
	import gameEvent.BtnEvent;
	import gameEvent.BtnEventDispancher;
	
	import lzm.starling.swf.display.SwfMovieClip;
	
	import nape.space.Space;
	
	import screens.UIScreen;
	import screens.ui.tilitiao.Tilitiao;
	
	import starling.events.Event;
	
	
	public class Role extends RoleO
	{
		public function Role(mc:SwfMovieClip, dataObj:Object, _x:Number, _y:Number, w:Number, h:Number, space:Space)
		{
			super(mc, dataObj, _x, _y, w, h, space);
			Globals.player = this;
			
			this.enemyArr = Globals.enemyArr;
			GetJson.getInstance().getLoad("test.txt",this.cbk);
			PifuChange.getInstance().getAllPifuChange(mc,GameManager.getInstance().assetMgr,"ww1");
			BtnEventDispancher.getInstance().addEventListener(BtnEvent.BTN_CLICK,this.onBtn1);
			
		}
		
		private var gjtx:GJTexiao1;
		private function onBtn1(e:Event):void
		{
			
			var _name:String = e.data["_name"];
			var obj:Object = JinengObj[_name];
			trace("=================================================================================================================");
			trace("jineng1 >  "+obj["dongzuoLabel"]+"   ---- "+this.getScaleX()+"   ??this.scaleX   "+this.scaleX);
			if(!gjtx){
				gjtx = new GJTexiao1();		
			}
			gjtx.getSJObj(obj,this,this.enemyArr);
			
			
		}		
		
		private function cbk(obj):void{
			
			ObjVO.getInstance().getVO(obj,this);
			
			
			this.curLive = this.maxLive;
			if(!this._roleLive)this._roleLive = new RoleLive();
			_roleLive.maxLive = this.maxLive;
			_roleLive.curLive = this.curLive;
			UIScreen.getInstance()._xuetiao1.getRoleLive(this);
			
			
			if(!this._roleTili)this._roleTili = new RoleTili();
			this.curTili = this.maxTili;
			_roleTili.maxTili = this.maxTili;
			_roleTili.curTili = this.curTili;
			
			
			Tilitiao.getInstance().getRoleTili(this);
		}
		
		protected override function atkAc():void{
			if(this.getPlayFrameOver()){
				this.isCanAtk = true;
			}
			
			if(this.getPlayFrameOver()){
				this.isCanAtkedMove = true;
			}
			
			super.atkAc();
		}
		
		protected override function baseUpDate():void{
			super.baseUpDate();
		}
	}
}