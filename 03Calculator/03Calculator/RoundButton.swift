//
//  RoundButton.swift
//  03Calculator
//
//  Created by 李 グッゴン on 2022/06/09.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable
    var isRound: Bool = false
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
        
    }
    

}
