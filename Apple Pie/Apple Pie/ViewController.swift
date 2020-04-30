//
//  ViewController.swift
//  Apple Pie
//
//  Created by Andrea Dancek on 2020-04-25.
//  Copyright © 2020 Melisa Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var treeImageView: UIImageView!
     @IBOutlet var correctWordLabel: UILabel!
     @IBOutlet var scoreLabel: UILabel!
     @IBOutlet var letterButtons: [UIButton]!
    
    var listOfWords = ["horse" , "cat", "dog", "duck" , "spider", "octopus", "zebra"]
    let incorrectMovesAllowed = 7
    
    var totalWins = 0{
        didSet{
            newRound()
        }
    }
    var totalLosses = 0{
        didSet{
            newRound()
        }
    }
     var currentGame : Game!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterSting = sender.title(for: .normal)!
        let letter = Character (letterSting.lowercased())
      currentGame.playerGuessed(letter: letter)
        
      updateGameState()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func newRound(){
        if !listOfWords.isEmpty{
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(_enable: true)
            updateUI()
        }else{
            enableLetterButtons(_enable: true)
        }
        
    }
    func enableLetterButtons(_enable : Bool){
    for button in letterButtons{
        button.isEnabled = _enable
        }
    }
    func updateUI(){
        var letters = [String]()
        for letter in currentGame.formattedWord{
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator : " ")
        
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    func updateGameState(){
         if currentGame.incorrectMovesRemaining == 0 {
             totalLosses += 1
         }else if currentGame.word == currentGame.formattedWord{
             totalWins += 1
         }else {
             updateUI()
         }
     }
    
  
}

