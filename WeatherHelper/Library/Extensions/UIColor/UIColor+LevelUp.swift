//
//  UIColor+LevelUp.swift
//  Level Up
//
//  Created by Живоженко Дмитрий on 01/12/2017.
//  Copyright © 2017 Stream LLC. All rights reserved.
//

import UIKit

public extension UIColor {

    static let tealishGreen = fromHexString("00E762")
    static let springGreen = fromHexString("00E861")
    static let pastelGreen = fromHexString("6FD993")
    static let scarlet = fromHexString("FF2600")
    static let whiteSmoke = fromHexString("F1F1F1")
    static let grey = fromHexString("7F7F7F")
    static let mercury = fromHexString("E8E8E8")
    static let transparentGallery = fromHexString("E8E8E8", alpha: 0.83)
    static let gainsboro = fromHexString("E5E5E5")
    static let nobel = fromHexString("9B9B9B")
    static let ripeLemon = fromHexString("F8E71C")
    static let torchRed = fromHexString("FF0438")
    static let alto = fromHexString("E0E0E0")
    static let concrete = fromHexString("F2F2F2")
    static let turquoiseBlue = fromHexString("53E4DD")
    static let mantis = fromHexString("BB4079")
    static let burningOrange = fromHexString("FF793E")
    static let portage = fromHexString("B471F0")
    static let cornflowerBlue = fromHexString("7460EE")
    static let texasRose = fromHexString("FFBE49")
    static let veryLightGray = fromHexString("CECECE")
    static let salem = fromHexString("1E854B")
    static let summerGreen = fromHexString("8EC2A5")
    static let dustyGray = fromHexString("979797")
    static let mineShaft = fromHexString("333333")
    static let oxley = fromHexString("609A73")
    static let carissma = fromHexString("E3888A")
    static let silverChalice = fromHexString("A8A8A8")
    static let tulipTree = fromHexString("F0AF45")
    static let transparentBlack = fromHexString("000000", alpha: 0.6)
    static let snuff = fromHexString("DBD9DB")
    static let athensGrey = fromHexString("D7D9DB")
    static let snowWhite = fromHexString("FAFAFA")
    static let blockShadow = fromHexString("C1C2C5")
    static let tiber = fromHexString("102030")
    static let pinkSwan = fromHexString("2B2B2B")
    static let olympusWhite = fromHexString("F2F3F7")

    // MARK: - New design
    // https://zpl.io/bA44kYn
    static let greyRaven = fromHexString("6E7782")
    static let veryLightGrey = fromHexString("C7C7C7")
    static let mtsRed = fromHexString("E30611")
    static let normalApple = fromHexString("26CD58")
    static let darkApple = fromHexString("04AA42")
    static let blackPearl = fromHexString("001424")
    static let orangeNormal = fromHexString("F95721")
    static let cranberryDark = fromHexString("BB4079")
    static let bananaDark = fromHexString("FAC031")
    static let mintNormal = fromHexString("00C19B")
    static let raspberryNormal = fromHexString("EA1F49")
    static let blackberryNormal = fromHexString("014FCE")
    static let darkBlueberry = fromHexString("007CFF")
    static let greyHeather = fromHexString("BBC1C7")
    static let greyChateau = fromHexString("9198A0")
    static let athensGray = fromHexString("E2E5EB")
    static let funGreen = fromHexString("027722")
    static let crimson = fromHexString("C51345")
    static let brinkPink = fromHexString("F55F7E")
    static let ebonyClay = fromHexString("202D3D")
    static let darkestYellow = fromHexString("F37F19")
    static let orangeRoughy = fromHexString("E04A17")
    static let lightestBlueberry = fromHexString("E1F3FE")
    static let anakiwa = fromHexString("B1E1FF")

    // NOTE: The color naming as below is deprecated. Use actual color names.
    // If you need a color from below, move it up (or copypaste) & rename it.

    static let answeredQuestionPoint = UIColor.black

    // MARK: Lesson Tasks

    static let answerChoiceSeparatorBackground = fromHexString("979797")
    static let succeedValidationText = fromHexString("1FE84F")
    static let notCheckedValidationBackground = UIColor.black
    static let tabbarSelectedBackground = fromHexString("DB0000")
    static let examScoreColor = fromHexString("FF0000")
    static let paymentShadowColor = fromHexString("3DED88")
    static let dragIndicatorColor = fromHexString("A8A8A8")

    // MARK: - Circle charts

    static let redCircleChartColor = fromHexString("FF0000")

    // MARK: - Education track

    static let mutedTextColor = greyRaven
    static let mutedBorderColor = greyHeather
    static let mutedBackgroundColor = olympusWhite
    
    static let mainGrey = UIColor(named: "mainGrey")
}

public extension UIColor {
    private struct Constants {
        static let defaultColor = UIColor.white
    }

    static func fromHexString(_ hexString: String, alpha: Float = 1) -> UIColor {
        guard let color = UIColor(hexString: hexString, alpha: alpha) else {
            assertionFailure("Unable to create color from hexString: " + hexString)
            return Constants.defaultColor
        }
        return color
    }
    
    struct Green {
        static let fern = UIColor(hex: 0x6ABB72)!
        static let mountainMeadow = UIColor(hex: 0x3ABB9D)!
        static let chateauGreen = UIColor(hex: 0x4DA664)!
        static let persianGreen = UIColor(hex: 0x2CA786)!
    }
    
    struct Blue {
        static let pictonBlue = UIColor(hex: 0x5CADCF)!
        static let mariner = UIColor(hex: 0x3585C5)!
        static let curiousBlue = UIColor(hex: 0x4590B6)!
        static let denim = UIColor(hex: 0x2F6CAD)!
        static let chambray = UIColor(hex: 0x485675)!
        static let blueWhale = UIColor(hex: 0x29334D)!
    }
    
    struct Violet {
        static let wisteria = UIColor(hex: 0x9069B5)!
        static let blueGem = UIColor(hex: 0x533D7F)!
    }
    
    struct Yellow {
        static let energy = UIColor(hex: 0xF2D46F)!
        static let turbo = UIColor(hex: 0xF7C23E)!
    }
    
    struct Orange {
        static let neonCarrot = UIColor(hex: 0xF79E3D)!
        static let sun = UIColor(hex: 0xEE7841)!
    }
    
    struct Red {
        static let terraCotta = UIColor(hex: 0xE66B5B)!
        static let valencia = UIColor(hex: 0xCC4846)!
        static let cinnabar = UIColor(hex: 0xDC5047)!
        static let wellRead = UIColor(hex: 0xB33234)!
    }
    
    struct Gray {
        static let almondFrost = UIColor(hex: 0xA28F85)!
        static let whiteSmoke = UIColor(hex: 0xEFEFEF)!
        static let iron = UIColor(hex: 0xD1D5D8)!
        static let ironGray = UIColor(hex: 0x75706B)!
    }
}
