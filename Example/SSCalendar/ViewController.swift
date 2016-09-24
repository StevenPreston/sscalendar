//
//  ViewController.swift
//  SSCalendar
//
//  Created by Steven Preston on 09/21/2016.
//  Copyright (c) 2016 Steven Preston. All rights reserved.
//

import UIKit
import SSCalendar

class ViewController: UIViewController {

    @IBOutlet var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonTapped(sender: AnyObject?) {

        let podBundle = NSBundle(forClass: SSCalendarAnnualViewController.self)
        let bundleURL = podBundle.URLForResource("SSCalendar", withExtension: "bundle")
        let bundle = NSBundle(URL: bundleURL!)!

        let annualViewController = SSCalendarAnnualViewController(nibName: "SSCalendarAnnualViewController", bundle: bundle)
        let navigationController = UINavigationController(rootViewController: annualViewController)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
}

