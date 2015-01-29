package audioapi.audionodes {

    import flash.events.SampleDataEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;

    import audioapi.AudioNode;
    import audioapi.AudioParam;

    public class OscillatorNode extends AudioNode {
        private var sound:Sound          = null;
        private var channel:SoundChannel = null;

        private var sampleRate:uint = 441000;

        private var _type:String          = 'sine';
        private var _frequency:AudioParam = new AudioParam();
        private var _detune:AudioParam    = new AudioParam();

        public function OscillatorNode(sampleRate:uint) {
            this.sampleRate = sampleRate;

            this._frequency.value        = 440;
            this._frequency.defaultValue = 440;

            this._detune.value        = 0;
            this._detune.defaultValue = 0;
        }

        public function start():void {
            this.sound = new Sound();

            this.sound.addEventListener(SampleDataEvent.SAMPLE_DATA, this.onaudioprocess, false, 0, true);
            this.channel = this.sound.play();
        }

        public function stop():void {
            this.channel.stop();
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

        private function onaudioprocess(event:SampleDataEvent):void {
            var t0 = this.sampleRate / this._frequency.value;
            var n  = 0;

            for (var i:uint = 0; i < AudioNode.BUFFER_SIZE; i++) {
                var output:Number = 0;

                switch (this._type) {
                    case 'sine' :
                        output = Math.sin((2 * Math.PI * this._frequency.value * n) / this.sampleRate);
                        break;
                    case 'square' :
                        output = (n < (t0 / 2)) ? 1 : -1;
                        break;
                    case 'sawtooth' :
                        var s:Number = 2 * n / t0;

                        output = s - 1;
                        break;
                    case 'triangle' :
                        var s:Number = 4 * n / t0;

                        output = (n < (t0 / 2)) ? (-1 + s) : (3 - s);
                        break;
                    default :
                        break;
                }

                this.output(output, output);
                event.data.writeFloat(0);
                event.data.writeFloat(0);

                n++;

                if (n >= t0) {
                    n = 0;
                }
            }
        }
    }

}
