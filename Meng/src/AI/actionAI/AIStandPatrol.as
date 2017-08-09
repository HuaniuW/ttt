package AI.actionAI
{
	import elements.I.Ibiont;
	
	public class AIStandPatrol extends AIPatrol
	{
		public function AIStandPatrol(obj:Ibiont, targetObj:Ibiont, cbk:Function, alertDistance:int=200)
		{
			super(obj, targetObj, cbk, alertDistance);
		}
		
		
		/**
		 * 
		 * @param obj   
		 * @param targetObj
		 * @param cbk
		 * @param alertDistance 巡逻距离
		 * @return 
		 * 
		 */		
		public static function getInstance(obj:Ibiont,targetObj:Ibiont,cbk:Function,alertDistance:int = 200):AIStandPatrol
		{
			return new AIStandPatrol(obj,targetObj,cbk,alertDistance);
		}
		
		
		/**巡逻*/
		protected override function patrol():void{
			if(!isActive){
				if(Math.abs(_targetObj.getX() - _obj.getX())<=this.alertDistance){
					this.isActive = true;
					this._cbk();		
					trace("发现目标 巡逻结束");
					return;
				}
			}
		}
		
		
	}
}