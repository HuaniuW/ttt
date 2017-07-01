package gameEvent
{
	import starling.events.Event;
	
	public class GameEvent extends Event
	{
		static public const LODINGOVER:String = "loadingOver";
		static public const GAMESTART:String = "gameStart";
		
		
		static public const MAP_SCREEN:String = "mapScreen";
		static public const GET_CUSTOM:String = "getCustom";
		static public const DIE_SCREEN:String = "dieScreen";
		static public const PASS_SCREEN:String = "passScreen";
		static public const RESTART_GAME:String = "restartGame";
		static public const CUSTOM_CHANGE:String = "customChange";
		
		public function GameEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}