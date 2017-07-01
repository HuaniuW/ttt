package screens.ui.tilitiao
{
	import controls.GameManager;
	
	import elements.I.Ibiont;
	import elements.role.RoleTili;
	
	import game.engine.Engine;
	import game.myGame.ScreenBase;
	
	import lzm.starling.swf.display.SwfScale9Image;
	import lzm.starling.swf.display.SwfSprite;
	
	
	public class Tilitiao extends ScreenBase implements IUITilitiao
	{
		public function Tilitiao()
		{
			super();
			init();
		}
		
		private static var _instance:Tilitiao;
		public static function getInstance():Tilitiao{
			if(!_instance)_instance = new Tilitiao();
			return _instance;
		}
		
		private var _tilitiao:SwfSprite;
		private var bar1:SwfScale9Image;
		private var d:SwfScale9Image;
		private var _isSuoding:Boolean = false;
		private var zzsd:Number = 0.7;
		
		private function init():void{
			if(!this._tilitiao)this._tilitiao = GameManager.getInstance().assetMgr.createSprite("spr_UI_tilicao");
			this.addChild(_tilitiao);
			d = _tilitiao.getScale9Image("d");
			bar1 = _tilitiao.getScale9Image("bar");
			bar1.x = 3;
			bar1.y = 2;
			bar1.width = this._tilitiao.width-7;
			Engine.createEngine().push(this.action);
		}
		
		private var _roleTili:RoleTili;
		public function getRoleTili(biont:Ibiont):void{
			this._roleTili = biont.getRoleTili();
		}
		
		public function action():void{
			if(!_roleTili)return;
			bar1.visible = _roleTili.curTili<=0?false:true;
			this.bar1.width = _roleTili.curTili/_roleTili.maxTili*(this.d.width-7);
		}
		
		public function getCurTili():Number
		{
			return this._roleTili.curTili;
		}
		
		public function setMaxTili(num:Number):void
		{
			this._roleTili.maxTili = num;
			this._roleTili.curTili = this._roleTili.maxTili;
		}
		
		public function tiliChange():void
		{
			
			if(this._roleTili.curTili>=_roleTili.maxTili)this._roleTili.curTili = _roleTili.maxTili;
			if(this._roleTili.curTili<=0){
				this._roleTili.curTili = 0;
				this.rest();
			}
			this.bar1.width = _roleTili.curTili/_roleTili.maxTili*(this.d.width-7);
		}
		
		public function tilisuoding(suoDing:Boolean):void
		{
			_isSuoding = suoDing;
		}
		
		public function tilizengzhangsudu(num:Number):void
		{
			zzsd =  num;
		}
		
		private var _restNum:Number = 0;
		private var _isRest:Boolean = false;
		private var _restNums:Number = 40;
		public function rest(restNums:Number=40):void
		{
			this._restNum = 0;	
			_restNums = restNums;
			_isRest = true;
		}
		
		
	}
}