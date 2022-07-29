//
//  UIViewController+Extensions.swift
//  Recollect
//
//  Created by student on 2022-07-23.
//

import Foundation
import UIKit

// View controller exentsion to help with onboardingslide only showing up once
extension OnboardingViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
    }
}
