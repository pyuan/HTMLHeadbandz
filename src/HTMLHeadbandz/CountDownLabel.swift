//
//  CountDownLabel.swift
//  HTMLHeadbandz
//
//  Created by Paul Yuan on 2014-10-27.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class CountDownLabel:UILabel
{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init() {
        super.init()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //format font
        self.textColor = UIColor.whiteColor()
        self.font = UIFont.systemFontOfSize(300)
        self.textAlignment = NSTextAlignment.Center
        
        //add shadow
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(0, 10)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
    
    //shrink and fade animation
    func animate()
    {
        //show fade and scale animation
        self.transform = CGAffineTransformMakeScale(15, 15)
        self.alpha = 0
        var duration:NSTimeInterval = Double(Constants.COUNT_DOWN_INTERVAL_IN_SECONDS()) / 2
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {() -> Void in
            
            self.transform = CGAffineTransformIdentity
            self.alpha = 1
            
            }, completion: {(finished:Bool) -> Void in
                
                self.transform = CGAffineTransformIdentity
                
        })
    }
    
}