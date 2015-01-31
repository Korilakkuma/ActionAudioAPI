﻿package audioapi {

    import flash.events.SampleDataEvent;

    public class AudioNode {
        public static const BUFFER_SIZE:uint = 4096;

        protected var inputs:Array  = [];
        protected var outputs:Array = [];

        public function AudioNode() {
        }

        public function connect(node:AudioNode, channel:uint = 0):void {
            if (channel >= 0) {
                this.outputs[channel] = node;
                node.inputs[channel]  = this;
            }
        }

        public function disconnect(channel:uint = 0):void {
            if (channel >= 0) {
                this.outputs[channel].inputs[channel] = null;
                this.outputs[channel]                 = null;
            }
        }

        public function input(event:SampleDataEvent, inputL:Number = 0.0, inputR:Number = 0.0):void {
            this.output(event, inputL, inputR);
        }

        public function output(event:SampleDataEvent, outputL:Number = 0.0, outputR:Number = 0.0):void {
            for (var i:uint = 0, len = this.outputs.length; i < len; i++) {
                if (this.outputs[i] is AudioNode) {
                    this.outputs[i].input(event, outputL, outputR);
                }
            }
        }

    }

}
