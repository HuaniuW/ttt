package AI.aiac
{
	import elements.I.Ibiont;

	public class AIAtk
	{
		public function AIAtk()
		{
		}
		
		private static var _instance:AIAtk;
		public static function getInstance():AIAtk{
			if(!_instance)_instance = new AIAtk();
			return _instance;
		}
		
		
		private var _obj:Ibiont;
		private var _targetObj:Ibiont;
		private var _nums:int =1;
		public function getObj(obj:Ibiont, targetObj:Ibiont,nums:int =1):void{
			this._obj = obj;
			this._targetObj = targetObj;
			this._nums = nums;
		}
		
		public function getGJDastance():Number{
			return _obj.getGJSZArr()[_nums-1]["atkjuli"];
		}
		
		public function getAc():void{
			_obj.atk(_nums);
		}
	}
}