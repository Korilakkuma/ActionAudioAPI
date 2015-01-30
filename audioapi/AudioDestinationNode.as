package audioapi {

    import flash.events.SampleDataEvent;

    public class AudioDestinationNode extends AudioNode {

        public function AudioDestinationNode() {
        }

        override public function input(event:SampleDataEvent, inputL:Number = 0.0, inputR:Number = 0.0):void {
            event.data.writeFloat(inputL);
            event.data.writeFloat(inputR);
        }
    }

}
