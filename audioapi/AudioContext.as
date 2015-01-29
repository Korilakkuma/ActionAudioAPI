package audioapi {

    import flash.display.Sprite;
    import flash.events.Event;

    import audioapi.audionodes.OscillatorNode;

    public class AudioContext extends Sprite {

        public var destination:AudioDestinationNode = new AudioDestinationNode();

        public var sampleRate:uint    = 44100;
        public var currentTime:Number = 0;

        private var frameRate    = 30;
        private var frameCounter = 0;

        public function AudioContext(frameRate:uint = 30) {
            this.frameRate = frameRate;
            this.addEventListener(Event.ENTER_FRAME, this.updateCurrentTime, false, 0, true);
        }

        public function createOscillator():OscillatorNode {
            return new OscillatorNode(this.sampleRate);
        }

        private function updateCurrentTime(event:Event):void {
            this.frameCounter++;

            this.currentTime = this.frameCounter * (1 / this.frameRate);
        }
    }

}
