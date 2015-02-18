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
  
