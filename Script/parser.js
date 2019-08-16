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
var categories = {};

download('https://cdn.rawgit.com/github/gemoji/master/db/emoji.json', function(data) {
  parse(data);
  parse_categories();
});

function parse(data) {
  const json = JSON.parse(data);

  var string = 'public let emojiList: [String: String] = [\n'

  json.forEach(function(item){    
    if (typeof item.aliases === "undefined"
    || typeof item.emoji === "undefined"
    || item.emoji == "undefined") {
      return;
    }
    
    const itemString = '  "' + item.aliases[0] + '": "' + item.emoji + '",\n'
    string = string + itemString
    
    if (!categories[item.category]) {
      categories[item.category] = []
    } 
    categories[item.category].push(item.emoji);
  })
  
  string = string + ']'

  fs.writeFileSync('../Sources/Emoji.swift', string);
};


function parse_categories() {
  var string = 'public let emojiCategories: [String: [String]] = [\n'  
  Object.keys(categories).forEach(function(category) {    
    const emojis = categories[category].map(function(emoji) {
			return '"' + emoji + '"';
		}).join(",");

    const itemString = '  "' + category + '": [' + emojis + '],\n'
    string = string + itemString
  });
  
  string = string + ']'

	fs.writeFileSync('../Sources/Categories.swift', string);
};
