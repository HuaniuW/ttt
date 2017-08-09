package AI.aifas
{
	import elements.I.IAi;
	import elements.I.Ibiont;
	
	import game.engine.Engine;
	import AI.actionAI.AIStandPatrol;
	import AI.baseAI.AIStand;

	public class AIfn1 implements IAi
	{
		public function AIfn1()
		{
		}
		
		private var _obj:Ibiont;
		private var _targetObj:Ibiont;
		
		
		
		private static var _instance:AIfn1;
		public static function getInstance():AIfn1{
			return new AIfn1();
		}
		
//		private var patrol:Patrol;
		private var standPatrol:AIStandPatrol;
		private var commonAtk:MoveNearXAndCommonAtk;
		private var theStand:AIStand;
		private function getAI():void{
//			if(!patrol)patrol = Patrol.getInstance(_obj,_targetObj,this.cbk);
			if(!standPatrol)standPatrol = AIStandPatrol.getInstance(_obj,_targetObj,this.cbk,_obj.getAlertDistance());
			if(!commonAtk)commonAtk = new MoveNearXAndCommonAtk(_obj,_targetObj,this.cbk);
			if(!theStand)theStand = new AIStand(_obj,_targetObj,this.cbk);
		}
		
		/**返回函数*/
		public function cbk(obj:Object = null):void{
			this.isRandon = true;
		}
		
		public function getAiObj(obj:Ibiont,targetObj:Ibiont):void{
			this._obj = obj;
			this._targetObj = targetObj;
			getAI();
			
			Engine.createEngine().push(this.getRandom);
		}
		
		
		private var isRandon:Boolean = false;
		
		public function getRandom():void{
			if(isRandon){
				isRandon = false;
				reSetAll();
				var r:int = Math.random()*10;
				trace("random:  "+r);
				commonAtk.getEvent();
				return;
			}
			standPatrol.action();
			
						
		}
		
		public function reSetAll():void
		{
			commonAtk.reSetAll();	
		}
		
		
		public function stopAI():void{
			Engine.createEngine().pop(this.getRandom);
		}
		
	}
}