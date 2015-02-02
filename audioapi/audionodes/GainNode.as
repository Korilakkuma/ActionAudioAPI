package audioapi.audionodes {

    import flash.events.SampleDataEvent;

    import audioapi.AudioNode;
    import audioapi.AudioParam;

    public class GainNode extends AudioNode {
        private var _gain:AudioParam = new AudioParam();

        public function GainNode() {
            this._gain.value        = 1;
            this._gain.defaultValue = 1;
        }

        public function get gain():AudioParam {
            return this._gain;
        }

        override public function input(event:SampleDataEvent, inputL:Number = 0.0, inputR:Number = 0.0):void {
            var outputL:Number = this._gain.value * inputL;
            var outputR:Number = this._gain.value * inputR;

            this.output(event, outputL, outputR);
        }
    }

}
