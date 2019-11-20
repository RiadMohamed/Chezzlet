//
//  BoardIndex.swift
//  Chezzlet
//
//  Created by Riad Mohamed on 11/19/19.
//  Copyright © 2019 Riad Mohamed. All rights reserved.
//

import Foundation

class BoardIndex : Equatable{
    
    var row = 0
    var col = 0

    init (_ arrayValue: Int) {
        self.row = arrayValue / 8
        self.col = arrayValue % 8
    }
    init (_ row: Int,_ col: Int) {
        self.row = row
        self.col = col
    }
    
    static func toArrayValue(_ boardIndex: BoardIndex) -> Int {
        return boardIndex.row * 8 + boardIndex.col
    }
    
    static func == (lhs: BoardIndex, rhs: BoardIndex) -> Bool {
        if lhs.row == rhs.row, lhs.col == rhs.col {
            return true
        } else {
            return false
        }
    }
}
