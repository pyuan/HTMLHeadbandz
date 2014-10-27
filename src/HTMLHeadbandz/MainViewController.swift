//
//  MainViewController.swift
//  HTMLHeadbandz
//
//  Created by Paul Yuan on 2014-10-20.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class MainViewController:UIViewController
{
    
    @IBOutlet var webView:UIWebView?
    @IBOutlet var newCardButtons:Array<UIButton>?
    
    var _selectedCard:String = ""
    
    var _countDownLabel:CountDownLabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.webView?.opaque = false
        self.webView?.backgroundColor = UIColor.blackColor()
        self.view.sendSubviewToBack(self.webView!)
    }
    
    //set a random card as selected, has to be different than current card
    @IBAction func getRandomCard()
    {
        let cards:[String] = Constants.CARDS()
        var random:Int = Int(arc4random_uniform(UInt32(cards.count)))
        var newCard:String = cards[random]
        
        if newCard != self._selectedCard
        {
            self._selectedCard = newCard
            println("Selected card: " + self._selectedCard)
            
            self._startCountDown()
        }
        else {
            self.getRandomCard() //recurse until a different card is selected
        }
    }
    
    //start the count down
    func _startCountDown()
    {
        self._countDown(0, onCountHandler: {(count:Int) -> Void in
            
            self._updateCountDown(count)
            
            }, onCompleteHandler: {(count:Int) -> Void in
                
                //wait a sec before hiding the count down and showing the card
                TimeUtils.PerformAfterDelay(1, completionHandler: {() -> Void in
                    self._endCountDown()
                    self._showCard()
                })
                
        })
        
        //hide new card buttons
        self._hideNewCardButtons()
        
        //fade out the webview
        var webView:UIWebView = self.webView!
        webView.alpha = 1
        UIView.animateWithDuration(3, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {() -> Void in
            
                webView.alpha = 0
            
            }, completion: {(finished:Bool) -> Void in
                
                //load card in the background
                self._loadCard(self._selectedCard)
        
        })
    }
    
    //count down second by second until the specified max
    func _countDown(currentCount:Int, onCountHandler: (count:Int) -> Void, onCompleteHandler: (count:Int) -> Void)
    {
        var nextCount:Int = currentCount + 1
        TimeUtils.PerformAfterDelay(1, completionHandler: {() -> Void in
            
            if nextCount < Constants.NEW_CARD_DELAY_IN_SECONDS()
            {
                self._countDown(nextCount, onCountHandler: onCountHandler, onCompleteHandler: onCompleteHandler)
                onCountHandler(count: (Constants.NEW_CARD_DELAY_IN_SECONDS() - nextCount))
            }
            else
            {
                onCountHandler(count: (Constants.NEW_CARD_DELAY_IN_SECONDS() - nextCount))
                onCompleteHandler(count: Constants.NEW_CARD_DELAY_IN_SECONDS())
            }
            
        })
    }
    
    //show count down label with count
    func _updateCountDown(count:Int)
    {
        if self._countDownLabel == nil
        {
            self._countDownLabel = CountDownLabel()
            self.view.addSubview(self._countDownLabel!)
        }
        
        self._countDownLabel?.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self._countDownLabel?.text = (count + 1).description
        self._countDownLabel?.animate()
    }
    
    //hide the count down label
    func _endCountDown()
    {
        self._countDownLabel?.removeFromSuperview()
        self._countDownLabel = nil
        self._showNewCardButtons()
    }
    
    //load the selected card html into webview
    func _loadCard(card:String)
    {
        let url:NSURL? = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource(card, ofType: Constants.CARDS_EXTENSION())!)
        if url != nil {
            self.webView?.loadRequest(NSURLRequest(URL: url!))
        }
    }
    
    //show the card by fade in the webview
    func _showCard()
    {
        var webView:UIWebView = self.webView!
        webView.alpha = 0
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {() -> Void in
            
            webView.alpha = 1
            
            }, completion: {(finished:Bool) -> Void in })
    }
    
    //enable all new card buttons for all size classes
    func _showNewCardButtons()
    {
        for button:UIButton in self.newCardButtons!
        {
            button.enabled = true
            
            var frame:CGRect = button.frame
            button.alpha = 0
            UIView.animateWithDuration(0.15, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {() -> Void in
                
                button.frame = CGRectMake(frame.origin.x-frame.width, frame.origin.y, frame.width, frame.height)
                button.alpha = 1
                
                }, completion: {(finished:Bool) -> Void in })
        }
    }
    
    //disable all new card buttons for all size classes
    func _hideNewCardButtons()
    {
        for button:UIButton in self.newCardButtons! {
            button.enabled = false
            
            var frame:CGRect = button.frame
            button.alpha = 1
            UIView.animateWithDuration(0.15, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {() -> Void in
                
                button.frame = CGRectMake(frame.origin.x+frame.width, frame.origin.y, frame.width, frame.height)
                button.alpha = 0
                
                }, completion: {(finished:Bool) -> Void in })
        }
    }
    
}