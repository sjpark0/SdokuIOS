//
//  ViewController.swift
//  SdokuIOS
//
//  Created by sjpark on 2023/03/04.
//

import UIKit
let NUM_VAL_X : Int = 3
let NUM_VAL_Y : Int = 3

extension Array {
    public init(count: Int, createElement: @autoclosure () -> Element) {
        self = (0 ..< count).map { _ in createElement() }
    }
}

class ViewController: UIViewController {
    
    let initialTop : CGFloat = 100
    let initialLeading : CGFloat = 50
    let spacing : CGFloat = 30
    
    //var m_cell = Array(count: NUM_VAL_X * NUM_VAL_Y, createElement: Array(count: NUM_VAL_X * NUM_VAL_Y, createElement: SdokuCell()))
    
    var m_cell : [[SdokuCell]] = [[SdokuCell]](count: NUM_VAL_X * NUM_VAL_Y, createElement: [SdokuCell](count: NUM_VAL_X * NUM_VAL_Y, createElement: SdokuCell()))
    
    var m_cellValue : [[Int]] = [[Int]](repeating: [Int](repeating : -1, count : NUM_VAL_X * NUM_VAL_Y), count: NUM_VAL_X * NUM_VAL_Y)
    
    
    var m_solver : SdokuSolver = SdokuSolver()
    
    @IBAction func GenerateSdoku(_ sender: UIButton) {
        m_solver.m_numCellY = NUM_VAL_Y
        m_solver.m_numCellX = NUM_VAL_X
        
        for i in 0..<(NUM_VAL_X * NUM_VAL_Y) {
            for j in 0..<(NUM_VAL_X * NUM_VAL_Y){
                m_cell[i][j].InitialSetValue(val: -1)
            }
        }
        
        m_solver.MakeSdoku(val: &m_cellValue)
        
        for i in 0..<NUM_VAL_X * NUM_VAL_Y{
            for j in 0..<NUM_VAL_X * NUM_VAL_Y {
                m_cell[i][j].InitialSetValue(val: m_cellValue[i][j])
            }
        }
    }
    
    @IBAction func SolveSdoku(_ sender: UIButton) {
        m_solver.SolveSdoku(sdoku: &m_cellValue)
        
        for i in 0..<NUM_VAL_X * NUM_VAL_Y{
            for j in 0..<NUM_VAL_X * NUM_VAL_Y {
                m_cell[i][j].SetValue(val: m_cellValue[i][j])
            }
        }
    }
    
    @IBAction func RemoveComponent(_ sender: UIButton) {
        m_solver.RemoveComponent(sdoku: &m_cellValue, numRemove: 50)
        
        for i in 0..<NUM_VAL_X * NUM_VAL_Y{
            for j in 0..<NUM_VAL_X * NUM_VAL_Y {
                m_cell[i][j].InitialSetValue(val: m_cellValue[i][j])
            }
        }
    }
    override func viewDidLoad() {
        
        for i in 0..<(NUM_VAL_X * NUM_VAL_Y) {
            for j in 0..<(NUM_VAL_X * NUM_VAL_Y) {
                m_cellValue[i][j] = -1
                m_cell[i][j] = SdokuCell(spacing: spacing, leading: initialLeading, top: initialTop, posX: j, posY: i, val : -1, view: view)
            }
        }
        
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }


}

