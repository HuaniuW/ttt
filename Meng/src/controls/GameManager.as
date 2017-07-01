package controls
{
	import lzm.starling.STLConstant;
	import lzm.starling.swf.SwfAssetManager;
	
	import starling.events.EventDispatcher;

	public class GameManager extends EventDispatcher
	{
		public var assetMgr:SwfAssetManager;
		public function GameManager()
		{
			assetMgr = new SwfAssetManager(STLConstant.scale,STLConstant.useMipMaps);
		}
		
		private static var _instance:GameManager;
		public static function getInstance():GameManager{
			if(!_instance)_instance = new GameManager();
			return _instance;
		}
		
	}
}