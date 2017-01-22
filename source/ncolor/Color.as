package ncolor {
	import nmath.NMath;

	import npooling.IReusable;
	import npooling.Pool;

	public final class Color implements IReusable {
		private static var _pool:Pool = Pool.getInstance();
		
		public static const MAX:int = 255;
		public static const MIN:int =   0;
		
		private var _r:int;
		private var _g:int;
		private var _b:int;

		private var _disposed:Boolean;
		
		public function Color(pR:int = 0, pG:int = 0, pB:int = 0) {
			r = pR;
			g = pG;
			b = pB;
		};
		
		public static function get BLACK():Color {
			return _pool.get(Color) as Color;
		};
		
		public static function get RANDOM():Color {
			var result:Color = BLACK;
				result.random();
			
			return result;
		};
		
		public static function fromHSV(pInput:HSVColor):Color {
			var result:Color = Color.BLACK;
			
			var r:Number = 0;
			var g:Number = 0;
			var b:Number = 0;
			
			var h:int    = pInput.h * 6;
			var f:Number = pInput.h * 6 - h;
			var p:Number = pInput.v * (1 - pInput.s);
			var q:Number = pInput.v * (1 - f * pInput.s);
			var t:Number = pInput.v * (1 - (1 - f) * pInput.s);
			
			if (h == 0) {
				r = pInput.v;
				g = t;
				b = p;
			}
			
			if (h == 1) {
				r = q;
				g = pInput.v;
				b = p;
			}
			
			if (h == 2) {
				r = p;
				g = pInput.v;
				b = t;
			}
			
			if (h == 3) {
				r = p;
				g = q;
				b = pInput.v;
			}
			
			if (h == 4) {
				r = t;
				g = p;
				b = pInput.v;
			}
			
			if (h == 5) {
				r = pInput.v;
				g = p;
				b = q;
			}
			
			result.r = r * 256;
			result.g = g * 256;
			result.b = b * 256;
			
			return result;
		};
		
		public function get reflection():Class {
			return Color;
		};

		public function get disposed():Boolean {
		    return _disposed;
		};
		
		public function set r(pValue:int):void {
			_r = NMath.clamp(pValue, MIN, MAX);
		};
		
		public function get r():int {
			return _r;
		};
		
		public function set g(pValue:int):void {
			_g = NMath.clamp(pValue, MIN, MAX);
		};
		
		public function get g():int {
			return _g;
		};
		
		public function set b(pValue:int):void {
			_b = NMath.clamp(pValue, MIN, MAX);
		};
		
		public function get b():int {
			return _b;
		};
		
		public function get hex():uint {
			return _r << 16 | _g << 8 | _b;
		};

		public function set hex(pValue:uint):void {
			_r = (pValue >> 16) & 0xFF;
			_g = (pValue >> 8) & 0xFF;
			_b =  pValue & 0xFF;
		}
		
		public function random():void {
			r = int(Math.random() * MAX);
			g = int(Math.random() * MAX);
			b = int(Math.random() * MAX);
		};
		
		public function randomOffset(pOffset:int):void {
			var middle:Number     = (r + g + b) / 3;
			var randomized:Number = middle + 2 * Math.random() * pOffset - pOffset;
			
			var ratio:Number = randomized / middle;
			
			r = r * ratio;
			g = g * ratio;
			b = b * ratio;
		};
		
		public function poolPrepare():void {
			r = g = b = 0;
		};
		
		public function dispose():void {
			_disposed = true;
		};
		
		public function toString():String {
			return "[ Color r= " + r + ", g=" + g + ", b=" + b + " ]"
		};
	}
}