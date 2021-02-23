package 
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author OD
	 */
	public class View extends Sprite 
	{
		[Embed(source = '../assets/bg.jpg')]
		static public var Bg:Class;
		
		public var mc:MovieClip;
		
		public function View() 
		{
			super();
			addChild(new Bg());
			
			mc = new Actor(525, 150); addChild(mc);
			mc = new Actor(405, 305); addChild(mc);
			mc = new Actor(605, 375); addChild(mc);
			
		}
		
		
	}

}