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
    var boardPiecesArray: [ChessPiece?] = []
    var buttonTappedState: Bool = false
    let BOARD_LIGHT_COLOR = UIColor(red: 0.943, green: 0.852, blue: 0.708, alpha: 1)
    let BOARD_DARK_COLOR = UIColor(red: 0.710, green: 0.533, blue: 0.387, alpha: 1)
    var lastTappedPiece: ChessPiece? = nil
    
    
    @IBOutlet var buttonArray: [UIButton]!
    @IBAction func buttonTapped(_ sender: UIButton) {
        boardPiecesArray.append(nil)
        boardPiecesArray.append(nil)
        boardPiecesArray.append(nil)
        boardPiecesArray.append(nil)
        
        guard let currentPiece = boardPiecesArray[sender.tag] else {
            // tile has no piece on top.
            // Just move the piece and change it's index.
            print("no piece found on the button")
            return
        }
        
//        buttonTappedState = true
        if currentPiece.color == lastTappedPiece?.color, currentPiece.id != lastTappedPiece?.id {
            // Same team.
            buttonTappedState = false
        } else if currentPiece.color != lastTappedPiece?.color, buttonTappedState {
            // Different Teams, possible move.
            movePiece(sender.tag)
            
        }
        checkPossibleTiles(currentPiece, sender.tag)
        buttonTappedState.toggle()
        lastTappedPiece = currentPiece
    }
    
    func movePiece(_ to: Int) {
        print("Moving the piece to new location")
    }
    
    
    func checkPossibleTiles(_ currentPiece: ChessPiece, _ buttonIndex: Int) {
        if let previousPiece = lastTappedPiece {
            print("Current Piece : \(currentPiece.id)")
            print("Previous Piece : \(previousPiece.id)")
            if buttonTappedState == false {
                // ButtonTappedState = false
                colorPossibleTiles(currentPiece, buttonIndex)
            } else {
                // ButtonTappedState = true
                colorDefaultTiles()
            }
        } else {
            lastTappedPiece = currentPiece
            checkPossibleTiles(currentPiece, buttonIndex)
        }
        print("--------------------")
    }
    
    func colorDefaultTiles() {
        var state = true
        var counter = 0
        
        for button in buttonArray {
            if counter == 8 {
                counter = 0
                state = !state
            }
            if state {
                button.backgroundColor = BOARD_LIGHT_COLOR
            } else {
                button.backgroundColor = BOARD_DARK_COLOR
            }
            state = !state
            counter+=1
        }
    }
    
    func colorPossibleTiles(_ currentPiece: ChessPiece, _ buttonIndex: Int) {
        let currentButton = buttonArray[buttonIndex]
        currentButton.backgroundColor = .systemBlue
        for button in buttonArray {
            if button.tag != currentButton.tag {
                if currentPiece.checkValidMove(from: currentButton.tag, to: button.tag) {
                    button.backgroundColor = .systemGreen
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        colorDefaultTiles()
        setupInitialBoard()
        updateUI()
    }

    func updateUI() {
        for index in 0..<boardPiecesArray.count {
            if let pieceOnTop = boardPiecesArray[index] {
                buttonArray[index].setImage(pieceOnTop.image, for: .normal)
            }
        }
    }
    
    func setupInitialBoard () {
        for button in buttonArray {
            switch button.tag {
                case 0, 7:
                    let rook = Rook(.black)
                    boardPiecesArray.append(rook)
                    blackArray.append(rook)
                case 1, 6: break
                case 2, 5: break
                case 3: break
                case 4: break
                case 8...15: break
                
                case 48...55: break
                case 56, 63:
                    let rook = Rook(.white)
                    boardPiecesArray.append(rook)
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

