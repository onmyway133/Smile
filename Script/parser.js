'use strict';

var https = require('https');
var fs = require('fs');

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

download('https://cdn.rawgit.com/github/gemoji/master/db/emoji.json', function(data) {
	parse(data);
});

function parse(data) {
  const json = JSON.parse(data);

  var string = 'let emojiList: [String: String] = [\n'
  for (var i=0; i<json.length; ++i) {
    const item = json[i];

    if (typeof item.aliases === "undefined"
    || typeof item.emoji === "undefined"
    || item.emoji == "undefined") {
      continue;
    }

    const itemString = '  "' + item.aliases[0] + '": "' + item.emoji + '",\n'
    string = string + itemString
  }

  string = string + ']'

  fs.writeFile('../Sources/Emoji.swift', string);
};
