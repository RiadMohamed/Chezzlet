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
        let rookIndex: BoardIndex
        let rookImage: UIImage
        if color == .black {
            rookIndex = BoardIndex(0, 0)
            rookImage = UIImage(named: "Black_Rook")!
            super.init(color, "Rook", rookIndex, rookImage)
        } else {
            rookIndex = BoardIndex(7, 0)
            rookImage = UIImage(named: "White_Rook")!
            super.init(color, "Rook", rookIndex, rookImage)
        }
    }
    
    override func checkValidMove(from sourceBoardIndex: BoardIndex, to destBoardIndex: BoardIndex) -> Bool {
        return true
    }
    
    override func checkValidMove(from sourceArrayValue: Int, to destArrayValue: Int) -> Bool {
        return true
    }
}
