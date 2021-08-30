//
//  HeaderView.swift
//  MarvelAPI
//
//  Created by German Huerta on 29/08/21.
//

import Foundation
import UIKit

class HeaderView: UIView {
    private let tableHeaderViewCutaway: CGFloat = 10.0
    private var headerMaskLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateHeaderView()
    }
    func updateHeaderView()
    {
        // cut away the header view
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        self.layer.mask = headerMaskLayer
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))


        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height - tableHeaderViewCutaway))
        path.addLine(to: CGPoint(x: self.frame.width / 2.0, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height - tableHeaderViewCutaway))

        headerMaskLayer?.path = path.cgPath
    }
}
