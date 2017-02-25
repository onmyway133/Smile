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

  func testName() {
    XCTAssertEqual(Smile.name(emoji: "🇳🇴"), ["REGIONAL INDICATOR SYMBOL LETTER N", "REGIONAL INDICATOR SYMBOL LETTER O"])
  }

  func testKeywords() {
    XCTAssertEqual(Smile.emojis(keywords: ["GRINNING"]), ["😁", "😸"])
  }

  func testEmoji() {
    XCTAssertEqual(Smile.emoji(unicodeValue: 0x23F0), "⏰")
    XCTAssertEqual(Smile.emoji(unicodeValue: 0x1F47B), "👻")
    XCTAssertEqual(Smile.emoji(unicodeValue: 0x1F517), "🔗")
  }

  func testIsEmoji() {
    XCTAssertEqual(Smile.isEmoji(character: "🎉"), true)
    XCTAssertEqual(Smile.isEmoji(character: "👨‍✈️"), true)
    XCTAssertEqual(Smile.isEmoji(character: "a"), false)
  }

  func testContainsEmoji() {
    XCTAssertEqual(Smile.containsEmoji(string: "🎈 and 🎁"), true)
    XCTAssertEqual(Smile.containsEmoji(string: "👨‍✈️"), true)
    XCTAssertEqual(Smile.containsEmoji(string: "just plain text"), false)
  }

  func testList() {
    XCTAssertTrue(Smile.list().count > 0)
  }

  func testFlag() {
    XCTAssertEqual(Smile.emoji(countryCode: "no"), "🇳🇴")
  }

  func testCategory() {
    XCTAssertEqual(Smile.category(emoji: "😁"), "people")
  }

  func testAlias() {
    XCTAssertEqual(Smile.emoji(alias: "japanese_castle"), "🏯")
    XCTAssertEqual(Smile.alias(emoji: "🏯"), "japanese_castle")
    XCTAssertEqual(Smile.alias(emoji: "👨‍✈️"), "man_pilot")
  }

  func testReplaceAlias() {
    XCTAssertEqual(Smile.replaceAlias(string: ":construction_worker_man: is coming to :european_castle:"), "👷 is coming to 🏰")
    XCTAssertEqual(Smile.replaceAlias(string: "In the :circus_tent:, there are :dog:, :cat: and :super_unicorn:"), "In the 🎪, there are 🐶, 🐱 and :super_unicorn:")
  }

  func testExtractEmoji() {
    XCTAssertEqual(Smile.extractEmojis(string: "Find 🔑and🔎"), "🔑🔎")
    XCTAssertEqual(Smile.extractEmojis(string: "Find the 👨‍✈️"), "👨‍✈️")
  }

  func testRemoveEmoji() {
    XCTAssertEqual(Smile.removeEmojis(string: "Find 🔑and🔎"), "Find and")
    XCTAssertEqual(Smile.removeEmojis(string: "Remove the 👨‍✈️"), "Remove the ")
  }

  func testAssemble() {
    XCTAssertEqual(Smile.assemble(emojis: ["👍", Smile.Sequence.SkinTone.light]), "👍🏻")
    XCTAssertEqual(Smile.assemble(emojis: ["👨", "✈️"]), "👨‍✈️")
  }

  func testDisassemble() {
    XCTAssertEqual(Smile.disassemble(emoji: "👨‍🏫"), ["👨", "🏫"])
    XCTAssertEqual(Smile.disassemble(emoji: "👨‍✈️"), ["👨", "✈️"])
  }
}
