package ncolor {
    import npooling.IReusable;

    public class HSVColor implements IReusable {
        public var h:Number;
        public var s:Number;
        public var v:Number;

        private var _disposed:Boolean;

        public function HSVColor(pH:Number = 0.0, pS:Number = 0.0, pV:Number = 0.0) {
            h = pH;
            s = pS;
            v = pV;
        }

        public function get reflection():Class {
             return HSVColor;
        }

        public function get disposed():Boolean {
            return _disposed;
        }

        public function poolPrepare():void {
            h = 0.0;
            s = 0.0;
            v = 0.0;
        }

        public function dispose():void {
            _disposed = true;

            poolPrepare();
        }
    }
}
