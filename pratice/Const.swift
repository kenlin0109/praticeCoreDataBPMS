//
//  Const.swift
//  pratice
//
//  Created by 林秀謙 on 2023/9/24.
//

import Foundation
import SwiftUI

struct Const {
    static let SBPNormal = 120
    static let SBPMax = 350
    static let SBPMin = 50
    static let SBPAlert1 = 129
    static let SBPAlert2 = 150
    static let SBPNormalColor = Color.blue
    static let SBPAlertColor1 = Color.orange
    static let SBPAlertColor2 = Color.red


    static let DBPNormal = 80
    static let DBPMax = 150
    static let DBPMin = 20
    static let DBPAlert = 89
    static let DBPNormalColor = Color.black
    static let DBPAlertColor = Color.orange
    
    static func GetSBPFontColor(_ sbp: Int) -> Color {
        return (sbp > SBPAlert2) ? SBPAlertColor2 : (sbp > SBPAlert1) ? SBPAlertColor1 : SBPNormalColor
    }
    
    static func GetDBPFontColor(_ dbp: Int) -> Color {
        return (dbp > DBPAlert) ? DBPAlertColor : DBPNormalColor
    }

}
