package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	//import com.greensock.TweenLite;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.BezierThroughPlugin; 
	
	/**
	 * ...
	 * @author OD
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			TweenPlugin.activate([BezierThroughPlugin]);
			//activation is permanent in the SWF, so this line only needs to be run once.
			
			addChild(new View());
		}
		
	}
	
}