//
//  UIView + Extenstion.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

import UIKit

extension UIView {
    
    func systemBackground() {
        if #available(iOS 13.0, *) {
            self.backgroundColor = .systemBackground
        } else {
            self.backgroundColor = .white
        }
    }
    
    func textViewBackground() {
        if #available(iOS 13.0, *) {
            self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            self.backgroundColor = .white
        }
    }
}
