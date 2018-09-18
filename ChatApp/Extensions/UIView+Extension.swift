//
//  UIView+Extension.swift
//  ChatApp
//
//  Created by Ngo Van Hai on 9/12/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}


