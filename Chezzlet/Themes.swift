//
//  Themes.swift
//  Chezzlet
//
//  Created by Riad Mohamed on 11/19/19.
//  Copyright © 2019 Riad Mohamed. All rights reserved.
//

import Foundation
import UIKit

enum ChessPieceColor {
    case black
    case white
}

enum ChessNormalTileColor {
    case lightBrown
    case darkBrown
}

enum ChessHighlightTileColor {
    case blue
}

enum ChessPossibleTileColor {
    case green
}
struct ChessColorDictionary {
    static func getTilesColor(_ C1: ChessNormalTileColor) -> UIColor {
        switch C1 {
            case .darkBrown: return UIColor(red: 0.710, green: 0.533, blue: 0.387, alpha: 1)
            case .lightBrown: return UIColor(red: 0.943, green: 0.852, blue: 0.708, alpha: 1)
        }
    }
    
    static func getHightlightColor(_ C1: ChessHighlightTileColor) -> UIColor {
        switch C1 {
            case .blue: return UIColor.systemBlue
        }
    }
    
    static func getPossibleColor(_ C1: ChessPossibleTileColor) -> UIColor {
        switch C1 {
            case .green: return UIColor.systemGreen
        }
    }
}
