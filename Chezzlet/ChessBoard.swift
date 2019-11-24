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
    var currentPlayer: Int = 0
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
    var possibleHorizontalIndices: [Int] = []
    var possibleVerticalIndices: [Int] = []
    var possibleDiagonalIndices: [Int] = []
    var currentTappedIndex: Int? = nil
    
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
    
    /// Responsible for the response of the user tap, checks the state of the board
    /// then act accordingly either to highlight the possible moves or hide them, or move the
    /// piece if the user made a correct move.
    /// - Parameter currentIndex: 1D Array value, coming from sender.tag
    func tappedTile(at currentIndex: Int) {
        print("Hello from index \(currentIndex)")
        if !buttonTappedState {
            // First time tapping a tile.
            buttonTappedState = true
            print("ButtonTappedState = true")
            if let currentPiece = chessPiecesArray[currentIndex] {
                // Tile is not empty
                if checkIfMyPiece(currentIndex) {
                    // ChessPiece is mine
                    print("My Piece")
                    currentTappedIndex = currentIndex
                    // Get the possible 1D array indices
                    possibleIndices = getPossibleTiles(for: currentPiece, from: currentIndex)
                    print(possibleIndices)
                    // Further refinde the indices for other pieces in the way
                    filterPossibleIndices(for: currentPiece)
                } else {
                    // ChessPiece is NOT MINE
                    print("Not my Piece")
                    buttonTappedState = false
                }
            } else {
                // No ChessPiece on tapped tile
                print("Tapped an empty tile, do nothing")
            }
        }
        else {
            // Second time tapping
            print("ButtonTappedState = false")
            buttonTappedState = false
            currentPlayer = (currentPlayer + 1) % 2
        }
        print("Final buttonTappedState = \(buttonTappedState)")
    }
    
    
    /// Refine the inital possible indices and only allow those that have a clear path from
    /// current position, unless the currentPiece was a "Knight" hence it can move regardless
    /// - Parameter possibleIndices: 1D Array values of possible moves
    /// - Parameter currentPiece: current ChessPiece the user has selected
    func filterPossibleIndices(for currentPiece: ChessPiece) {
        if currentPiece.rank != "Knigt" {
            switch currentPiece.rank {
            case "Rook":
                checkHorizontal()
//                checkVertical()
            default:
            return
        }
        }
        possibleIndices.removeAll()
        possibleIndices.append(contentsOf: possibleHorizontalIndices)
        possibleIndices.append(contentsOf: possibleVerticalIndices)
        possibleIndices.append(contentsOf: possibleDiagonalIndices)
    }
    
    
    /// Sets the possibleHorizontalIndices with the accepted values if there are
    /// no other pieces in the way.
    func checkHorizontal() {
        let currentBoardIndex = BoardIndex(currentTappedIndex!)
        var currentColIndex = currentBoardIndex.col
        var pieceFoundFlag = false
        while !pieceFoundFlag, currentColIndex >= 0 {
            let nextBoardIndex = BoardIndex(currentBoardIndex.row, currentColIndex - 1)
            let nextIndex = BoardIndex.toArrayValue(nextBoardIndex)
            if !checkIfEmpty(nextIndex) {
                // tile not empty
                if !checkIfMyPiece(nextIndex) {
                    // Enemy tile
                    possibleHorizontalIndices.append(nextIndex)
                    pieceFoundFlag = true
                } else {
                    // Ally tile
                    if nextIndex + 1 != currentTappedIndex {
                        possibleHorizontalIndices.append(nextIndex + 1)
                    }
                    pieceFoundFlag = true
                }
            }
            currentColIndex -= 1
        }
    }
    
    
    /// Returns an array of all the possible 1D values that is accepted by the current piece
    /// the user has tapped.
    /// - Parameter currentPiece: ChessPiece that the user has tapped
    /// - Parameter currentIndex: 1D Array value, coming from sender.tag
    func getPossibleTiles(for currentPiece: ChessPiece, from currentIndex: Int) -> [Int] {
        print("Success")
        var possibleIndices: [Int] = []
        for index in 0..<ROW_CONST*COL_CONST {
            if currentIndex != index {
                if currentPiece.checkValidMove(from: currentIndex, to: index) {
                    possibleIndices.append(index)
                }
            }
        }
        return possibleIndices
    }
    
    /// Checks if the piece at the currentIndex belongs to the currentPlayer (true) or not (false)
    /// - Parameter currentIndex: 1D Array value, coming from sender.tag
    func checkIfMyPiece(_ currentIndex: Int) -> Bool {
        if let currentPiece = chessPiecesArray[currentIndex] {
            if currentPlayer == 0, currentPiece.color == .white {
                return true
            } else if currentPlayer == 1, currentPiece.color == .black {
                return true
            } else {
                return false
            }
        } else {
            print("Invalid call of the function. Can't check if it is in my team because no piece found")
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
    
//    func checkHorizontal(_ currentIndex: Int) -> (Int, Int) {
//        guard let currentPiece = chessPiecesArray[currentIndex] else {
//            print("Error")
//            return (69, 69)
//        }
//        var startingIndex: Int = 69
//        var endIndex: Int = 69
//        let currentBoardIndex = BoardIndex(currentIndex)
//        var currentCol = currentBoardIndex.col
//        var startFlag = true
//        var endFlag = true
//
//        while startFlag, currentCol > 0 {
//            let nextBoardIndex = BoardIndex(currentBoardIndex.row, currentCol - 1)
//            if !checkIfEmpty(BoardIndex.toArrayValue(nextBoardIndex)) {
//                if !checkIfSameTeam(nextBoardIndex, currentPiece) {
//                    startingIndex = currentCol + 1
//                    startFlag = false
//                } else {
//                    startingIndex = currentCol
//                    startFlag = false
//                }
//            } else {
//                currentCol -= 1
//            }
//        }
//
//        currentCol = currentBoardIndex.col
//        while endFlag, currentCol < 7 {
//            let nextBoardIndex = BoardIndex(currentBoardIndex.row, currentCol + 1)
//            if !checkIfEmpty(BoardIndex.toArrayValue(nextBoardIndex)) {
//                if !checkIfSameTeam(nextBoardIndex, currentPiece) {
//                    endIndex = currentCol - 1
//                    endFlag = false
//                } else {
//                    endIndex = currentCol
//                    endFlag = false
//                }
//            } else {
//                currentCol += 1
//            }
//        }
//        return (startingIndex, endIndex)
//    }
//
//    func getPossibleTiles(_ currentIndex: Int) -> [Int] {
//        possibleIndices.removeAll()
//        let (startingHorizontalIndex, endHorizontalIndex) = checkHorizontal(currentIndex)
//
//
//
//
//
//
////        possibleIndices.removeAll()
////        if let currentPiece = chessPiecesArray[currentIndex] {
////            for nextIndex in 0..<ROW_CONST*COL_CONST {
////                if nextIndex != currentIndex {
////                    if currentPiece.checkValidMove(from: currentIndex, to: nextIndex) {
////                        possibleIndices.append(nextIndex)
////                    }
////                }
////            }
////            if currentPiece.rank != "Knight" {
////                checkValidTiles(currentIndex, possibleIndices)
////            } else {
////                return possibleIndices
////            }
////        }
////
////        return []
//    }
//
//    func checkValidTiles(_ currentIndex: Int,_ initialPossibleIndices: [Int]) -> [Int] {
//
//    }
//
//    func checkIfSameTeam(_ currentIndex: BoardIndex, _ currentPiece: ChessPiece) -> Bool {
//        if let piece = chessPiecesArray[BoardIndex.toArrayValue(currentIndex)] {
//            if piece.color == currentPiece.color {
//                return true
//            } else {
//                return false
//            }
//        } else {
//            return false
//        }
//    }
//
//    func checkIfSameTeam(_ currentIndex : Int) -> Bool {
//        guard chessPiecesArray.count > currentIndex, chessPiecesArray.count > lastTurnIndex, lastTurnIndex != 69 else {
//            print("Indecies out of range")
//            return false
//        }
//        if lastTurnIndex == currentIndex { return true }
//        if let previousPiece = chessPiecesArray[lastTurnIndex], let currentPiece = chessPiecesArray[currentIndex] {
//            return currentPiece.color == previousPiece.color
//        } else {
//            return false
//        }
//    }
//
//    func checkIfEmpty(_ currentIndex: Int) -> Bool {
//        if chessPiecesArray[currentIndex] != nil {
//            return false
//        } else {
//            return true
//        }
//    }
//
//
//
//    func checkVertical(from startingBoardIndex: BoardIndex, to endBoardIndex: BoardIndex) -> Bool {
//        // COl is the same.
//
//        let startingIndex: Int
//        let endIndex: Int
//        if startingBoardIndex.row < endBoardIndex.row {
//            startingIndex = startingBoardIndex.row
//            endIndex = endBoardIndex.row
//        } else {
//            endIndex = startingBoardIndex.row
//            startingIndex = endBoardIndex.row
//        }
//        for index in startingIndex...endIndex {
//            if chessPiecesArray[index] != nil {
//                if index == endIndex {
//                    return false
//                } else {
//                    return true
//                }
//            }
//        }
//        return false
//    }
//
//
//    func checkHorizontal(from startingBoardIndex: BoardIndex, to endBoardIndex: BoardIndex) -> Bool {
//        // ROW is the same.
//        let startingIndex: Int
//        let endIndex: Int
//        if startingBoardIndex.col < endBoardIndex.col {
//            startingIndex = startingBoardIndex.col + 1
//            endIndex = endBoardIndex.col
//        } else {
//            endIndex = startingBoardIndex.col
//            startingIndex = endBoardIndex.col + 1
//        }
//        for index in startingIndex...endIndex {
//            if chessPiecesArray[index] != nil {
//                if index == endIndex {
//                    return false
//                } else {
//                    return true
//                }
//            }
//        }
//        return false
//    }
//
//    func checkDiagonal(from startingBoardIndex: BoardIndex, to endBoardIndex: BoardIndex) -> Bool {
//        return false
//    }
//
//
//    func checkIfAnotherPieceInTheWay(_ currentIndex: Int) -> Bool {
//        let currentPiece = chessPiecesArray[lastTurnIndex]!
//        let currentBoardIndex = BoardIndex(currentIndex)
//        let lastTurnBoardIndex = BoardIndex(lastTurnIndex)
//        print("currentPiece.rank = \(currentPiece.rank)")
//        switch currentPiece.rank {
//            case "Rook":
//                if !checkVertical(from: lastTurnBoardIndex, to: currentBoardIndex) && !checkHorizontal(from: lastTurnBoardIndex, to: currentBoardIndex) {
//                    return false
//                } else {
//                    return true
//                }
//            default:
//            return false
//        }
//    }
//
//    func movePieceSequence(_ currentIndex: Int) {
//        possibleIndices.removeAll()
//        if chessPiecesArray[lastTurnIndex]!.checkValidMove(from: lastTurnIndex, to: currentIndex) {
//            if chessPiecesArray[lastTurnIndex]!.rank != "Knight" {
//                if !checkIfAnotherPieceInTheWay(currentIndex) {
//                    movePiece(currentIndex)
//                } else {
//                    print("Invalid Move, piece in the way")
//                }
//            } else {
//                movePiece(currentIndex)
//            }
//        } else {
//            print("Invalid Move according to piece logic")
//        }
//    }
//
//    func movePiece(_ currentIndex: Int) {
//        chessPiecesArray[currentIndex] = chessPiecesArray[lastTurnIndex]
//        chessPiecesArray[lastTurnIndex] = nil
//    }
    
}
