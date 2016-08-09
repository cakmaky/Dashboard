//
//  ViewController.swift
//  DashboardYalcinCakmak
//
//  Created by YC on 8/8/16.
//  Copyright © 2016 University of California at Santa Cruz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textDisplay: UILabel!
    
    @IBAction func controlActivated(control: UIControl) {
        
        if let appDel = UIApplication.sharedApplication().delegate as? AppDelegate {
            self.textDisplay.text = appDel.dataFetcher?.nextTitle
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let appDel = UIApplication.sharedApplication().delegate as? AppDelegate {
            self.textDisplay.text = appDel.dataFetcher?.currentTitle
        }
    }
}

