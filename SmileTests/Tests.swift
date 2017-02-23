//
//  Tests.swift
//  Smile
//
//  Created by Khoa Pham on 05/06/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import XCTest
import Smile

class Tests: XCTestCase {

  func test() {
    XCTAssertEqual(Smile.emoji(countryCode: "no"), "🇳🇴")
    XCTAssertEqual(Smile.name(emoji: "🇳🇴"), ["REGIONAL INDICATOR SYMBOL LETTER N", "REGIONAL INDICATOR SYMBOL LETTER O"])
    XCTAssertEqual(Smile.emojis(keywords: ["GRINNING"]), ["😁", "😸"])
    XCTAssertEqual(Smile.emoji(alias: "japanese_castle"), "🏯")
    XCTAssertEqual(Smile.alias(emoji: "🏯"), "japanese_castle")
    XCTAssertEqual(Smile.category(emoji: "😁"), "people")
    XCTAssertEqual(Smile.replaceAlias(string: ":santa: is coming to :european_castle:"), "🎅 is coming to 🏰")
    XCTAssertEqual(Smile.replaceAlias(string: "In the :circus_tent:, there are :dog:, :cat: and :unicorn:"), "In the 🎪, there are 🐶, 🐱 and :unicorn:")
    XCTAssertEqual(Smile.containsEmoji(string: "🎈 and 🎁"), true)
    XCTAssertEqual(Smile.containsEmoji(string: "just plain text"), false)
  }
}
