package audioapi.audionodes {

    import flash.utils.ByteArray;
    import flash.events.SampleDataEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;

    import audioapi.AudioNode;
    import audioapi.AudioParam;
    import audioapi.AudioBuffer;
    import fl.motion.easing.Back;

    public class AudioBufferSourceNode extends AudioNode {

        private var _buffer:AudioBuffer  = null;
        private var _playbackRate:Number = 1;
        private var _loop:Boolean        = false;

        private var _sound:Sound          = null;
        private var _channel:SoundChannel = null;

        public function AudioBufferSourceNode() {
        }

        public function start():void {
            if (!(this._buffer is AudioBuffer)) {
                return;
            }

            var self:AudioBufferSourceNode = this;

            this._sound = new Sound();
            this._sound.addEventListener(SampleDataEvent.SAMPLE_DATA, function(event:SampleDataEvent):void {
                var byteArray:ByteArray = self._buffer.getChannelData(0);

                byteArray.position = 0;

                while (byteArray.bytesAvailable > 0) {
                    var outputL:Number = byteArray.readFloat();
                    var outputR:Number = byteArray.readFloat();

                    self.output(event, outputL, outputR);

                    //byteArray.position += (this._playbackRate * 4);
                }
            }, false, 0, true);

            this._channel = this._sound.play();
        }

        public function stop():void {
            this._channel.stop();
        }

        public function get buffer():AudioBuffer {
            return this._buffer;
        }

        public function set buffer(buffer:AudioBuffer):void {
            this._buffer = buffer;
        }

        public function get playbackRate():Number {
            return this._playbackRate;
        }

        public function set playbackRate(playbackRate:Number):void {
            if (playbackRate > 0) {
                this._playbackRate = playbackRate;
            }
        }

        public function get loop():Boolean {
            return this._loop;
        }

        public function set loop(loop:Boolean):void {
            this.loop = loop;
        }
    }

}
