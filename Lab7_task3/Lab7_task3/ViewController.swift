//
//  ViewController.swift
//  Lab7_task3
//
//  Created by Arseny Cheb on 19.05.17.
//  Copyright © 2017 Arseny Cheb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var switchIndicator: UILabel!
    @IBOutlet weak var backgroundSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        switchIndicator.text = "Background image: bg1.jpg"
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg1")!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backgroundSwitchTapped(_ sender: Any) {
        if backgroundSwitch.isOn
        {
            switchIndicator.text = "Background image: bg1.jpg"
            view.backgroundColor = UIColor(patternImage: UIImage(named:
                "bg1")!)
        }
        else
        {
            switchIndicator.text = "Background image: bg2.jpg"
            view.backgroundColor = UIColor(patternImage: UIImage(named:
                "bg2")!)
        }
    }

}

