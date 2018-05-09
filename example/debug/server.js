var _  = require('lodash');
var fs  = require('fs');
var express  = require('express');
var WebSocket  = require('ws');

var app = express();
var target = '../TestApplication/qml';
app.use(express.static(target));
app.listen(44333);
console.log('serving static file at: ', 44333);

var wss = new WebSocket.Server({ port: 44334 });

wss.on('connection', function(ws) {
  ws.on('close', function(reasonCode, description) {
    console.log(timeNow() + ' client disconnected.');
  });

  console.log(timeNow() + ' client connected');
  var fileChangeDebounce = _.debounce(onFileChange, 800);
  fs.watch(target, fileChangeDebounce);

  function onFileChange(eventType, filename)  {
    console.log(timeNow(), ' event: ' + eventType + ' | ' + filename);
    var message = {action: 'reload'};
    ws.send(JSON.stringify(message), function() {});
  }
  function timeNow() {
    var d = new Date(),
        h = (d.getHours()<10?'0':'') + d.getHours(),
        m = (d.getMinutes()<10?'0':'') + d.getMinutes(),
        s = (d.getSeconds()<10?'0':'') + d.getSeconds();
    return h + ':' + m + ':' + s;
  }
});

console.log('watching file change and send signal to port: ', 44334);
