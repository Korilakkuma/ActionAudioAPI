package audioapi {

    public class AudioParam {

        private var _value:Number        = 0;
        private var _defaultValue:Number = 0;

        public function AudioParam() {
        }

        public function get value():Number {
            return this._value;
        }

        public function set value(value:Number):void {
            this._value = value;
        }

        public function get defaultValue():Number {
            return this._defaultValue;
        }

        public function set defaultValue(defaultValue:Number):void {
            this._defaultValue = defaultValue;
        }

        public function setValueAtTime():void {
        }

        public function linearLampTOValueAtTime():void {
        }

        public function setTargetAtTime():void {
        }

        public function cancelSheduledValues():void {
        }
    }

}
