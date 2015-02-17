package audioapi.audionodes {

    import flash.events.SampleDataEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;

    import audioapi.AudioNode;
    import audioapi.AudioParam;

    public class OscillatorNode extends AudioNode {
        private var _sound:Sound          = null;
        private var _channel:SoundChannel = null;

        private var _sampleRate:uint = 441000;

        private var _type:String          = 'sine';
        private var _frequency:AudioParam = new AudioParam();
        private var _detune:AudioParam    = new AudioParam();

        public function OscillatorNode(sampleRate:uint) {
            this._sampleRate = sampleRate;

            this._frequency.value        = 440;
            this._frequency.defaultValue = 440;

            this._detune.value        = 0;
            this._detune.defaultValue = 0;
        }

        public function start():void {
            var self:OscillatorNode = this;

            this._sound = new Sound();

            this._sound.addEventListener(SampleDataEvent.SAMPLE_DATA, function(event:SampleDataEvent):void {
                var f:Number  = self._frequency.value + ((self._detune.value / 100) * Math.pow(2, (1 / 12)));
                var t0:Number = self._sampleRate / f;
                var n:uint    = 0;
                var s:Number  = 0;

                for (var i:uint = 0; i < AudioNode.BUFFER_SIZE; i++) {
                    var output:Number = 0;

                    switch (self._type) {
                        case 'sine' :
                            output = Math.sin((2 * Math.PI * f * n) / this._sampleRate);
                            break;
                        case 'square' :
                            output = (n < (t0 / 2)) ? 1 : -1;
                            break;
                        case 'sawtooth' :
                            s = 2 * n / t0;

                            output = s - 1;
                            break;
                        case 'triangle' :
                            s = 4 * n / t0;

                            output = (n < (t0 / 2)) ? (-1 + s) : (3 - s);
                            break;
                        default :
                            break;
                    }

                    self.output(event, output, output);

                    n++;

                    if (n >= t0) {
                        n = 0;
                    }
                }
            }, false, 0, true);

            this._channel = this._sound.play();
        }

        public function stop():void {
            this._channel.stop();
        }

        public function get type():String {
            return this._type;
        }

        public function set type(type:String):void {
            switch (type) {
                case 'sine'     :
                case 'square'   :
                case 'sawtooth' :
                case 'triangle' :
                    this._type = type;
                    break;
                default :
                    break;
            }
        }

        public function get frequency():AudioParam {
            return this._frequency;
        }

        public function get detune():AudioParam {
            return this._detune;
        }
    }

}
