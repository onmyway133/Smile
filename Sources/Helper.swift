//
//  Helper.swift
//  Smile
//
//  Created by Khoa Pham on 05/06/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

func dropPrefix(string: String, subString: String) -> String {
  guard string.hasPrefix(subString),
    let range = string.rangeOfString(subString) else { return string }

  return string.stringByReplacingCharactersInRange(range, withString: "")
}

func remove(string: String, set: Set<String>) -> String {
  var result = string
  set.forEach {
    result = result.stringByReplacingOccurrencesOfString($0, withString: "")
  }

  return result
}
