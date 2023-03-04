//
//  ViewController.swift
//  SdokuIOS
//
//  Created by sjpark on 2023/03/04.
//

import UIKit

class ViewController: UIViewController {
    var m_value : [SdokuCell] = [SdokuCell]()
    let NUM_VAL : Int = 9
    let initialTop : CGFloat = 100
    let initialLeading : CGFloat = 50
    let spacing : CGFloat = 30
    
    override func viewDidLoad() {
        let safeArea = view.safeAreaLayoutGuide
        
        for i in 0..<NUM_VAL {
            for j in 0..<NUM_VAL {
                var val : SdokuCell = SdokuCell(spacing: spacing, leading: initialLeading, top: initialTop, posX: j, posY: i, view: view)
                
                val.text = String(i)
                m_value.append(val)
            }
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

