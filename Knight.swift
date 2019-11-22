//
//  Knight.swift
//  Chezzlet
//
//  Created by Riad Mohamed on 11/22/19.
//  Copyright © 2019 Riad Mohamed. All rights reserved.
//

import Foundation
import UIKit

class Knight: ChessPiece {
    init (_ color: ChessPieceColor) {
        let index: BoardIndex
        let image: UIImage
        if color == .black {
            index = BoardIndex(0, 1)
            image = UIImage(named: "Black_Knight")!
            super.init(color, "Knight", index, image)
        } else {
            index = BoardIndex(7, 1)
            image = UIImage(named: "White_Knight")!
            super.init(color, "Knight", index, image)
        }
    }
    override func checkValidMove(from sourceBoardIndex: BoardIndex, to destBoardIndex: BoardIndex) -> Bool {
        return true
    }
    
    override func checkValidMove(from sourceArrayValue: Int, to destArrayValue: Int) -> Bool {
        let source = BoardIndex(sourceArrayValue)
        let dest = BoardIndex(destArrayValue)
        if source.col == dest.col || source.row == dest.row {
            return false
        }
        let verticalDistance = abs(source.row - dest.row)
        let horizontalDistance = abs(source.col - dest.col)
        if (verticalDistance + horizontalDistance) == 3 {
            return true
        } else {
            return false
        }
    }
}
