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
                case 1, 6:
                    let knight = Knight(.black)
                    chessPiecesArray.append(knight)
                case 2, 5: break
                case 3: break
                case 4: break
                case 8...15: break

                case 48...55: break
                case 56, 63:
                    let rook = Rook(.white)
                    chessPiecesArray.append(rook)
                case 57, 62:
                    let knight = Knight(.white)
                chessPiecesArray.append(knight)
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
    
    func checkVertical(from startingBoardIndex: BoardIndex, to endBoardIndex: BoardIndex) -> Bool {
        // COl is the same.

        let startingIndex: Int
        let endIndex: Int
        if startingBoardIndex.row < endBoardIndex.row {
            startingIndex = startingBoardIndex.row
            endIndex = endBoardIndex.row
        } else {
            endIndex = startingBoardIndex.row
            startingIndex = endBoardIndex.row
        }
        for index in startingIndex...endIndex {
            if chessPiecesArray[index] != nil {
                if index == endIndex {
                    return false
                } else {
                    return true
                }
            }
        }
        return false
    }
    
    
    func checkHorizontal(from startingBoardIndex: BoardIndex, to endBoardIndex: BoardIndex) -> Bool {
        // ROW is the same.
        let startingIndex: Int
        let endIndex: Int
        if startingBoardIndex.col < endBoardIndex.col {
            startingIndex = startingBoardIndex.col + 1
            endIndex = endBoardIndex.col
        } else {
            endIndex = startingBoardIndex.col
            startingIndex = endBoardIndex.col + 1
        }
        for index in startingIndex...endIndex {
            if chessPiecesArray[index] != nil {
                if index == endIndex {
                    return false
                } else {
                    return true
                }
            }
        }
        return false
    }
    
    func checkDiagonal(from startingBoardIndex: BoardIndex, to endBoardIndex: BoardIndex) -> Bool {
        return false
    }
    
    
    func checkIfAnotherPieceInTheWay(_ currentIndex: Int) -> Bool {
        let currentPiece = chessPiecesArray[lastTurnIndex]!
        let currentBoardIndex = BoardIndex(currentIndex)
        let lastTurnBoardIndex = BoardIndex(lastTurnIndex)
        print("currentPiece.rank = \(currentPiece.rank)")
        switch currentPiece.rank {
            case "Rook":
                if !checkVertical(from: lastTurnBoardIndex, to: currentBoardIndex) && !checkHorizontal(from: lastTurnBoardIndex, to: currentBoardIndex) {
                    return false
                } else {
                    return true
                }
            default:
            return false
        }
    }
    
    func movePieceSequence(_ currentIndex: Int) {
        possibleIndices.removeAll()
        if chessPiecesArray[lastTurnIndex]!.checkValidMove(from: lastTurnIndex, to: currentIndex) {
            if chessPiecesArray[lastTurnIndex]!.rank != "Knight" {
                if !checkIfAnotherPieceInTheWay(currentIndex) {
                    movePiece(currentIndex)
                } else {
                    print("Invalid Move, piece in the way")
                }
            } else {
                movePiece(currentIndex)
            }
        } else {
            print("Invalid Move according to piece logic")
        }
    }
    
    func movePiece(_ currentIndex: Int) {
        chessPiecesArray[currentIndex] = chessPiecesArray[lastTurnIndex]
        chessPiecesArray[lastTurnIndex] = nil
    }
    
}
