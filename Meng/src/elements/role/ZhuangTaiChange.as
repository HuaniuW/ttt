package elements.role
{
	import elements.I.Ibiont;
	
	import game.engine.Engine;

	public class ZhuangTaiChange
	{
		public function ZhuangTaiChange()
		{
		}
		
		public static function getInstance():ZhuangTaiChange{
			return new ZhuangTaiChange();
		}
		
		private var _zhuangtaiqiehuan:Object;
		private var _role:Ibiont;
		public function getObj(zhuangtaiqiehuan:Object,role:Ibiont):void{
			_zhuangtaiqiehuan = zhuangtaiqiehuan;
			_role = role;
			Engine.createEngine().push(action);
		}
		
		private function action():void
		{
			// TODO Auto Generated method stub
			var clive:int = _role.getRoleLive().curLive;
			var mlive:int = _role.getRoleLive().maxLive;
			for(var key:String in _zhuangtaiqiehuan){
				if(!_zhuangtaiqiehuan[key]["isChange"]){
					if(clive <_zhuangtaiqiehuan[key]["xueliang"]*mlive){
						_zhuangtaiqiehuan[key]["isChange"] = true;
						trace("状态改变！" + _zhuangtaiqiehuan[key]["xueliang"]);
						_role.zhuangtaiChange(_zhuangtaiqiehuan[key]);
						return;
					}
				}
			}
		}
	}
}