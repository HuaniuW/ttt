package AI.actionAI
{
	
	import elements.I.Ibiont;
	import elements.texiao.TexiaoPool2;
	
	public class AIAcPlay2 extends AIAcPlay
	{
		public function AIAcPlay2(obj:Ibiont, targetObj:Ibiont, cbk:Function)
		{
			super(obj, targetObj, cbk);
		}
		
		protected override function getAtk():void{
			if(_czhaoshi){
				TexiaoPool2.getInstance().getOnTexiao(_czhaoshi,_obj,null,isDiyizhao);
				_isAction = true;
			}
		}
	}
}