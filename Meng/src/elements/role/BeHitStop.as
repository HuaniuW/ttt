package elements.role
{
	import elements.I.Ibiont;
	
	import game.engine.Engine;

	public class BeHitStop
	{
		public function BeHitStop()
		{
			
		}
		
		
		private var nums:int = 0;
		private var _isBeStoping:Boolean = false;
		public function isBeStoping():Boolean{
			trace(" -----_isBeStoping   "+_isBeStoping);
			return _isBeStoping;
		}
		
		private function getStoping():void{
			nums++;
			if(nums>=180){
				nums = 0;
				_isBeStoping = false;
				Engine.createEngine().pop(action);
				return;
			}
			_isBeStoping = true;
		}
		
		private var _role:Ibiont;
		public function getRole(role:Ibiont):void{
			_role = role;
			nums = 0;
			roleStop();
		}
		
		
		public function roleStop():void{
			_role.bodyMcStop();
			Engine.createEngine().push(action);
		}
		
		private function action():void
		{
			getStoping();
		}
	}
}