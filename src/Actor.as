package 
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	//import flash.events.Event;
	import flash.utils.setTimeout;
	
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	//import com.greensock.plugins.TweenPlugin;
	//import com.greensock.plugins.BezierThroughPlugin; 
	
	/**
	 * ...
	 * @author OD
	 */
	public class Actor extends MovieClip 
	{
		//, symbol = "..."
		[Embed(source = "../assets/Idle.swf")]
		static public var Idle:Class;
		
		[Embed(source = "../assets/Jump.swf")]
		static public var Jump:Class;
		
		private var idleMC:MovieClip, jumpMC:MovieClip;
		private var idle:Sprite, jump:Sprite;
		private var _x:int, _y:int;
		private var xx:int, yy:int, x0:int, y0:int, nJumps:int;
		private var rot:int, t:Number = 1;
		private var bezierArray:Array, t0:int = 0;
		
		private var tweens:Array = [];
		
		public function Actor(x0:int, y0:int) 
		{
			super();
			_x = x0; _y = y0;
			
			idle = new Sprite(); addChild(idle);
			idleMC = new Idle(); idle.addChild(idleMC);
			idleMC.rotation = 45;
			//idle.name = "idle";
			idle.x = x0; idle.y = y0;
			
			jump = new Sprite(); addChild(jump);
			jumpMC = new Jump(); jump.addChild(jumpMC);
			jumpMC.rotation = 45 + 90;
			//jump.name = "jump";
			jump.x = x0; jump.y = y0;
			
			doIdle();
		}
		
		public function doIdle():void {
			//trace("Idle");
			jump.visible = false;
			idle.visible = true;
			x0 = _x; y0 = _y;
			nJumps = int(Math.random() * 2) + 6;
			//setTimeout(doJump, int(Math.random() * 5000) + 3000);
			
			bezierArray = [];
			while (--nJumps) {
				trace('n: ', nJumps);
				bezierArray.push(getXY());
			}
			bezierArray.push({ x:_x, y:_y });
			setTimeout(bezierJump, int(Math.random() * 20000) + t0);
			t0 = 20000;
		}
		
		public function bezierJump():void {
			idle.visible = false;
			jump.visible = true;
			var dt:int = int(Math.random() * 10) + 10;
			TweenLite.to(jump, dt, { ease:Linear.ease, orientToBezier:true, bezierThrough:bezierArray, onComplete:doIdle } );
		}
		
		public function doJump():void {
			//trace("Jump");
			idle.visible = false;
			jump.visible = true;
			
			getXY(); --nJumps;
			
			tweens.push(new Tween(jump, "x", Strong.easeInOut, x0, xx, t, true));
			tweens.push(new Tween(jump, "y", Strong.easeInOut, y0, yy, t, true));
			tweens[0].addEventListener(TweenEvent.MOTION_FINISH, endJump);
		}
		
		private function endJump(e:TweenEvent = null):void {
			tweens[0].removeEventListener(TweenEvent.MOTION_FINISH, endJump);
			tweens = [];
			
			x0 = xx; y0 = yy;
			if (nJumps) {
				doJump(); return;
			}
			
			doRotation(_x - x0, _y - y0);
			tweens.push(new Tween(jump, "x", Strong.easeInOut, xx, _x, t, true));
			tweens.push(new Tween(jump, "y", Strong.easeInOut, yy, _y, t, true));
			tweens[0].addEventListener(TweenEvent.MOTION_FINISH, endJump2);
		}
		
		private function endJump2(e:TweenEvent = null):void {
			tweens[0].removeEventListener(TweenEvent.MOTION_FINISH, endJump2);
			tweens = [];
			doIdle();
		}
		
		public function getXY():* {
			xx = int(Math.random() * (1024 - 200)) + 100;
			yy = int(Math.random() * (650 - 100)) + 50;
			//doRotation(xx - x0, yy - y0);
			return { x:xx, y:yy };
		}
		
		public function doRotation(dx:int, dy:int):void {
			t = 0.85 * Math.sqrt(dx * dx + dy * dy) / 100
			rot = int(180 * Math.atan2(dy, dx) / Math.PI) + 90;
			rot += 45;
			jump.rotation = rot;
			//Math.hy
		}
		
	}

}