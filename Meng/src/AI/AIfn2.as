package AI
{
	import elements.I.IAi;
	import elements.I.Ibiont;
	
	import game.engine.Engine;

	public class AIfn2 implements IAi
	{
		public function AIfn2()
		{
		}
		
		private var _obj:Ibiont;
		private var _targetObj:Ibiont;
		
		
		
		private static var _instance:AIfn2;
		public static function getInstance():AIfn2{
			return new AIfn2();
		}
		
		private var standPatrol:StandPatrol;
		private var _aiAcPlay:AIAcPlay;
		private function getAI():void{
			/**站着不动 警示站岗*/
			if(!standPatrol)standPatrol = StandPatrol.getInstance(_obj,_targetObj,this.cbk,_obj.getAlertDistance());
			
			if(!_aiAcPlay)_aiAcPlay = AIAcPlay.getInstance(_obj,_targetObj,this.cbk);
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
				_aiAcPlay.getAcArr([]);
				return;
			}
			standPatrol.action();
			
						
		}
		
		public function reSetAll():void
		{
		}
		
		
		public function stopAI():void{
			Engine.createEngine().pop(this.getRandom);
		}
		
	}
}