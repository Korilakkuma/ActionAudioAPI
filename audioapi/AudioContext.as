package audioapi {

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.utils.ByteArray;
    import flash.media.Sound;

    import audioapi.AudioNode;
    import audioapi.AudioBuffer;
    import audioapi.audionodes.AudioBufferSourceNode;
    import audioapi.audionodes.OscillatorNode;
    import audioapi.audionodes.GainNode;
    import audioapi.audionodes.DelayNode;

    public class AudioContext extends Sprite {
        private var _destination:AudioDestinationNode = new AudioDestinationNode();

        private var _sampleRate:Number  = 44100;
        private var _currentTime:Number = 0;

        private var _frameRate    = 30;
        private var _frameCounter = 0;

        public function AudioContext(frameRate:uint = 30) {
            var self:AudioContext = this;

            this._frameRate = frameRate;

            this.addEventListener(Event.ENTER_FRAME, function(event:Event):void {
                self._frameCounter++;
                self._currentTime = self._frameCounter * (1 / self._frameRate);
            }, false, 0, true);
        }

        public function get sampleRate():Number {
            return this._sampleRate;
        }

        public function get currentTime():Number {
            return this._currentTime
        }

        public function get destination():AudioDestinationNode {
            return this._destination;
        }

        public function createBufferSource():AudioBufferSourceNode {
            return new AudioBufferSourceNode();
        }

        public function createOscillator():OscillatorNode {
            return new OscillatorNode(this.sampleRate);
        }

        public function createGain():GainNode {
            return new GainNode();
        }

        public function createDelay(maxDelayTime:Number = 1) {
            return new DelayNode(maxDelayTime);
        }

        public function decodeAudioData(sound:Sound, successCallback:Function, errorCallback:Function):void {
            var audioBuffer:AudioBuffer = new AudioBuffer(sound, AudioNode.BUFFER_SIZE, this._sampleRate);

            if (audioBuffer) {
                successCallback(audioBuffer);
            } else {
                errorCallback();
            }
        }
    }

}
