//
//  ViewController.swift
//  Project34
//
//  Created by Juan Garcia on 8/10/17.
//  Copyright © 2017 Juan Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var columnButtons: [UIButton]!
    
    var placedChips = [[UIView]]()
    var board: Board!
    
    //  MARK: - Controller lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  MARK: - UI set up
    
    func updateUI() {
        title = "\(board.currentPlayer.name)'s Turn"
    }
    
    func initialSetUp() {
        for _ in 0 ..< Board.width {
            placedChips.append([UIView]())
        }
        
        resetBoard()
    }
    
    func resetBoard() {
        board = Board()
        updateUI()
        
        for i in 0 ..< placedChips.count {
            for chip in placedChips[i] {
                chip.removeFromSuperview()
            }
            
            placedChips[i].removeAll(keepingCapacity: true)
        }
    }
    
    //  MARK: - Action buttons
    
    @IBAction func makeMove(_ sender: UIButton) {
        let column = sender.tag
        
        if let row = board.nextEmptySlot(in: column) {
            board.add(chip: .red, in: column)
            //addChip(inColumn: column, row: row, color: .red)
            // updated
            addChip(inColumn: column, row: row, color: board.currentPlayer.color)
            continueGame()
        }
    }
    
    //  MARK: - Main methods
    
    func addChip(inColumn column: Int, row: Int, color: UIColor) {
        let button = columnButtons[column]
        let size = min(button.frame.width, button.frame.height / 6)
        let rect = CGRect(x: 0, y: 0, width: size, height: size)
        
        if (placedChips[column].count < row + 1) {
            let newChip = UIView()
            newChip.frame = rect
            newChip.isUserInteractionEnabled = false
            newChip.backgroundColor = color
            newChip.layer.cornerRadius = size / 2
            newChip.center = positionForChip(inColumn: column, row: row)
            newChip.transform = CGAffineTransform(translationX: 0, y: -800)
            view.addSubview(newChip)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                newChip.transform = CGAffineTransform.identity
            })
            
            placedChips[column].append(newChip)
        }
    }
    
    func positionForChip(inColumn column: Int, row: Int) -> CGPoint {
        let button = columnButtons[column]
        let size = min(button.frame.width, button.frame.height / 6)
        
        let xOffset = button.frame.midX
        var yOffset = button.frame.maxY - size / 2
        yOffset -= size * CGFloat(row)
        return CGPoint(x: xOffset, y: yOffset)
    }
    
    func continueGame() {
        // 1 We create a gameOverTitle optional string set to nil.
        var gameOverTitle: String? = nil
        
        // 2 If the game is over or the board is full, gameOverTitle is updated to include the relevant status message.
        if board.isWin(for: board.currentPlayer) {
            gameOverTitle = "\(board.currentPlayer.name) Wins!"
        } else if board.isFull() {
            gameOverTitle = "Draw!"
        }
        
        // 3 If gameOverTitle is not nil (i.e., the game is won or drawn), show an alert controller that resets the board when dismissed.
        if gameOverTitle != nil {
            let alert = UIAlertController(title: gameOverTitle, message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Play Again", style: .default) { [unowned self] (action) in
                self.resetBoard()
            }
            
            alert.addAction(alertAction)
            present(alert, animated: true)
            
            return
        }
        
        // 4 Otherwise, change the current player of the game, then call updateUI() to set the navigation bar title.
        board.currentPlayer = board.currentPlayer.opponent
        updateUI()
    }
}

