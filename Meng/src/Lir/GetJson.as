package Lir
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class GetJson
	{
		public function GetJson()
		{
			
		}
		
		private static var instance:GetJson;
		public static function getInstance():GetJson{
			instance = new GetJson();
			return instance;
		}
		
		private var loader:URLLoader;
		private var _cbk:Function;
		public function getLoad(url:String,cbk:Function):void{
			_cbk = cbk
			if(!loader)loader = new URLLoader();
			
			loader.addEventListener(Event.COMPLETE, decodeJSON);
			loader.load(new URLRequest(url));
		}
		
		protected function decodeJSON(event:Event):void
		{
//			trace("???  "+event.target.data);
			var s:String = event.target.data;
//			for(var i:int in s){
//				trace("s>> "+s);
//				if(s == '"')trace(">>");
//			}
			var persons:Object = JSON.parse(event.target.data);
			_cbk(persons);
			loader.removeEventListener(Event.COMPLETE, decodeJSON);
			loader = null;
			
		}
		
	}
}