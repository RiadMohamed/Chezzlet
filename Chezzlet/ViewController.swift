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
    var blackArray: [ChessPiece] = []
    var whiteArray: [ChessPiece] = []
    
    @IBOutlet var buttonArray: [UIButton]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupInitialBoard()
        print(blackArray.count)
    }

    func setupInitialBoard () {
        for button in buttonArray {
            switch button.tag {
                case 0, 7:
                    let rook = Rook(.black)
                    button.setImage(rook.image, for: .normal)
                    blackArray.append(rook)
                case 1, 6: break
                case 2, 5: break
                case 3: break
                case 4: break
                case 8...15: break
                
                case 48...55: break
                case 56, 63:
                    let rook = Rook(.white)
                    button.setImage(rook.image, for: .normal)
                    whiteArray.append(rook)
                case 57, 62: break
                case 58, 61: break
                case 59: break
                case 60: break
                default: break
            }
        }
    }

}

