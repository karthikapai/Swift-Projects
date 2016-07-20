//
//  DetailViewController.swift
//  project1
//
//  Created by Karthika S Pai on 7/9/16.
//  Copyright © 2016 cherryblossom. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {

  
  @IBOutlet var detailImageView: UIImageView!


  var detailItem: String? {
    didSet {
        // Update the view.
        self.configureView()
    }
  }

  func configureView() {
    // Update the user interface for the detail item.
    if let detail = self.detailItem {
        if let imageView = self.detailImageView {
          imageView.image = UIImage(named: detail)
        }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.configureView()
    //self.title = self.detailItem;
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(shareTapped))
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(sharesocial))

  }
  
  override func viewWillAppear(animated: Bool)
  {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }
  
  func shareTapped()
  {
    let vc = UIActivityViewController(activityItems: [detailImageView.image!], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    presentViewController(vc, animated: true, completion: nil)
  }
  
  func sharesocial()
  {
    let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
    vc.setInitialText("Look at this great picture!")
    vc.addImage(detailImageView.image!)
    vc.addURL(NSURL(string: "http://www.photolib.noaa.gov/nssl"))
    presentViewController(vc, animated: true, completion: nil)
    
  }


  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

