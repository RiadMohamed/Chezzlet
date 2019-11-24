//
//  BoardIndexRange.swift
//  Chezzlet
//
//  Created by Riad Mohamed on 11/23/19.
//  Copyright © 2019 Riad Mohamed. All rights reserved.
//

import Foundation

class BoardIndexRange {
    var startingHorizontalIndex: Int = 69
    var startingVerticalIndex: Int = 69
    var endHorizontalIndex: Int = 69
    var endVerticalIndex:Int = 69
    
    func setHorizontalRange(from start: Int, to end: Int) {
        self.startingHorizontalIndex = start
        self.endHorizontalIndex = end
    }
    
    func setVerticalRange(from start: Int, to end: Int) {
        self.startingVerticalIndex = start
        self.endVerticalIndex = end
    }
}
