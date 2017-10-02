package elements.texiao
{
	import controls.GameManager;
	
	
	import lzm.starling.swf.display.SwfMovieClip;
	
	
	public class TXMcPool
	{
		public function TXMcPool()
		{
		}
		
		private static var _instance:TXMcPool;
		public static function getInstance():TXMcPool{
			if(!_instance)_instance = new TXMcPool();
			return _instance;
		}
		
		private var _objPool:Object = {};
		
		public function getTexiaoMc(_name:String):SwfMovieClip{
			if(!this._objPool[_name]){
				this._objPool[_name] = new Array();
			}
			if(!(this._objPool[_name] as Array).length){
				return GameManager.getInstance().assetMgr.createMovieClip(_name);
			}else{
//				trace("取>>>>>>>>>>>>>>>>>>>>>>>>>  "+_name);
				return ((this._objPool[_name] as Array).shift() as SwfMovieClip);
			}
		}
		
		public function getInPool(_name:String,obj:SwfMovieClip):void{
			if(!_objPool[_name]){
				_objPool[_name] = new Array();
				
			}
//			trace("存>>>>>>>>>>>>>>>>>>>>>>>>>  "+_name);
			(_objPool[_name] as Array).push(obj);
		}
		
		public function dispose():void{
			for(var i:int in _objPool){
				for(var j:int in _objPool[i]){
					(_objPool[i][j] as SwfMovieClip).dispose();
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

