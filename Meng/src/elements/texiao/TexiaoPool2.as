package elements.texiao
{
	import flash.utils.getDefinitionByName;
	
	import elements.I.Ibiont;
	import elements.jineng.JinengObj;
	import elements.texiao.GJTexiao1;
	
	import game.utils.CharCase;
	
	import starling.display.DisplayObject;
	

	public class TexiaoPool2
	{
		public function TexiaoPool2()
		{
		}
		
		private static var _instance:TexiaoPool2;
		public static function getInstance():TexiaoPool2{
			if(!_instance)_instance = new TexiaoPool2();
			return _instance;
		}
		
		private var _objPool:Object = {};
		
		private var _txClassName:String;
<<<<<<< HEAD
		public function getOnTexiao(_name:String,role:Ibiont,_x:Number=0,_y:Number=0,num:int=100):void{
			var obj:Object = JinengObj[_name];
			_txClassName = obj["className"];
			var gjtx:DisplayObject = getTexiao(obj["txName"]);
			gjtx["getSJObj"](obj,role);
=======
		public function getOnTexiao(_name:String,role:Ibiont,cbk=null,isYanChi:Boolean = true,_x:Number=0,_y:Number=0,num:int=100):void{
			var obj:Object = JinengObj[_name];
			_txClassName = obj["className"];
			var gjtx:DisplayObject = getTexiao(obj["jnName"]);
			gjtx["getSJObj"](obj,role,cbk,isYanChi);
>>>>>>> origin/master
		}
		
		public function getTexiao(_name:String):DisplayObject{
			if(!this._objPool[_name]){
				this._objPool[_name] = new Array();
			}
			if(!(this._objPool[_name] as Array).length){
				var mcClassName:String = "elements.texiao"+"::"+_txClassName;
<<<<<<< HEAD
				trace("mc>> "+mcClassName);
				var McClass:Class = getDefinitionByName(mcClassName) as Class;
				return new McClass();
			}else{
				trace("取对象池的 对象 _name  "+_name);
=======
//				trace("mc>>>>>>>>>>>>>>>>>>>>>>>>>>>>     "+mcClassName);
				var McClass:Class = getDefinitionByName(mcClassName) as Class;
				return new McClass();
			}else{
//				trace("取对象池的 对象 _name  "+_name);
>>>>>>> origin/master
				return ((this._objPool[_name] as Array).shift());
			}
		}
		
		public function getInPool(_name:String,obj:DisplayObject):void{
			
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