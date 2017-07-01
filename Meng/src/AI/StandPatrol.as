package AI
{
	import elements.I.Ibiont;
	
	public class StandPatrol extends Patrol
	{
		public function StandPatrol(obj:Ibiont, targetObj:Ibiont, cbk:Function, alertDistance:int=200)
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
		public static function getInstance(obj:Ibiont,targetObj:Ibiont,cbk:Function,alertDistance:int = 200):StandPatrol
		{
			return new StandPatrol(obj,targetObj,cbk,alertDistance);
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