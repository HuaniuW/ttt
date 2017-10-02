package elements.texiao.otherTX
{
	import elements.texiao.TXMcPool;
	import elements.texiao.Texiao;
	
	import game.engine.Engine;
	
	import lzm.starling.swf.display.SwfMovieClip;
	
	public class TXAddTili extends Texiao
	{
		public function TXAddTili()
		{
			super();
		}
		
		
		private var liziArr:Array = [];
		private var _txName:String = "mc_tilihuifu_qttx";
		private var lizi:SwfMovieClip;
		private var _juli:int = 20;
		public function showTx():void{
			lizi  = TXMcPool.getInstance().getTexiaoMc("mc_tilihuifu_qttx");
			
			_juli = -(100+Math.random()*20);
			this.addChild(lizi);
//			trace("lizi    "+lizi.y);
			Engine.createEngine().push(action);
		}
		
		override protected function action():void
		{
			
			lizi.y+=(_juli-lizi.y)*0.01;
//			trace("lizi.y      "+lizi.y);
			if(lizi.y<=_juli+20){
//				trace(lizi.y+"  ??????????????????????????? "+_juli);
				lizi.y = 0;
				removeSelf();
			}
		}
		
		public function getStop():void{
			removeSelf();
		}
		
		override protected function removeSelf():void
		{
			lizi.y = 0;
			this.removeChild(lizi);
			Engine.createEngine().pop(action);
			TXMcPool.getInstance().getInPool(_txName,lizi);
			super.removeSelf();
			
		}
		
		
		
		
		
	}
}