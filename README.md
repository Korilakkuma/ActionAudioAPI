Action Audio API
=========
  
ActionScript 3.0 Library like Web Audio API
  
## API

### AudioContext
  
The 1st, it is required the instance of AudioContext is created.
  
    import audioapi.AudioContext;

    var context:AudioContext = new AudioContext(stage.frameRate);

    trace(context.sampleRate);   // 44100 Hz
    trace(context.currentTime);  // http://webaudio.github.io/web-audio-api/#the-audiocontext-interface
    trace(context.destination);  // the instance of AudioDestinationNode
  
