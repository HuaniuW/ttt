package elements.jineng
{
	import elements.I.Ibiont;

	public class JNBase implements IJiNeng
	{
		private var _obj:Ibiont;
		private var _targetObj:Ibiont;
		private var _cbk:Function;
		
		public function JNBase(obj:Ibiont,targetObj:Ibiont,cbk:Function)
		{
			_obj = obj;
			_targetObj = targetObj;
			_cbk = cbk;
		}
		
		public function getAtkDistance():int
		{
			return 0;
		}
		
		public function JNStart():void
		{
			
		}
	}
}