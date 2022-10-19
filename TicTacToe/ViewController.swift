//
//  ViewController.swift
//  TicTacToe
//
//  Created by Martin Richter on 19.10.22.
//

import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case Cross
        case Cyrcle
    }

    @IBOutlet weak var turnLable: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstTurn = Turn.Cross
    var nextTurn = Turn.Cross
    
    var CYRCLE = "O"
    var CROSS = "X"
    var board = [UIButton]()
    
    var crossscore = 0
    var cyrclescore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
        // Do any additional setup after loading the view.
    }
    
    func initBoard() {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }

    @IBAction func boardTapAction(_ sender: UIButton) {
        
        addToBoard(sender)
        
        if checkForVictory(CROSS) {
            
            crossscore += 1
            resultAlert(titel: "Crosses Win")
        }

        if checkForVictory(CYRCLE) {

            cyrclescore += 1
            resultAlert(titel: "Cyrcle Win")
        }
        
        if(fullBoard()) {
            resultAlert(titel: "Draw")
        }
    }
    
    func checkForVictory(_ s: String) -> Bool {
        
        
        // Horizental Victory
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s) {
            
            return true
        }
        
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s) {
            
            return true
        }
        
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s) {
            
            return true
        }
        
        // Vertiacal Victory
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s) {
            
            return true
        }
        
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s) {
            
            return true
        }
        
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s) {
            
            return true
        }
        
        // Diagonal Victory
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s) {
            
            return true
        }
        
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s) {
            
            return true
        }
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(titel: String) {
        
        let message = "\nCyrcle " + String(cyrclescore) + "\n\nCrosses" + String(crossscore)
        let ac = UIAlertController(title: titel, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if (firstTurn == Turn.Cyrcle) {
            firstTurn = Turn.Cross
            turnLable.text = CROSS
        } else  if (firstTurn == Turn.Cross) {
            firstTurn = Turn.Cyrcle
            turnLable.text = CYRCLE
        }
        nextTurn = firstTurn
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton) {
        if (sender.title(for: .normal) == nil) {
            
            if (nextTurn == Turn.Cyrcle) {
                sender.setTitle(CYRCLE, for: .normal)
                nextTurn = Turn.Cross
                turnLable.text = CROSS
            } else  if (nextTurn == Turn.Cross) {
                sender.setTitle(CROSS, for: .normal)
                nextTurn = Turn.Cyrcle
                turnLable.text = CYRCLE
            }
            sender.isEnabled = false
        }
    }
    
}

