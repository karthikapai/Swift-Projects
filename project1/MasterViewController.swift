//
//  MasterViewController.swift
//  project1
//
//  Created by Karthika S Pai on 7/9/16.
//  Copyright © 2016 cherryblossom. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

  var detailViewController: DetailViewController? = nil
  var objects = [String]()


  override func viewDidLoad() {
    super.viewDidLoad()
    let fm = NSFileManager.defaultManager()
    let path = NSBundle.mainBundle().resourcePath!
    let items = try! fm.contentsOfDirectoryAtPath(path) // returns path string of object
    
    for item in items
    {
      if item.hasPrefix("nssl")
      {
        objects.append(item)
      }
    }
    self.title = "Images"
  }

  override func viewWillAppear(animated: Bool) {
    self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
    super.viewWillAppear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

    // deleted insertnewobject


  // MARK: - Segues

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
        if let indexPath = self.tableView.indexPathForSelectedRow {
          let navigationController = segue.destinationViewController as! UINavigationController
          let controller = navigationController.topViewController as! DetailViewController
          controller.detailItem = objects[indexPath.row]
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
  }

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

  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }

 //deleted tableview commiteditingstyle


}

