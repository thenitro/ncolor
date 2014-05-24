package ncolor {
	import npooling.IReusable;
	import npooling.Pool;
	
	public final class LABColor implements IReusable {
		private static var _pool:Pool = Pool.getInstance();
		
		public var l:Number;
		public var a:Number;
		public var b:Number;
		
		public function LABColor(pL:Number = 0.0, 
								 pA:Number = 0.0, 
								 pB:Number = 0.0) {
			l = pL;
			a = pA;
			b = pB;
		};
		
		public static function get BLACK():LABColor {
			var result:LABColor = _pool.get(LABColor) as LABColor;
			
			if (!result) {
				_pool.allocate(LABColor, 1);
				result = new LABColor();
			}
			
			return result;
		};
		
		public static function fromXYZ(pXYZ:XYZColor):LABColor {
			var result:LABColor = LABColor.BLACK;
			
			var x:Number = adjust(pXYZ.x);
			var y:Number = adjust(pXYZ.y);
			var z:Number = adjust(pXYZ.z);
			
			result.l = 116 * (y - 16);
			result.a = 500 * (x -  y);
			result.b = 200 * (y -  z);
			
			return result;
		};
		
		private static function adjust(pInput:Number):Number {
			if (pInput > 0.008856) {
				pInput = Math.pow(pInput, 1 / 3);
			} else {
				pInput = 7.787 * pInput + 16 / 116;
			}
			
			return pInput;
		};
		
		public function get reflection():Class {
			return LABColor;
		};
		
		public function poolPrepare():void {
		};
		
		public function dispose():void {
		};
	}
}