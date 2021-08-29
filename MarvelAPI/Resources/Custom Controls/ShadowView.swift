//
//  UIView+Extensions.swift
//  MarvelAPI
//
//  Created by German Huerta on 28/08/21.
//

import Foundation
import UIKit
class ShadowView:UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners()

        setupShadow()
    }
    
    func setupShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 4
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath

        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    
    func roundCorners(){
        self.layer.cornerRadius = 5
    }
}
