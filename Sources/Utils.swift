//
//  Utils.swift
//  Smile
//
//  Created by Khoa Pham on 05/06/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

struct Utils {

  static func dropPrefix(string: String, subString: String) -> String {
    guard string.hasPrefix(subString),
      let range = string.range(of: subString) else {
      return string
    }

    return string.replacingCharacters(in: range, with: "")
  }

  static func remove(string: String, set: Set<String>) -> String {
    var result = string
    set.forEach {
      result = result.replacingOccurrences(of: $0, with: "")
    }
    
    return result
  }

  static func flatten(string: String, base: UInt32 = 0) -> [String] {
    return string.unicodeScalars.compactMap { scalarView in
      if let scalar = UnicodeScalar(base + scalarView.value) {
        return String(scalar)
      } else {
        return nil
      }
    }
  }

  static func flattenCharacters(string: String) -> [String] {
    return string.map { character in
      return String(character)
    }
  }

  static func insert(element: String, betweenArray array: [String]) -> [String] {
    var result = [String]()
    array.forEach {
      result.append($0)
      result.append(element)
    }

    return Array(result.dropLast())
  }

  static func add<T>(element: T, array: [T]) -> [T] {
    var array = array
    array.append(element)

    return array
  }
}

