package audioapi {

    import flash.events.SampleDataEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.utils.ByteArray;

    public class AudioDestinationNode extends AudioNode {
        private static const BYTES_PER_ELEMENT = 4;

        private var outputLs:ByteArray = new ByteArray();
        private var outputRs:ByteArray = new ByteArray();

        private var sound:Sound = null;

        public function AudioDestinationNode() {
            this.outputLs.position = 0;
            this.outputRs.position = 0;
        }

        override public function input(inputL:Number = 0.0, inputR:Number = 0.0):void {
            if (this.outputLs.length > AudioNode.BUFFER_SIZE) {
                this.outputLs = new ByteArray();
                this.outputRs = new ByteArray();

                this.outputLs.position = 0;
                this.outputRs.position = 0;
            }

            this.outputLs.writeFloat(inputL);
            this.outputRs.writeFloat(inputR);

            if (this.sound == null) {
                this.sound = new Sound();

                this.sound.addEventListener(SampleDataEvent.SAMPLE_DATA, this.onaudioprocess, false, 0, true);
                this.sound.play();
            }
        }

        private function onaudioprocess(event:SampleDataEvent):void {
            for (var i:uint = 0; i < AudioNode.BUFFER_SIZE; i++) {
                this.outputLs.position = this.outputLs.length - AudioDestinationNode.BYTES_PER_ELEMENT;
                this.outputRs.position = this.outputRs.length - AudioDestinationNode.BYTES_PER_ELEMENT;

                event.data.writeFloat(this.outputLs.readFloat());
                event.data.writeFloat(this.outputRs.readFloat());
            }
        }
    }

}
