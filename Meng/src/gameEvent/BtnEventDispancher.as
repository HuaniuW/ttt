package gameEvent
{
	import starling.events.EventDispatcher;
	
	public class BtnEventDispancher extends EventDispatcher
	{
		public function BtnEventDispancher()
		{
			super();
		}
		
		private static var _instance:BtnEventDispancher;
		public static function getInstance():BtnEventDispancher{
			if(!_instance)_instance = new BtnEventDispancher();
			return _instance;
		}
	}
}