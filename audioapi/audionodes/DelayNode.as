package audioapi.audionodes {

    import flash.events.SampleDataEvent;
    import flash.utils.ByteArray;

    import audioapi.AudioNode;
    import audioapi.AudioParam;

    public class DelayNode extends AudioNode {
        private var _delayTime:AudioParam = new AudioParam();
        private var _prevDelayTime:Number = 0;
        private var _maxValue:Number      = 1;

        private var _inputLs:ByteArray     = new ByteArray();
        private var _inputRs:ByteArray     = new ByteArray();
        private var _readPosition:Number   = 0;
        private var _writePosition:Number  = 0;
        private var _isDelayStart:Boolean  = false;

        public function DelayNode(maxDelayTime:Number = 1) {
            this._delayTime.value        = 0;
            this._delayTime.defaultValue = 0;
            this._maxValue               = maxDelayTime;
        }

        public function get delayTime():AudioParam {
            return this._delayTime;
        }

        override public function input(event:SampleDataEvent, inputL:Number = 0.0, inputR:Number = 0.0):void {
            if (this._prevDelayTime != this._delayTime.value) {
                // Change Delay Time -> Clear
                this._isDelayStart  = false;
                this._prevDelayTime = this._delayTime.value;

                this._inputLs.position = 0;
                this._inputRs.position = 0;

                this._readPosition     = 0;
                this._writePosition    = 0;
            }

            var maxSamples:Number    = Math.floor(this._maxValue * 44100);
            var targetSamples:Number = Math.floor(this._delayTime.value * 44100);

            if (this._writePosition < targetSamples) {
                this._inputLs.writeFloat(inputL);
                this._inputRs.writeFloat(inputR);

                this._writePosition++;
            } else if (this._writePosition == targetSamples) {
                this._inputLs.writeFloat(inputL);
                this._inputRs.writeFloat(inputR);

                this._isDelayStart = true;
            }

            if ((targetSamples != 0) && this._isDelayStart) {
                // Delay
                var currentPosition:Number = this._inputLs.position;

                this._inputLs.position = this._readPosition;
                this._inputRs.position = this._readPosition;

                if (this._inputLs.bytesAvailable > 0) {
                    var outputL:Number = this._inputLs.readFloat();
                    var outputR:Number = this._inputRs.readFloat();

                    this.output(event, outputL, outputR);
                    this._readPosition = this._inputLs.position;
                } else {
                    this.output(event, 0, 0);
                    this._readPosition = 0;
                }

                this._inputLs.position = currentPosition;
                this._inputRs.position = currentPosition;
            } else {
                // No Delay
                this.output(event, 0, 0);
            }
        }
    }

}
