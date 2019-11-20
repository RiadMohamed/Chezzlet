//
//  ChessPiece.swift
//  Chezzlet
//
//  Created by Riad Mohamed on 11/19/19.
//  Copyright © 2019 Riad Mohamed. All rights reserved.
//

import Foundation
import UIKit

class ChessPiece {
    var color: ChessPieceColor
    var rank: String
    var boardIndex: BoardIndex
    var image: UIImage
    
    init(_ color: ChessPieceColor, _ rank: String, _ boardIndex: BoardIndex, _ image: UIImage) {
        self.color = color
        self.rank = rank
        self.boardIndex = boardIndex
        self.image = image
    }
}
