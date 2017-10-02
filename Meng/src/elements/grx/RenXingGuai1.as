package elements.grx
{
	import AI.aifas.AIfn2;
	import AI.aifas.AIfn3;
	
	import Lir.GetJson;
	
	import controls.GameManager;
	import controls.Globals;
	
	import elements.role.ObjVO;
	import elements.role.RoleLive;
	import elements.role.RoleO;
	import elements.role.RoleTili;
	import elements.role.ZhuangTaiChange;
	
	import game.myGame.PifuChange;
	
	import lzm.starling.swf.display.SwfMovieClip;
	
	import nape.space.Space;
	
	import screens.UIScreen;
	
//	import starling.filters.BlurFilter;
	
	public class RenXingGuai1 extends RoleO
	{
		private var _zhuangTaiChange:ZhuangTaiChange;
		public function RenXingGuai1(mc:SwfMovieClip, dataObj:Object, _x:Number, _y:Number, w:Number, h:Number, space:Space)
		{
			super(mc, dataObj, _x, _y, w, h, space);
			PifuChange.getInstance().getPifuChange(mc,GameManager.getInstance().assetMgr.createImage("img_jc_wuqi2"),"img_jc_wuqi1");
//			PifuChange.getInstance().getPifuChange(mc,GameManager.getInstance().assetMgr.createImage("img_jc_zctou2"),"img_jc_zctou");
			
			
		}
		
		protected override function getInit():void{
			super.getInit();
			this.getInEnemyArr();
			setBodyY(-6);
			
//			_bodyMc.filter = BlurFilter.createGlow(0xeeee00);
			GetJson.getInstance().getLoad("guai1.txt",this.cbk);
			
			
			
		} 
		
		private function cbk(obj):void{
			
			
			ObjVO.getInstance().getVO(obj,this);
			if(!this._roleLive)this._roleLive = new RoleLive();
			this.curLive = this.maxLive;
			_roleLive.maxLive = this.maxLive;
			_roleLive.curLive = this.curLive;
			UIScreen.getInstance()._xuetiao2.getRoleLive(this);
			UIScreen.getInstance()._xuetiao2.setChangdu(700);
			
			if(!this._roleTili)this._roleTili = new RoleTili();
			this.curTili = this.maxTili;
			_roleTili.maxTili = this.maxTili;
			_roleTili.curTili = this.curTili;
			this.enemyArr = [Globals.player];
			
			
			if(!_zhuangTaiChange)_zhuangTaiChange = ZhuangTaiChange.getInstance();
			_zhuangTaiChange.getObj(this.zhuangtaiqiehuan,this);
			
//			AIfn3.getInstance().getAiObj(this,Globals.player);
		}
		
		public function getInEnemyArr():void{
			Globals.enemyArr.push(this);
		}
		
		
	}
}