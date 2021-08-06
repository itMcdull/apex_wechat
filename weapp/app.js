// app.js
App({
  onLaunch() {
    const { Engine, WXApp } = require('./mpdom.min');
    const engine = new Engine();
    var dev = true;
    if (dev) {
      engine.initWithDebuggerServerAddr('127.0.0.1:9898');
    }
    else {
      engine.initWithCodeBlock(Engine.codeBlockWithFile('./main.dart.js'));
    }
    const app = new WXApp('pages/index/index', engine);
    global.app = app;
    engine.start();
  },
  globalData: {}
})
