//
//  Smile.swift
//  Smile
//
//  Created by Khoa Pham on 05/06/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

// MARK: - List

/// List all emojis
public func list() -> [String] {
  let ranges = [
    0x1F601...0x1F64F,
    0x2702...0x27B0,
    0x1F680...0x1F6C0,
    0x1F170...0x1F251
  ]

  return ranges.joined().map {
    return String(Character(UnicodeScalar($0)!))
  }
}

// MARK: - Emoji

/// Check if a character is emoji
public func isEmoji(character: String) -> Bool {
  return emojiList.values.contains(character)
}

/// Check if a string contains any emojis
public func containsEmoji(string: String) -> Bool {
  let set = CharacterSet(charactersIn: emojiList.values.joined())
  return string.rangeOfCharacter(from: set) != nil
}

/// Get emoji from unicode value
public func emoji(unicodeValue: Int) -> Character? {
  if let scalar = UnicodeScalar(unicodeValue) {
    return Character(scalar)
  } else {
    return nil
  }
}

// MARK: - Name

/// Return standard name for a emoji
public func name(emoji: String) -> [String] {
  let string = NSMutableString(string: String(emoji))
  var range = CFRangeMake(0, CFStringGetLength(string))
  CFStringTransform(string, &range, kCFStringTransformToUnicodeName, false)

  return dropPrefix(String(string), subString: "\\N")
    .components(separatedBy: "\\N")
    .map {
      return remove($0, set: (Set(["{", "}"])))
  }
}

// MARK: - Flag

/// Return emoji for a flag
public func emoji(countryCode: String) -> String {
  let base = UnicodeScalar("🇦").value - UnicodeScalar("A").value

  var string = ""
  countryCode.uppercased().unicodeScalars.forEach {
    if let scala = UnicodeScalar(base + $0.value) {
      string.append(String(describing: scala))
    }
  }

  return string
}

// MARK: - Keywords

/// Search emoji by keywords
public func emojis(keywords: [String]) -> [String] {
  var result: [String] = []

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
public func alias(emoji: String) -> String? {
  for (key, value) in emojiList {
    if value == emoji {
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
public func category(emoji: String) -> String? {
  for (category, list) in emojiCategories {
    if list.contains(emoji) {
      return category
    }
  }

  return nil
}

// MARK: - Manipulation

/// Extract all emojis within a string
public func extractEmojis(string: String) -> String {
  return String(string.characters.filter({
    return isEmoji(character: String($0))
  }))
}

/// Remove all emojis within a string
public func removeEmojis(string: String) -> String {
  return String(string.characters.filter({
    return !isEmoji(character: String($0))
  }))
}

/// Assemble many emojis into one
public func assemble(emojis: [String]) -> String {
  var result = [String]()
  emojis.forEach { emoji in
    emoji.unicodeScalars.forEach({ unicodeScalar in
      result.append("U+\(String(unicodeScalar.value, radix: 6, uppercase: true))")
    })
  }

  return result.joined(separator: String(Sequence.zeroWidthJoiner))
}

/// Disassemble an emoji into many
public func disassemble(emoji: String) -> [String] {
  return emoji.unicodeScalars.map({ unicodeScalar in
    return String(Character(unicodeScalar))
  }).filter({ character in
    return isEmoji(character: character)
  })
}
