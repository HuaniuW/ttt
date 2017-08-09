package elements.role
{
	public class ObjVO
	{
		public function ObjVO()
		{
			
		}
		
		private static var _instance:ObjVO;
		public static function getInstance():ObjVO{
			if(!_instance)_instance = new ObjVO();
			return _instance;
		}
		
		public function getVO(JsonObj:Object,obj:RoleBase):void{
			obj.gongjili = JsonObj["gongjili"];
			obj.fangyuli = JsonObj["fangyuli"];
			obj.yingzhi = JsonObj["yingzhi"];
			obj.minSpeed = JsonObj["minSpeed"];
			obj.maxSpeed = JsonObj["maxSpeed"];
			obj.jumpPow = JsonObj["jumpPow"];
			obj.maxLive = JsonObj["maxLive"];
			obj.maxTili = JsonObj["maxTili"];
//			trace("----------------------> "+JsonObj["maxTili"]+"  ?  "+obj.maxTili);
			
			obj.gjNum = JsonObj["gjNum"];
			obj.gongjizhaoshiArr = JsonObj["gongjizhaoshiArr"];
			obj.jumpGJArr = JsonObj["jumpGJArr"];
			obj.jinengArr = JsonObj["jinengArr"];
			obj.alertDistance = JsonObj["alertDistance"];
			obj.beHitAcArr = JsonObj["beHitAcArr"];
			obj.weight = JsonObj["JsonObj"];
			obj.shiyingTXScale = JsonObj["shiyingTXScale"];
		}
	}
}