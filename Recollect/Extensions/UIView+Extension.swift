//
//  UIView+Extension.swift
//  Recollect
//
//  Created by student on 2022-07-21.
//

import Foundation
import UIKit

// Corner radius for box
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {return self.cornerRadius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
