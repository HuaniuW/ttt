package elements.role
{
	import elements.I.Ibiont;
	
	import game.engine.Engine;

	public class ACStopNums
	{
		public function ACStopNums()
		{
			
		}
		
		public static function getInstance():ACStopNums{
			return new ACStopNums();
		}
		
		private function action():void
		{
			_nums++;
			if(_nums>=_maxNums){
				_nums = 0;
				mcPlay();
			}
		}		
		
		private var _nums:int = 0;
		private var _maxNums:int = 0;
		private var _role:Ibiont;
		public function stopNums(maxNums:int,role:Ibiont):void{
			_maxNums = maxNums;
			_role = role;
			_role.bodyMcStop();
			trace(" >>   "+maxNums);
			Engine.createEngine().push(action);
		}
		
		
		public function mcPlay():void{
			if(_role){
				_nums = 0;
				_role.bodyMcPlay();
				Engine.createEngine().pop(action);
			}
			
		}
	}
}