package elements.texiao
{
	import elements.I.Ibiont;
	import elements.texiao.otherTX.TXAddTili;
	
	import game.engine.Engine;
	
	import lzm.starling.swf.display.SwfMovieClip;

	public class TXTiliHuifu extends Texiao
	{
		public function TXTiliHuifu()
		{
			super();
		}
		
		override public function show(txMCName:String, role:Ibiont=null, _x:Number=0, _y:Number=0, numChangeCeng:int=100):void
		{
			this._txMCName = txMCName;
			//			trace("_txname   "+_txMCName);
			this._numChangeCeng = numChangeCeng;
			
			
			this.__x = _x;
			this.__y = _y;
			
			this._role = role;
			this._parent = this._role.getParent();
			this._parent.addChild(this);
			
			this.x = _role.getX()-_role.getWidth()*0.5;
			this.y = _role.getY();
			
			if(__x == 1000){
				_isGensui = true;
				__x = 0;
			}
			
			Engine.createEngine().push(this.action);
		}
		
		public function setCXSJ(cxsj:int):void{
			chixushijian = cxsj;
		}
		
		
		
		private var chixushijian:int = 60;
		private var _liziArr:Array = [];
		override protected function action():void{
			this.x = _role.getX()-_role.getWidth()*0.5;
			chixushijian -- ;
			if(chixushijian>0){
				if(chixushijian%10==1){
					var lizi:TXAddTili =  new TXAddTili();
					lizi.showTx();
					this.addChild(lizi);
					lizi.x = Math.random()*_role.getWidth();
					_liziArr.push(lizi);
					
				}
			}
		}
		
		public function stopAddTili():void{
			removeSelf();
			chixushijian = 60;
			for(var i:int in _liziArr){
				if(_liziArr[i])(_liziArr[i] as TXAddTili).getStop();
			}
			
			_liziArr = [];
		}
		
		override protected function removeSelf():void{
			if(this.parent){
				this.removeFromParent();
				TexiaoPool.getInstance().getInPool(this._txMCName,this);
				Engine.createEngine().pop(this.action);
				this._texiaoMc = null;
			}
		}
		
	}
}