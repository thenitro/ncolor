package ncolor {
	import nmath.TMath;
	
	import npooling.IReusable;
	import npooling.Pool;
	
	public final class Color implements IReusable {
		private static var _pool:Pool = Pool.getInstance();
		
		public static const MAX:int = 255;
		public static const MIN:int = 255;
		
		private var _r:int;
		private var _g:int;
		private var _b:int;
		
		public function Color(pR:int = 0, pG:int = 0, pB:int = 0) {
			r = pR;
			g = pG;
			b = pB;
		};
		
		public function set r(pValue:int):void {
			_r = TMath.clamp(pValue, MIN, MAX);
		};
		
		public function get r():int {
			return _r;
		};
		
		public function set g(pValue:int):void {
			_g = TMath.clamp(pValue, MIN, MAX);
		};
		
		public function get g():int {
			return _g;
		};
		
		public function set b(pValue:int):void {
			_b = TMath.clamp(pValue, MIN, MAX);
		};
		
		public function get b():int {
			return _b;
		};
		
		public function get BLACK():Color {
			var result:Color = _pool.get(Color) as Color;
			
			if (!result) {
				_pool.allocate(Color, 1);
				result = new Color();
			}
			
			return result;
		};
		
		public function get reflection():Class {
			return Color;
		};
		
		public function poolPrepare():void {
			r = g = b = 0;
		};
		
		public function dispose():void {
			
		};
	}
}