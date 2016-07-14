//
//  ViewController.swift
//  project2
//
//  Created by Karthika S Pai on 7/13/16.
//  Copyright © 2016 cherryblossom. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
  @IBOutlet var button1: UIButton!
  @IBOutlet var button2: UIButton!
  @IBOutlet var button3: UIButton!
  
  @IBOutlet var scoretext: UILabel! // declare ib outlet before declaring the variable inside
  
  var countries = [String]()
  var correctAnswer = 0
  var score = 0
  
  
  
  

  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    countries.append("estonia")
    countries.append("france")
    countries.append("germany")
    countries.append("ireland")
    countries.append("italy")
    countries.append("monaco")
    countries.append("nigeria")
    countries.append("poland")
    countries.append("russia")
    countries.append("spain")
    countries.append("uk")
    countries.append("us")
    
    button1.layer.borderWidth = 1
    button2.layer.borderWidth = 1
    button3.layer.borderWidth = 1
    
    button1.layer.borderColor = UIColor.lightGrayColor().CGColor
    button2.layer.borderColor = UIColor.lightGrayColor().CGColor
    button3.layer.borderColor = UIColor.lightGrayColor().CGColor
    
    scoretext.text = String(score)
    
    
    askQuestion(nil)
  }
  
  func askQuestion(action: UIAlertAction!)
  {
    countries = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countries) as! [String]
    button1.setImage(UIImage(named: countries[0]), forState: .Normal)
    button2.setImage(UIImage(named: countries[1]), forState: .Normal)
    button3.setImage(UIImage(named: countries[2]), forState: .Normal)
    correctAnswer = GKRandomSource.sharedRandom().nextIntWithUpperBound(3)
    title = countries[correctAnswer].uppercaseString
    
    
  }
  @IBAction func buttonTapped(sender: UIButton) {
    var title: String
    
    if sender.tag == correctAnswer
    {
      title = "Correct"
      score += 1
    } else {
      title = "Wrong"
      score -= 1
    }
    scoretext?.text = "Score: \(score)"
    
    let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .Alert)
    ac.addAction(UIAlertAction(title: "Continue", style: .Default, handler: askQuestion))
    presentViewController(ac, animated: true, completion: nil)
    
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

