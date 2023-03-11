//
//  SdokuCell.swift
//  SdokuIOS
//
//  Created by sjpark on 2023/03/04.
//

import Foundation
import UIKit

class SdokuCell : UITextField {
    var posX : Int = -1
    var posY : Int = -1
    var val : Int = -1
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    init(spacing : CGFloat, leading : CGFloat, top : CGFloat, posX : Int, posY : Int, val : Int, view : UIView){
        super.init(frame: CGRect())
        self.posY = posY
        self.posX = posX
        self.val = val
        let safeArea = view.safeAreaLayoutGuide
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.borderWidth = CGFloat(0.5)
        layer.borderColor = UIColor.gray.cgColor
        
        borderStyle = .roundedRect
        adjustsFontSizeToFitWidth = true
        
        textAlignment = .center
        textAlignment = .center
        
        widthAnchor.constraint(equalToConstant: spacing - 1).isActive = true
        heightAnchor.constraint(equalToConstant: spacing - 1).isActive = true
        
        view.addSubview(self)
        
        leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                     constant: leading + CGFloat(posX) * spacing).isActive = true
        topAnchor.constraint(equalTo: safeArea.topAnchor,
                                 constant: top + CGFloat(posY) * spacing).isActive = true
        
        text = PrintString()
        
    }
    func InitialSetValue(val : Int) -> Void {
        self.val = val
        text = PrintString()
        if val != -1{
            isUserInteractionEnabled = false
        }
        else{
            isUserInteractionEnabled = true
        }
    }
    func SetValue(val : Int) -> Void{
        self.val = val
        text = PrintString()
    }
    func PrintString() -> String {
        if self.val < 0 {
            return ""
        }
        else{
            return String(self.val)
        }
    }
}
