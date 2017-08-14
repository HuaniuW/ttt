package screens
{
	import flash.utils.getDefinitionByName;
	
	import Lir.FileControl;
	import Lir.GetJson;
	
	import controls.GameManager;
	import controls.Globals;
	import controls.HitManager;
	import controls.Napes;
	
	import elements.I.IElementBase;
	import elements.diban.Diban;
	import elements.grx.RenXingGuai1;
	import elements.role.Role;
	
	import game.engine.Engine;
	import game.myGame.ScreenBase;
	import game.utils.CharCase;
	
	import joeonmars.camerafocus.StarlingCameraFocus;
	
	import lzm.starling.swf.display.SwfImage;
	import lzm.starling.swf.display.SwfMovieClip;
	import lzm.starling.swf.display.SwfSprite;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	
	public class GameMapScreen extends ScreenBase
	{
		
		private var _diban:Diban;
		private var _role:Role;
		private var _renXingGuai1:RenXingGuai1;
		
		
		
		private var _gMgr:GameManager;
		public function GameMapScreen()
		{
			super();
			trace(">GameMapScreen");
			_gMgr = GameManager.getInstance();
			getMapShow();
			HitManager.getInstance().hitMgr();
		}
		
		
		private static var _instance:GameMapScreen;
		public static function getInstance():GameMapScreen{
			if(!_instance)_instance = new GameMapScreen();
			return _instance;
		}
		
		private var yuanjingArr:Array = [];
		
		
		private function getMapShow():void{
//			trace(">"+Globals.currentC);
			var c1:SwfSprite = _gMgr.assetMgr.createSprite(Globals.currentC);
//			trace("c1  "+c1.width);
			var num:int = c1.numChildren;
//			trace(">num "+num);
			//精灵类型名
			var typeName:String;
			//精灵名字
			var objName:String;
			var linkName:String;
			var img:Image;
			var mc:SwfMovieClip;
			var obj:DisplayObject;
			var isCameraUpDown:Boolean = false;
			for(var i:int =0;i<num;i++){
				obj = c1.getChildAt(i);
				//图片资源
				if(obj is SwfImage){
					linkName = (obj as SwfImage).classLink;
					objName = linkName.split("_").pop();
					typeName = linkName.split("_")[1];
					img = _gMgr.assetMgr.createImage(linkName);
					if(typeName == "yj"){
						
						addChild(img);
						img.x = obj.x;
						img.y = obj.y;
						
						
						
						yuanjingArr.push({"ox":0,"oy":0,"instance":img,"name":objName,"ratio":0.5});
						continue;	
					}
//					trace("img>  "+linkName+"   width  "+img.width+" x "+obj.x+" y "+obj.y+"  objName:  "+objName+"  typeName: "+typeName);
					var ClassName:String = "elements."+typeName+"::"+CharCase.friUp(objName);
//					trace("className   "+ClassName+"      "+img.width+"    "+img.height);
					var ClassReference:Class = getDefinitionByName(ClassName) as Class;
					var theObj:DisplayObject = new ClassReference(obj.x,obj.y,img.width,img.height,img,Napes.instance.space);
					addChild(theObj);
					
				}
				
				//mc资源
				if(obj is SwfMovieClip){
					linkName = (obj as SwfMovieClip).classLink;
					objName = linkName.split("_").pop();
					typeName = linkName.split("_")[1];
					mc = _gMgr.assetMgr.createMovieClip(linkName);
					mc.gotoAndStop(0);
//					trace("mc>   "+linkName+"   width:  "+mc.width+"  x "+obj.x+"  y "+obj.y+"  objName:  "+objName+"  typeName: "+typeName);
					var mcClassName:String = "elements."+typeName+"::"+CharCase.friUp(objName);
//					trace("mc>> "+mcClassName);
					var McClass:Class = getDefinitionByName(mcClassName) as Class;
//					trace(McClass);
					var theMcObj:DisplayObject = new McClass(mc,{},obj.x,obj.y,mc.width-10,mc.height,Napes.instance.space);
					addChild(theMcObj);
					theMcObj.x = obj.x;
					theMcObj.y = obj.y;
				}
			}
			c1.dispose();
			getCamera(isCameraUpDown);
			
		}
		
		private var _camera:StarlingCameraFocus;
		private function getCamera(isUpDown:Boolean = false):void{
//			trace("Starling.current.stage.stageWidth: "+Starling.current.stage.stageWidth);
			if(_camera){
				_camera.destroy();
				_camera = null;
			}
//			trace(Globals.player.x);
//			trace("------------------------------------------>>"+Globals.player.body.graphic.x);
//			trace("stage>>:  "+Starling.current.stage.stageWidth);
			_camera = new StarlingCameraFocus(Starling.current.stage,this,Globals.player.body.graphic,yuanjingArr,true,Starling.current.stage.stageWidth,isUpDown);
			Engine.createEngine().push(_camera.update);
			
			if(isUpDown){
//				_camera.setFocusPosition(Globals.cx,Globals.cy);
				_camera.setFocusPosition(Starling.current.stage.stageWidth*0.5,Starling.current.stage.stageHeight*0.6);
			}else{
				_camera.setFocusPosition(Starling.current.stage.stageWidth*0.5,Starling.current.stage.stageHeight*0.6);
			}
			
//						_camera.zoomFocus(0.7,1);
		}
		
		
		private function clearMap():void{
			var num:int = this.numChildren;
			var i:int = num-1;
			for(i;i>=0;i--){
				//				trace("----------->"+getChildAt(i));
				if(this.getChildAt(i) is IElementBase){
					//					trace("i "+getChildAt(i));
					(this.getChildAt(i) as IElementBase).removeSelf();
				}else{
					//					trace(getChildAt(i));
					this.getChildAt(i).removeFromParent(true);
				}
			}
			Napes.instance.space.bodies.clear();
		}
	}
}