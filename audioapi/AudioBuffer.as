package audioapi {

    import flash.utils.ByteArray;
    import flash.media.Sound;

    public class AudioBuffer {

        private var _sound:Sound       = null;
        private var _bufferSize:Number = 8192;
        private var _buffer:ByteArray  = null;
        private var _duration:Number   = 0;
        private var _length:Number     = 0;
        private var _sampleRate:Number = 44100;

        public function AudioBuffer(sound:Sound, bufferSize:Number = 8192, sampleRate:Number = 44100) {
            this._sound      = sound;
            this._bufferSize = bufferSize;
            this._duration   = (sound.length / (sound.bytesTotal / sound.bytesLoaded)) / 1000;
            this._length     = sound.bytesTotal;
            this._sampleRate = sampleRate;
        }

        public function getChannelData(channel:uint):ByteArray {
           var byteArray:ByteArray = new ByteArray();

           this._sound.extract(byteArray, this._bufferSize);

           return byteArray;
        }

        public function get duration():Number {
            return this._duration;
        }

        public function get length():Number {
            return this._length;
        }

        public function get sampleRate():Number {
            return this._sampleRate;
        }

    }

}
