package elements.role
{
	public class RoleLive
	{
		private var _maxLive:int = 0;
		private var _curLive:int = 0;
		public function RoleLive()
		{
			init();
		}
		
		public function get curLive():int
		{
			return _curLive;
		}

		public function set curLive(value:int):void
		{
			_curLive = value;
			if(_curLive>=_maxLive)_curLive = _maxLive;
			if(_curLive<=0)_curLive = 0;
		}

		public function get maxLive():int
		{
			return _maxLive;
		}

		public function set maxLive(value:int):void
		{
			_maxLive = value;
		}

		private function init():void
		{
		}
		
		
	}
}