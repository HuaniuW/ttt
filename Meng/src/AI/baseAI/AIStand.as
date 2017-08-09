package AI.baseAI
{
	import elements.I.Ibiont;
	import AI.AIBase;
	
	public class AIStand extends AIBase
	{
		public function AIStand(obj:Ibiont, targetObj:Ibiont, cbk:Function)
		{
			super(obj, targetObj, cbk);
		}
		
		public static function getInstance(obj:Ibiont,targetObj:Ibiont,cbk:Function,alertDistance:int = 200):AIStand
		{
			return new AIStand(obj,targetObj,cbk);
		}
		
		public function stop():void{
			this._obj.getStop();
		}
	}
}