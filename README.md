Action Audio API
=========
  
ActionScript 3.0 Library like [Web Audio API](http://webaudio.github.io/web-audio-api/)
  
## API

### AudioContext
  
* [AudioContext](http://webaudio.github.io/web-audio-api/#the-audiocontext-interface)
  
The 1st, it is required the instance of AudioContext is created.
  
    import audioapi.AudioContext;

    var context:AudioContext = new AudioContext(stage.frameRate);

    trace(context.sampleRate);   // 44100 Hz
    trace(context.currentTime);  // http://webaudio.github.io/web-audio-api/#the-audiocontext-interface
    trace(context.destination);  // the instance of AudioDestinationNode (http://webaudio.github.io/web-audio-api/#the-audiodestinationnode-interface)
  
### OscillatorNode
  
* [OscillatorNode](http://webaudio.github.io/web-audio-api/#the-oscillatornode-interface)
  
The instance of OscillatorNode is created by createOscillator method.
  
    import audioapi.AudioContext;
    import audioapi.audionodes.OscillatorNode;

    var context:AudioContext = new AudioContext(stage.frameRate);

    var oscillator:OscillatorNode = context.createOscillator();

    oscillator.connect(context.destination);
    oscillator.start();
  
### GainNode
  
* [GainNode](http://webaudio.github.io/web-audio-api/#the-gainnode-interface)
  
The instance of GainNode is created by createGain method.
  
    import audioapi.AudioContext;
    import audioapi.audionodes.OscillatorNode;
    import audioapi.audionodes.GainNode;

    var context:AudioContext = new AudioContext(stage.frameRate);

    var oscillator:OscillatorNode = context.createOscillator();
    var gain:GainNode             = context.createGain();

    oscillator.connect(gain);
    gain.connect(context.destination);

    oscillator.start();
  
### AudioBuffer / AudioBufferSourceNode
  
* [AudioBuffer](http://webaudio.github.io/web-audio-api/#the-audiobuffer-interface)
* [AudioBufferSourceNode](http://webaudio.github.io/web-audio-api/#the-audiobuffersourcenode-interface)
  
The instance of AudioBuffer is created by decodeAudioData method.  
The instance of AudioBufferSourceNode is created by createBufferSource method.
  
    import audioapi.AudioContext;
    import audioapi.AudioBuffer;
    import audioapi.audionodes.AudioBufferSourceNode;

    import flash.events.Event;
    import flash.media.Sound;
    import flash.net.URLRequest;

    var context:AudioContext = new AudioContext(stage.frameRate);

    var sound:Sound = new Sound();

    sound.addEventListener(Event.COMPLETE, function(event:Event):void {
        context.decodeAudioData(sound, function(audioBuffer:AudioBuffer):void {
            var source:AudioBufferSourceNode = context.createBufferSource();

            source.buffer = audioBuffer;

            source.connect(context.destination);

            source.start();

        }, function():void {
        });
    }, false, 0, true);

    sound.load(new URLRequest('sample.mp3'));
  
