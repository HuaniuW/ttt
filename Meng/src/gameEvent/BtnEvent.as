package gameEvent
{
	import starling.events.Event;
	
	public class BtnEvent extends Event
	{
		public static var BTN_CLICK:String = "btn_click";
		public function BtnEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}