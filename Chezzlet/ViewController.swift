//
//  ViewController.swift
//  Chezzlet
//
//  Created by Riad Mohamed on 11/18/19.
//  Copyright © 2019 Riad Mohamed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var board = ChessBoard(lightColor: .lightBrown, darkColor: .darkBrown, highlightColor: .blue, possibleColor: .green)
    
    
    @IBOutlet var buttonArray: [UIButton]!
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        let currentIndex = sender.tag
        
        if !board.buttonTappedState {
            // Check if there is a piece on top
            if board.checkIfEmpty(currentIndex) {
                // Empty tile. Do nothing, same turn.
                print("tapped an empty tile, do nothing.")
            } else {
                // Get possible moves for this piece, same turn.
                let possibleIndices: [Int] = board.getPossibleTiles(sender.tag)
                if possibleIndices.count != 0 {
                    colorPossibleIndices(possibleIndices: possibleIndices, sender.tag)
                    print("Tapped a tile with piece on top")
                }
                board.buttonTappedState = true
            }
        } else {
            // check if same piece from last turn
            if board.lastTurnIndex == sender.tag {
                // default colors, state back to false
                print("Tapped the same tile as last turn")
                board.buttonTappedState = false
                colorTilesWithDefaultColors()
            } else if board.checkIfSameTeam(currentIndex) {
                // Same team, recursive call to the function
                print("Tapped an ally tile, recursive call")
                board.buttonTappedState = false
                buttonTapped(sender)
            } else {
                // ENEMY!!
                print("Tapped an enemy tile!!")
                board.movePieceSequence(currentIndex)
                colorTilesWithDefaultColors()
                updateUI()
                board.buttonTappedState = false
            }
        }
        board.lastTurnIndex = sender.tag
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorTilesWithDefaultColors()
        updateUI()
        board.chessPiecesArray.append(nil)
        board.chessPiecesArray.append(nil)
        board.chessPiecesArray.append(nil)
        board.chessPiecesArray.append(nil)
        board.chessPiecesArray.append(nil)
        board.chessPiecesArray.append(nil)
    }
    
    func colorTilesWithDefaultColors() {
        var state = true
        var counter = 0

        for button in buttonArray {
            if counter == 8 {
                counter = 0
                state = !state
            }
            if state {
                button.backgroundColor = board.TILE_LIGHT_COLOR
            } else {
                button.backgroundColor = board.TILE_DARK_COLOR
            }
            state = !state
            counter+=1
        }
    }

    func colorPossibleIndices(possibleIndices indicesArray: [Int], _ currentIndex: Int) {
        colorTilesWithDefaultColors()
        for index in indicesArray {
            buttonArray[index].backgroundColor = board.TILE_POSSIBLE_COLOR
        }
        buttonArray[currentIndex].backgroundColor = board.TILE_HIGHLIGHT_COLOR
    }
    
    func updateUI() {
        for index in 0..<board.chessPiecesArray.count {
            buttonArray[index].setImage(board.chessPiecesArray[index]?.image, for: .normal)
        }
    }
}

