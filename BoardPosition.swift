//
//  BoardPosition.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/13/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

struct BoardPosition {
    //The first row or column is 1 (not 0) and is in the bottom left.
    let row, column: Int
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}