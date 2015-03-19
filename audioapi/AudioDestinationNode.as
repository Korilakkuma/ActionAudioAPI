package audioapi {

    import flash.events.SampleDataEvent;

    public class AudioDestinationNode extends AudioNode {

        private var _outputL = 0;
        private var _outputR = 0;

        public function AudioDestinationNode() {
        }

        override public function input(event:SampleDataEvent, inputL:Number = 0.0, inputR:Number = 0.0):void {
            this.numberOfOutputs++;
            this._outputL += inputL;
            this._outputR += inputR;

            if (this.numberOfOutputs === this.numberOfConnections) {
                event.data.writeFloat(this._outputL);
                event.data.writeFloat(this._outputR);

                this.numberOfOutputs = 0;
                this._outputL        = 0;
                this._outputR        = 0;
            }
        }
    }

}
