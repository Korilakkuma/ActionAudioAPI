package audioapi {

    import flash.display.Sprite;
    import flash.events.Event;

    import audioapi.audionodes.OscillatorNode;
    import audioapi.audionodes.GainNode;

    public class AudioContext extends Sprite {
        private var _destination:AudioDestinationNode = new AudioDestinationNode();

        private var _sampleRate:Number  = 44100;
        private var _currentTime:Number = 0;

        private var _frameRate    = 30;
        private var _frameCounter = 0;

        public function AudioContext(frameRate:uint = 30) {
            this._frameRate = frameRate;
            this.addEventListener(Event.ENTER_FRAME, this.updateCurrentTime, false, 0, true);
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

        public function createGain():GainNode {
            return new GainNode();
        }

        public function createOscillator():OscillatorNode {
            return new OscillatorNode(this.sampleRate);
        }

        private function updateCurrentTime(event:Event):void {
            this._frameCounter++;

            this._currentTime = this._frameCounter * (1 / this._frameRate);
        }
    }

}
