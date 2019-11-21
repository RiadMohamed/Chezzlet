//
//  ChessBoard.swift
//  Chezzlet
//
//  Created by Riad Mohamed on 11/21/19.
//  Copyright © 2019 Riad Mohamed. All rights reserved.
//

import Foundation
import UIKit

class ChessBoard {
    let ROW_CONST: Int = 8
    let COL_CONST: Int = 8
    var chessPiecesArray: [ChessPiece?] = []
    var lastTurnIndex: Int = 69
    var buttonTappedState: Bool = false
    let TILE_LIGHT_COLOR: UIColor
    let TILE_DARK_COLOR: UIColor
    let TILE_HIGHLIGHT_COLOR: UIColor
    let TILE_POSSIBLE_COLOR: UIColor
    var possibleIndices: [Int] = []
    
    init(lightColor C1: ChessNormalTileColor, darkColor C2: ChessNormalTileColor, highlightColor H1: ChessHighlightTileColor, possibleColor P1: ChessPossibleTileColor) {
        TILE_LIGHT_COLOR = ChessColorDictionary.getTilesColor(C1)
        TILE_DARK_COLOR = ChessColorDictionary.getTilesColor(C2)
        TILE_POSSIBLE_COLOR = ChessColorDictionary.getPossibleColor(P1)
        TILE_HIGHLIGHT_COLOR = ChessColorDictionary.getHightlightColor(H1)
        for index in 0..<ROW_CONST*COL_CONST {
            switch index {
                case 0, 7:
                    let rook = Rook(.black)
                    chessPiecesArray.append(rook)
                case 1, 6: break
                case 2, 5: break
                case 3: break
                case 4: break
                case 8...15: break

                case 48...55: break
                case 56, 63:
                    let rook = Rook(.white)
                    chessPiecesArray.append(rook)
                case 57, 62: break
                case 58, 61: break
                case 59: break
                case 60: break
                default: break
            }
        }
    }
    
    func getPossibleTiles(_ currentIndex: Int) -> [Int] {
        possibleIndices.removeAll()
        if let currentPiece = chessPiecesArray[currentIndex] {
            for nextIndex in 0..<ROW_CONST*COL_CONST {
                if nextIndex != currentIndex {
                    if currentPiece.checkValidMove(from: currentIndex, to: nextIndex) {
                        possibleIndices.append(nextIndex)
                    }
                }
            }
            return possibleIndices
        }
        return []
    }
    
    func checkIfSameTeam(_ currentIndex : Int) -> Bool {
        guard chessPiecesArray.count > currentIndex, chessPiecesArray.count > lastTurnIndex, lastTurnIndex != 69 else {
            print("Indecies out of range")
            return false
        }
        if lastTurnIndex == currentIndex { return true }
        if let previousPiece = chessPiecesArray[lastTurnIndex], let currentPiece = chessPiecesArray[currentIndex] {
            return currentPiece.color == previousPiece.color
        } else {
            return false
        }
    }
    
    func checkIfEmpty(_ currentIndex: Int) -> Bool {
        if chessPiecesArray[currentIndex] != nil {
            return false
        } else {
            return true
        }
    }
    
    func movePiece(_ currentIndex: Int) {
        possibleIndices.removeAll()
        if chessPiecesArray[lastTurnIndex]!.checkValidMove(from: lastTurnIndex, to: currentIndex) {
            chessPiecesArray[currentIndex] = chessPiecesArray[lastTurnIndex]
            chessPiecesArray[lastTurnIndex] = nil
        } else {
            print("Invalid Move")
        }
    }
    
}
//    func colorTilesDefault() {
//        var state = true
//        var counter = 0
//
//        for piece in chessPiecesArray {
//            if counter == 8 {
//                counter = 0
//                state = !state
//            }
//            if state {
//                tile.button.backgroundColor = BOARD_LIGHT_COLOR
//            } else {
//                tile.button.backgroundColor = BOARD_DARK_COLOR
//            }
//            state = !state
//            counter+=1
//        }
//    }

