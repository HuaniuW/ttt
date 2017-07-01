package elements.texiao
{
	import elements.I.Ibiont;
	

	public class TexiaoPool
	{
		public function TexiaoPool()
		{
		}
		
		private static var _instance:TexiaoPool;
		public static function getInstance():TexiaoPool{
			if(!_instance)_instance = new TexiaoPool();
			return _instance;
		}
		
		private var _objPool:Object = {};
		
		
		public function getOnTexiao(_name:String,role:Ibiont,_x:Number=0,_y:Number=0,num:int=100):void{
//			trace("_name "+_name);
			var texiao:Texiao = getTexiao(_name);
			texiao.show(_name,role,_x,_y,num);
		}
		
		public function getTexiao(_name:String):Texiao{
			if(!this._objPool[_name]){
				this._objPool[_name] = new Array();
			}
			if(!(this._objPool[_name] as Array).length){
				return new Texiao();
			}else{
				return ((this._objPool[_name] as Array).shift() as Texiao);
			}
		}
		
		public function getInPool(_name:String,obj:Texiao):void{
			if(!_objPool[_name]){
				_objPool[_name] = new Array();
				
			}
			(_objPool[_name] as Array).push(obj);
		}
		
		public function dispose():void{
			for(var i:int in _objPool){
				for(var j:int in _objPool[i]){
					(_objPool[i][j] as Texiao).dispose();
					_objPool[i][j] = null;
				}
				_objPool[i] = null;
			}
			gc();
		}
		
		private function gc():void
		{
			// TODO Auto Generated method stub
			
		}
		
		
	}
}