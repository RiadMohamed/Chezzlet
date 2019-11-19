//
//  ViewController.swift
//  Chezzlet
//
//  Created by Riad Mohamed on 11/18/19.
//  Copyright © 2019 Riad Mohamed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let ROW_COUNT = 8
    let COL_COUNT = 8
    @IBOutlet var buttonArray: [UIButton]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Total UIButtons in array =  \(buttonArray.count)")
        for button in buttonArray {
            button.setImage(UIImage(named: "Black_King")!, for: .normal)
            print(button.tag)
        }
    }

}

