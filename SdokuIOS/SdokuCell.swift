//
//  SdokuCell.swift
//  SdokuIOS
//
//  Created by sjpark on 2023/03/04.
//

import Foundation
import UIKit

class SdokuCell : UITextField {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    init(spacing : CGFloat, leading : CGFloat, top : CGFloat, posX : Int, posY : Int, view : UIView){
        super.init(frame: CGRect())
        
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
    }
}
