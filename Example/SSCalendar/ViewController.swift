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
        let annualViewController = SSCalendarAnnualViewController(nibName: "SSCalendarAnnualViewController", bundle: SSCalendarUtils.calendarBundle()!)
        let navigationController = UINavigationController(rootViewController: annualViewController)
        navigationController.navigationBar.translucent = false
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
}

