package controls
{
	import nape.geom.Vec2;
	import nape.space.Space;

	public class Napes
	{
		public var space:Space;
		public function Napes()
		{
			var gravity:Vec2 = new Vec2(0,1900);
			space = new Space(gravity);
		}
		
		private static var _instance:Napes;

		public static function get instance():Napes
		{
			if(!_instance)_instance = new Napes;
			return _instance;
		}
		
		

	}
}