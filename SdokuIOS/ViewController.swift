//
//  ViewController.swift
//  SdokuIOS
//
//  Created by sjpark on 2023/03/04.
//

import UIKit

class ViewController: UIViewController {
    var m_cell : [SdokuCell] = [SdokuCell]()
    var m_cellValue : [CellValue] = [CellValue]()
    
    let m_solver : SdokuSolver = SdokuSolver()
    
    let NUM_VAL : Int = 9
    let initialTop : CGFloat = 100
    let initialLeading : CGFloat = 50
    let spacing : CGFloat = 30
    
    
    @IBAction func GenerateSdoku(_ sender: UIButton) {
        let numFilled : Int = 50
        var idX : Int = -1
        var idY : Int = -1
        
        
        for i in 0..<NUM_VAL {
            for j in 0..<NUM_VAL{
                m_cell[j + i * NUM_VAL].isUserInteractionEnabled = true
                m_cell[j + i * NUM_VAL].SetValue(val: -1)
            }
        }
        
        m_solver.MakeSdoku(val: &m_cellValue, row: NUM_VAL, col: NUM_VAL)
        /*for _ in 0..<numFilled{
            idX = Int.random(in: 0..<NUM_VAL)
            idY = Int.random(in: 0..<NUM_VAL)
            m_cell[idX + idY * NUM_VAL].InitialSetValue(val: Int.random(in: 0..<NUM_VAL) + 1)
            
            //print(idX, idY, m_value[idX + idY * NUM_VAL].val)
            

        }*/
    }
    
    @IBAction func SolveSdoku(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        for i in 0..<NUM_VAL {
            for j in 0..<NUM_VAL {
                var val : CellValue = CellValue(val: -1)
                var cell : SdokuCell = SdokuCell(spacing: spacing, leading: initialLeading, top: initialTop, posX: j, posY: i, val : val, view: view)
                
                //val.text = String(i)
                m_cellValue.append(val)
                m_cell.append(cell)
            }
        }
        
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }


}

