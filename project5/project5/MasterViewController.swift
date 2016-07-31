//
//  MasterViewController.swift
//  project5
//
//  Created by Karthika S Pai on 7/29/16.
//  Copyright © 2016 cherryblossom. All rights reserved.
//

import UIKit
import GameplayKit

class MasterViewController: UITableViewController {

  
  var objects = [String]()
  var allWords = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(PromptForAnswer))
    // Do any additional setup after loading the view, typically from a nib.
    
    if let startWordsPath = NSBundle.mainBundle().pathForResource("start", ofType: "txt")
    {
      if let startWords = try? String(contentsOfFile: startWordsPath, usedEncoding: nil)
      {
        allWords = startWords.componentsSeparatedByString("\n")
      }
    } else {
      
      allWords = ["silkworm"]
    }
    startGame()
  }

  func PromptForAnswer()
  {
    let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .Alert)
    
    ac.addTextFieldWithConfigurationHandler(nil)
    
    let submitAction = UIAlertAction(title: "Submit", style: .Default)
    {
      [unowned self, ac] _ in
      
      let answer = ac.textFields![0]
      self.submitAnswer(answer.text!)
      
      
    }
    
    ac.addAction(submitAction)
    presentViewController(ac, animated: true, completion: nil)
  }
  
  func submitAnswer(answer:String)
  {
    let lowerAnswer = answer.lowercaseString
    
    var errorTitle: String = ""
    var errorMessage: String = ""
    
    
    if wordisPossible(lowerAnswer)
    {
      if wordisOriginal(lowerAnswer)
      {
        if wordisReal(lowerAnswer)
        {
          objects.insert(answer, atIndex:0)
          
          let indexPath = NSIndexPath(forRow: 0, inSection: 0)
          
          tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        else
        {
          errorTitle = "word not recognized"
          errorMessage = "only real words, please"
        }
      }
      else
      {
        errorTitle = "word used already"
        errorMessage = "be more original"
      }
    }
    else
    {
      errorTitle = "word not possible"
      errorMessage = "you can't spell that word from \(title!.lowercaseString)!"
    }
    
    let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .Alert)
    ac.addAction(UIAlertAction(title:"ok", style: .Default, handler: nil))
    
    presentViewController(ac, animated: true, completion: nil)
  }
  
  func wordisPossible(word:String) -> Bool
  {
    var tempWord = title!.lowercaseString
    
    for letter in word.characters {
      if let pos = tempWord.rangeOfString(String(letter))
      {
        tempWord.removeAtIndex(pos.startIndex)
      }
      else{
        return false
      }
    }
    
    return true
  }
  func wordisOriginal(word:String) -> Bool
  {
    
    return !objects.contains(word)
  }
  func wordisReal(word:String) -> Bool
  {
    
    let checker = UITextChecker()
    let range = NSMakeRange(0, word.characters.count)
    let misspelledRange = checker.rangeOfMisspelledWordInString(word, range: range, startingAt: 0, wrap: false, language: "en")
    return misspelledRange.location == NSNotFound
  }
  
  func startGame() {
    allWords = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(allWords) as! [String]
    title = allWords[0]
    objects.removeAll(keepCapacity:true)
    tableView.reloadData()
    
    
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

 

  // MARK: - Segues

  

  // MARK: - Table View

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objects.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

    let object = objects[indexPath.row]
    cell.textLabel!.text = object
    return cell
  }






}

