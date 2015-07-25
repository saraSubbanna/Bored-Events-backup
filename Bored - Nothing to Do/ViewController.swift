
//
//  ViewController.swift
//  Bored - Nothing to Do
//
//  Created by Sara Subbanna on 7/7/15.
//  Copyright (c) 2015 Sara Subbanna. All rights reserved.
//

import UIKit
import Parse

class NothingViewController: UIViewController {

    @IBOutlet var mainButton: UIView!
    @IBOutlet weak var nextActivity: UILabel!
    var newActivityName: String?
    var counter = 0
    var thingsToDo: [PFObject]!
    var dontShowUsers =  ["a", "b"]
    
    override func viewDidLoad() {
        nextActivity.text = ""
        super.viewDidLoad()
        let query = PFQuery(className: "Activity")
        query.whereKey("description", notContainedIn:dontShowUsers)
        // 6
        query.orderByDescending("createdAt")
        
        // 7
        query.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            // 8
            self.thingsToDo = result as? [PFObject] ?? []
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func moreButtonTapped(sender: AnyObject) {
        var randomNum = Int(arc4random_uniform(UInt32(thingsToDo.count)))
        var randomObject = thingsToDo[randomNum]
        var testString = randomObject.description
        //println(testString)
        var notherTest = testString.rangeOfString("n = ")!.startIndex
        var trying: String = String(stringInterpolationSegment: notherTest)
        //println(trying)
        var startNum: Int = trying.toInt()!
        startNum += 5
        var newString = testString.substringWithRange(Range<String.Index>(start: advance(testString.startIndex, startNum), end: advance(testString.endIndex, -4)))
        //println(newString)
        nextActivity.text = newString
    }


}

