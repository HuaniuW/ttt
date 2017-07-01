package AI
{
	import elements.I.Ibiont;
	
	public class TheStand extends AIBase
	{
		public function TheStand(obj:Ibiont, targetObj:Ibiont, cbk:Function)
		{
			super(obj, targetObj, cbk);
		}
		
		public static function getInstance(obj:Ibiont,targetObj:Ibiont,cbk:Function,alertDistance:int = 200):TheStand
		{
			return new TheStand(obj,targetObj,cbk);
		}
		
		public function stop():void{
			this._obj.getStop();
		}
	}
}