package AI
{
	import elements.I.IAi;
	import elements.I.Ibiont;

	public class AIBase implements IAi
	{
		protected var _obj:Ibiont;
		protected var _targetObj:Ibiont;
		protected var _cbk:Function;
		public function AIBase(obj:Ibiont,targetObj:Ibiont,cbk:Function)
		{
			_obj = obj;
			_targetObj = targetObj;
			_cbk = cbk;
		}
		
		public function cbk(obj:Object=null):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function getAiObj(obj:Ibiont, targetObj:Ibiont):void
		{
			// TODO Auto Generated method stub
		}
		
		public function getRandom():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function reSetAll():void
		{
			// TODO Auto Generated method stub
			
		}
		
	}
}