//
//  AppDelegate.swift
//  Sample-BonMot
//
//  Created by Eirny on 2016. 11. 11..
//  Copyright © 2016년 OutOfBedlam. All rights reserved.
//

import Cocoa
import BonMot

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  @IBOutlet weak var window: NSWindow!
  @IBOutlet weak var simpleExample: NSTextField!
  @IBOutlet weak var xmlExample: NSTextField!
  @IBOutlet weak var compositeExample: NSTextField!

  func applicationDidFinishLaunching(_ aNotification: Notification) {

    ///////////////////////////
    // SimpleExample
    simpleExample.attributedStringValue = "BonMot Example".styled(with: StringStyle(
      .tracking(.point(6)),
      .font(BONFont(name: "AvenirNextCondensed-Bold", size: 20)!),
      .alignment(.center)),
      .color(.red))

    ///////////////////////////
    // XML Example
    // 보통은 NSLocalizedString로 부터 가져옮니다
    let localizedXMLString =
      "I want to be different. If everyone is wearing <black><BON:noBreakSpace/>black,<BON:noBreakSpace/></black> I want to be wearing <red><BON:noBreakSpace/>red.<BON:noBreakSpace/></red>\n<signed><BON:emDash/>Maria Sharapova</signed> <racket/>"

    // 색상을 입힌 이미지를 가져와서 행 높이에 맞추기위해 베이스라인을 조정합니다.
    let racket = NSImage(named: "Tennis Racket")!.styled(with:
      .color(.raizlabsRed),
      .baselineOffset(-4.0))

    // 스타일을 정의합니다.
    let accent = StringStyle(.font(BONFont(name: "Chalkboard-Bold", size: 18)!))
    let black = accent.byAdding(.color(.white), .backgroundColor(.black))
    let red = accent.byAdding(.color(.white), .backgroundColor(.raizlabsRed))
    let signed = accent.byAdding(.color(.raizlabsRed))

    // 모든 xml 태그에 적용될 스타일들을 포함하여 하나의 스타일로 정의합니다.
    let baseStyle = StringStyle(
      .font(BONFont(name: "GillSans-Light", size: 18)!),
      .lineHeightMultiple(1.8),
      .color(.darkGray),
      .xmlRules([
        .style("black", black),
        .style("red", red),
        .style("signed", signed),
        .enter(element: "racket", insert: racket)
        ]))
    xmlExample.attributedStringValue = localizedXMLString.styled(with: baseStyle)

    ///////////////////////////
    // Composition Example
    let boat = NSImage(named: "boat")!.styled(with:
      .color(.raizlabsRed))

    let preamble = baseStyle.byAdding(
      .font(BONFont(name: "AvenirNext-Bold", size: 14)!))

    let bigger = baseStyle.byAdding(
      .font(BONFont(name: "AvenirNext-Heavy", size: 48)!))

    compositeExample.attributedStringValue = NSAttributedString.composed(of: [
      "You’re going to need a\n".styled(with: preamble),
      "Bigger\n".localizedUppercase.styled(with: bigger),
      boat,
      ], baseStyle: StringStyle(.alignment(.center), .color(.black)))

  }

  func applicationWillTerminate(_ aNotification: Notification) {
  }
}

extension NSColor {
  static var raizlabsRed: NSColor {
    return NSColor(red: 0xEC/0xFF, green: 0x59/0xFF, blue: 0x4D/0xFF, alpha: 1.0)
  }
}
