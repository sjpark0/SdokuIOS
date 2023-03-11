//
//  SdokuSolver.swift
//  SdokuIOS
//
//  Created by sjpark on 2023/03/04.
//

import Foundation

class SdokuSolver {
    var m_numCellX : Int = -1
    var m_numCellY : Int = -1
    var m_solved : [[[Int]]] = [[[Int]]]()
    init(){
        
    }
    init(numCellX : Int, numCellY : Int){
        m_numCellX = numCellX
        m_numCellY = numCellY
    }
    func GetAvailableNumber(val : [[Int]], i : Int, j : Int) -> [Int] {
        var numList : [Int] = [Int]()
        var isAvail : Bool = true
        var index1 : Int = -1
        var index2 : Int = -1
        for aa in 1..<(1 + m_numCellX * m_numCellY){
            isAvail = true
            for m in 0..<(m_numCellX * m_numCellY) {
                if val[i][m] == aa {
                    isAvail = false
                    break
                }
                if val[m][j] == aa {
                    isAvail = false
                    break
                }
            }
            if isAvail == true {
                index1 = (i / m_numCellY) * m_numCellY
                index2 = (j / m_numCellX) * m_numCellX
                
                for m in index1..<(index1 + m_numCellY){
                    if isAvail == true {
                        for n in index2..<(index2 + m_numCellX){
                            if val[m][n] == aa{
                                isAvail = false
                                break
                            }
                        }
                    }
                }
            }
            if isAvail == true{
                numList.append(aa)
            }
        }
        return numList
    }
    
    func MakeSdoku(val : inout [[Int]]) -> Void {
        var success : Bool = false
        var totalNum : Int = 0
        var numList : [Int] = [Int]()
        var temp : Int = -1
        while success == false {
            totalNum += 1
            success = true
            for i in 0..<(m_numCellX * m_numCellY){
                for j in 0..<(m_numCellX * m_numCellY){
                    val[i][j] = -1
                }
            }
            
            for i in 0..<(m_numCellX * m_numCellY){
                if success == true {
                    for j in 0..<(m_numCellX * m_numCellY){
                        numList = GetAvailableNumber(val: val, i: i, j: j)
                        if numList.count == 0 {
                            success = false
                            break
                        }
                        temp = Int.random(in: 0..<numList.count)
                        val[i][j] = numList[temp]
                    }
                }
            }
        }
        print(totalNum)
    }
    
    func RemoveComponent(sdoku : inout [[Int]], emptyIdx : inout [(Int, Int)], numRemove : Int) -> Void {
        var cnt : Int = 0
        var idx : Int = -1
        var idy : Int = -1
        
        while cnt < numRemove {
            idx = Int.random(in: 0..<(m_numCellX * m_numCellY))
            idy = Int.random(in: 0..<(m_numCellX * m_numCellY))
            if sdoku[idy][idx] != -1 {
                emptyIdx.append((idy, idx))
                sdoku[idy][idx] = -1
                cnt += 1
            }
        }
    }
    
    func GenerateSdoku(sdoku : inout [[Int]], numRemove : Int) -> Void {
        MakeSdoku(val: &sdoku)
        
        var sdokuTemp : [[Int]] = [[Int]]()
        var result : Int = -1
        var emptyIdx : [(Int, Int)] = [(Int, Int)]()
        
        while result != 1 {
            m_solved.removeAll()
            emptyIdx.removeAll()
            sdokuTemp = sdoku
            RemoveComponent(sdoku: &sdokuTemp, emptyIdx : &emptyIdx, numRemove: numRemove)
            result = SolveSdoku(sdoku: sdokuTemp, emptyIdx: emptyIdx)
            print(result)
        }
        sdoku = sdokuTemp
    }
    
    func RemoveComponent(sdoku : inout [[Int]], numRemove : Int) -> Void {
        var sdokuTemp : [[Int]] = [[Int]]()
        var result : Int = -1
        var emptyIdx : [(Int, Int)] = [(Int, Int)]()
        
        while result != 1 {
            m_solved.removeAll()
            emptyIdx.removeAll()
            sdokuTemp = sdoku
            RemoveComponent(sdoku: &sdokuTemp, emptyIdx : &emptyIdx, numRemove: numRemove)
            result = SolveSdoku(sdoku: sdokuTemp, emptyIdx: emptyIdx)
            print(result)
        }
        sdoku = sdokuTemp
    }
    func SolveSdoku(sdoku : [[Int]], emptyIdx : [(Int, Int)]) -> Int {
        var sdokuTemp : [[Int]] = [[Int]]()
        var emptyIdxTemp : [(Int, Int)] = emptyIdx
        var emptyIdxTempTemp : [(Int, Int)] = emptyIdx
        var result : Int = 0
        var isChange : Bool = false
        var isReturn : Bool = false
        var idx : Int = 0
        
        if emptyIdxTemp.count == 0 {
            m_solved.append(sdoku)
            result = 1
        }
        else {
            sdokuTemp = sdoku
            isReturn = false
            idx = 0
            //while isChange == true || isReturn == false {
            while idx != emptyIdxTemp.endIndex {
                var numList : [Int] = GetAvailableNumber(val: sdokuTemp, i: emptyIdxTemp[idx].0, j: emptyIdxTemp[idx].1)
                    
                if numList.count == 0 {
                    return 0
                }
                else if numList.count == 1 {
                    sdokuTemp[emptyIdxTemp[idx].0][emptyIdxTemp[idx].1] = numList[0]
                    emptyIdxTemp.remove(at: idx)
                    idx = 0
                }
                else{
                    idx += 1
                }
            }
            if emptyIdxTemp.count == 0{
                m_solved.append(sdokuTemp)
                return 1
            }
            
            
            for i in emptyIdxTemp.startIndex..<emptyIdxTemp.endIndex{
                emptyIdxTempTemp = emptyIdxTemp
                
                var numList : [Int] = GetAvailableNumber(val: sdokuTemp, i: emptyIdxTemp[i].0, j: emptyIdxTemp[i].1)
                emptyIdxTempTemp.remove(at: i)
                
                for j in 0..<numList.count{
                    sdokuTemp[emptyIdxTemp[i].0][emptyIdxTemp[i].1] = numList[j]
                    result += SolveSdoku(sdoku: sdokuTemp, emptyIdx: emptyIdxTempTemp)
                }
            }
        }
        return result
    }
    func SolveSdoku(sdoku : inout [[Int]]) -> Void {
        var emptyIdx : [(Int, Int)] = [(Int, Int)]()
        emptyIdx.removeAll()
        m_solved.removeAll()
        
        for i in 0..<(m_numCellX * m_numCellY) {
            for j in 0..<(m_numCellX * m_numCellY){
                if sdoku[i][j] == -1 {
                    emptyIdx.append((i, j))
                }
            }
        }
        SolveSdoku(sdoku: sdoku, emptyIdx: emptyIdx)
        sdoku = m_solved[0]
    }
}
