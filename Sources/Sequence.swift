//
//  Sequence.swift
//  Smile
//
//  Created by Khoa Pham on 24/02/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation

struct Sequence {

  struct Mark {
    static let zeroWidthJoiner: Character = emoji(unicodeValue: 0x200D)!
    static let presentationSelector: Character = emoji(unicodeValue: 0xFE0F)!
    static let enclosingKeyCap: Character = emoji(unicodeValue: 0x20E3)!
  }

  struct SkinTone {
    static let light: Character = emoji(unicodeValue: 0x1F3FB)!
    static let mediumLight: Character = emoji(unicodeValue: 0x1F3FC)!
    static let medium: Character = emoji(unicodeValue: 0x1F3FD)!
    static let mediumDark: Character = emoji(unicodeValue: 0x1F3FE)!
    static let dark: Character = emoji(unicodeValue: 0x1F3FF)!
  }

  static let all: [String] = [
    String(Mark.zeroWidthJoiner),
    String(Mark.presentationSelector),
    String(Mark.enclosingKeyCap),
    String(SkinTone.light),
    String(SkinTone.mediumLight),
    String(SkinTone.medium),
    String(SkinTone.mediumDark),
    String(SkinTone.dark)
  ]
}
