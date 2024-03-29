//
//  Rook.swift
//  Chezzlet
//
//  Created by Riad Mohamed on 11/20/19.
//  Copyright © 2019 Riad Mohamed. All rights reserved.
//

import Foundation
import UIKit

class Rook : ChessPiece {
    init (_ color: ChessPieceColor) {
        let index: BoardIndex
        let image: UIImage
        if color == .black {
            index = BoardIndex(0, 0)
            image = UIImage(named: "Black_Rook")!
            super.init(color, "Rook", index, image)
        } else {
            index = BoardIndex(7, 0)
            image = UIImage(named: "White_Rook")!
            super.init(color, "Rook", index, image)
        }
    }
    
    override func checkValidMove(from sourceBoardIndex: BoardIndex, to destBoardIndex: BoardIndex) -> Bool {
        return true
    }
    
    override func checkValidMove(from sourceArrayValue: Int, to destArrayValue: Int) -> Bool {
        let source = BoardIndex(sourceArrayValue)
        let dest = BoardIndex(destArrayValue)
        if source.row == dest.row || source.col == dest.col {
            return true
        } else {
            return false
        }
    }
}
