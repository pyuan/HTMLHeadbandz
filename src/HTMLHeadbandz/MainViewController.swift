//
//  MainViewController.swift
//  HTMLHeadbandz
//
//  Created by Paul Yuan on 2014-10-20.
//  Copyright (c) 2014 Paul Yuan. All rights reserved.
//

import Foundation
import UIKit

class MainViewController:UIViewController
{
    
    @IBOutlet var webView:UIWebView?
    
    var _selectedCard:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.sendSubviewToBack(self.webView!)
    }
    
    //set a random card as selected, has to be different than current card
    @IBAction func getRandomCard() {
        let cards:[String] = Constants.CARDS()
        var random:Int = Int(arc4random_uniform(UInt32(cards.count)))
        var newCard:String = cards[random]
        
        if newCard != self._selectedCard {
            self._selectedCard = newCard
            println("Selected card: " + self._selectedCard)
            
            //load card
            self._loadCard()
        }
        else {
            self.getRandomCard() //recurse until a different card is selected
        }
    }
    
    //load the selected card html into webview
    func _loadCard()
    {
        let url:NSURL? = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource(self._selectedCard, ofType: Constants.CARDS_EXTENSION())!)
        if url != nil {
            self.webView?.loadRequest(NSURLRequest(URL: url!))
        }
    }
    
}