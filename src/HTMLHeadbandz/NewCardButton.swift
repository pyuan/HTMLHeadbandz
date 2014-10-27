//
//  NewCardButton.swift
//  HTMLHeadbandz
//
//  Created by Paul Yuan on 2014-10-27.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class NewCardButton:UIButton
{
    
    let MARGIN_X:CGFloat = 15
    let MARGIN_Y:CGFloat = 10
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //create white background
        self.backgroundColor = UIColor.whiteColor()
        self.contentEdgeInsets = UIEdgeInsetsMake(MARGIN_Y, MARGIN_X, MARGIN_Y, MARGIN_X)
        
        //create rounded corner
        var maskPath:UIBezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: UIRectCorner.BottomLeft | UIRectCorner.TopLeft, cornerRadii: CGSizeMake(10, 10))
        var maskLayer:CAShapeLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.CGPath
        self.layer.mask = maskLayer
    }
    
}