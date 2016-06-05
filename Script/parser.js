'use strict';

var https = require('https');

function download(url, callback) {
	https.get(url, function(res) {
		var data = "";
		res.on('data', function (chunk) {
		  data += chunk;
		});

		res.on("end", function() {
		  callback(data);
		});

	}).on("error", function() {
	  	callback(null);
	});
}

download('https://github.com/github/gemoji/blob/master/db/emoji.json', function(data) {
	parse(data);
});

function parse(data) {
	console.log(data)
};
