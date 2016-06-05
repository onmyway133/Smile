//
//  Smile.swift
//  Smile
//
//  Created by Khoa Pham on 05/06/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

/**
 Return standard name for a emoji
 */
public func standardName(emoji: Character) -> [String] {
  let string = NSMutableString(string: String(emoji))
  var range = CFRangeMake(0, CFStringGetLength(string))
  CFStringTransform(string, &range, kCFStringTransformToUnicodeName, false)

  return dropPrefix(String(string), subString: "\\N")
    .componentsSeparatedByString("\\N")
    .map {
      return remove($0, set: (Set(["{", "}"])))
    }
}

/**
 Return emoji for an alias
 */
public func emoji(alias alias: String) -> String? {
  return emojiList[alias]
}

/**
 List all emojis
 */
public func list() -> [Character] {
  let ranges = [
    0x1F601...0x1F64F,
    0x2702...0x27B0,
    0x1F680...0x1F6C0,
    0x1F170...0x1F251
  ]

  return ranges.flatten().map {
    return Character(UnicodeScalar($0))
  }
}

/**
 Return emoji for a flag
 */
public func emoji(countryCode countryCode: String) -> Character {
  let base = UnicodeScalar("🇦").value - UnicodeScalar("A").value

  let string = countryCode.uppercaseString.unicodeScalars.reduce("") {
    var string = $0
    string.append(UnicodeScalar(base + $1.value))
    return string
  }

  return Character(string)
}

/**
 Search emoji by keywords
 */
public func search(keywords: [String]) -> [Character] {
  var result: [Character] = []

  list().forEach { emoji in
    keywords.forEach { keyword in
      standardName(emoji).forEach { name in
        if name.rangeOfString(keyword) != nil {
          result.append(emoji)
        }
      }
    }
  }

  return result
}
