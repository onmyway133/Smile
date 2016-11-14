//
//  Helper.swift
//  Smile
//
//  Created by Khoa Pham on 05/06/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

func dropPrefix(_ string: String, subString: String) -> String {
  guard string.hasPrefix(subString),
    let range = string.range(of: subString) else { return string }

  return string.replacingCharacters(in: range, with: "")
}

func remove(_ string: String, set: Set<String>) -> String {
  var result = string
  set.forEach {
    result = result.replacingOccurrences(of: $0, with: "")
  }

  return result
}
