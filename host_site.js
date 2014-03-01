var app = require("http").createServer(handler);
var fs = require("fs");

app.listen(25565)

function handler(req, res) {
	var path = req.url;
	if(path == "/") path = "/bin/index.html";
	fs.readFile(__dirname + path, function(err, data) {
		if(err) {
			res.writeHead(500);
			res.end("Couldnot get file: " + path);
		} else {
			res.writeHead(200);
			res.end(data);
		}
	});
}
