/**
 *巡逻 
 */
package AI.actionAI
{
	import elements.I.Ibiont;
	import AI.AIBase;

	public class Patrol extends AIBase
	{
		
		public function Patrol(obj:Ibiont,targetObj:Ibiont,cbk:Function,alertDistance:int = 200){
			super(obj,targetObj,cbk);
			this.alertDistance = alertDistance;
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
		public static function getInstance(obj:Ibiont,targetObj:Ibiont,cbk:Function,alertDistance:int = 200):Patrol
		{
			return new Patrol(obj,targetObj,cbk);
		}

		/**是否巡逻*/
		private var isPatrol:Boolean = false;
		public override function reSetAll():void{
			atX = 0;
			isGetAtX = false;
		}
		
		public function stopPatrol():void{
			isActive = true;
		}
		
		/**激活  激活后开始追踪和攻击*/
		protected var isActive:Boolean = false;
		/**警戒距离*/
		protected var alertDistance:int = 200;  
		/**巡逻*/
		protected function patrol():void{
			if(!isActive){
				if(Math.abs(_targetObj.getX() - _obj.getX())<=this.alertDistance){
					this.isActive = true;
					this._cbk();		
					trace("发现目标 巡逻结束");
					return;
				}
				getPatrolMove();
			}
		}
		
		/**当前位置*/
		private var atX:int = 0;
		/**是否记录当前位置*/
		private var isGetAtX:Boolean = false;
		/**巡逻动作*/		
		private function getPatrolMove():void
		{
			if(!isGetAtX){
				isGetAtX = true;
				atX = _obj.getX();
				_obj.moveR();
			}
			
			if(_obj.getX() - atX>alertDistance){
				_obj.moveL();
			}else if(_obj.getX() - atX<-alertDistance){
				_obj.moveR();
			}
		}
		
		
		public function action():void{
			patrol();
//			getPatrolMove();
		}
		
		

	}
}