//
//  Smile.swift
//  Smile
//
//  Created by Khoa Pham on 05/06/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

// MARK: - Name

/// Return standard name for a emoji
public func name(emoji: Character) -> [String] {
  let string = NSMutableString(string: String(emoji))
  var range = CFRangeMake(0, CFStringGetLength(string))
  CFStringTransform(string, &range, kCFStringTransformToUnicodeName, false)

  return dropPrefix(String(string), subString: "\\N")
    .components(separatedBy: "\\N")
    .map {
      return remove($0, set: (Set(["{", "}"])))
    }
}


// MARK: - List

/// List all emojis
public func list() -> [Character] {
  let ranges = [
    0x1F601...0x1F64F,
    0x2702...0x27B0,
    0x1F680...0x1F6C0,
    0x1F170...0x1F251
  ]

  return ranges.joined().map {
    return Character(UnicodeScalar($0)!)
  }
}

// MARK: - Flag

/// Return emoji for a flag
public func emoji(countryCode: String) -> Character {
  let base = UnicodeScalar("🇦").value - UnicodeScalar("A").value

  var string = ""
  countryCode.uppercased().unicodeScalars.forEach {
    if let scala = UnicodeScalar(base + $0.value) {
      string.append(String(describing: scala))
    }
  }

  return Character(string)
}

// MARK: - Keywords

/// Search emoji by keywords
public func emojis(keywords: [String]) -> [Character] {
  var result: [Character] = []

  list().forEach { emoji in
    keywords.forEach { keyword in
      name(emoji: emoji).forEach { name in
        if name.range(of: keyword) != nil {
          result.append(emoji)
        }
      }
    }
  }

  return result
}

// MARK: - Alias

/// Return emoji for an alias
public func emoji(alias: String) -> String? {
  return emojiList[alias]
}

/// Find alias of emoji
public func alias(emoji: Character) -> String? {
  for (key, value) in emojiList {
    if value == String(emoji) {
      return key
    }
  }

  return nil
}

/// Replace alias within a string by emoji
public func replaceAlias(string: String) -> String {
  guard let regex = try? NSRegularExpression(pattern: ":.*?:", options: .caseInsensitive) else {
    return string
  }

  let range = NSMakeRange(0, string.characters.count)
  var mutableString = string
  regex.enumerateMatches(in: string, options: [], range: range) { (result, flags, context) in
    guard let range = result?.range else {
      return
    }

    let start = string.index(string.startIndex, offsetBy: range.location)
    let end = string.index(start, offsetBy: range.length)

    let alias = string.substring(with: start..<end).replacingOccurrences(of: ":", with: "")

    guard let emoji = emoji(alias: alias) else {
      return
    }

    mutableString = mutableString.replacingOccurrences(of: ":\(alias):", with: emoji)
  }

  return mutableString
}

// MARK: - Category

/// Determine the category of emoji
public func category(emoji: Character) -> String? {
  for (category, list) in emojiCategories {
    if list.contains(String(emoji)) {
      return category
    }
  }

  return nil
}

// MARK: - Query

public func containsEmoji(string: String) -> Bool {
  let set = CharacterSet(charactersIn: emojiList.values.joined())
  return string.rangeOfCharacter(from: set) != nil
}
