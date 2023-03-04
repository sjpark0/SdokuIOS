//
//  SdokuSolver.swift
//  SdokuIOS
//
//  Created by sjpark on 2023/03/04.
//

import Foundation

class SdokuSolver {
    func MakeSdoku(val : inout [CellValue], row : Int, col : Int) -> Void {
        for i in 0..<col{
            for j in 0..<row{
                val[j + i * row].val = Int.random(in: 0..<9) + 1
            }
        }
    }
}
