//
//  ViewController.swift
//  GuessTheFlag2
//
//  Created by Assel Artykbay on 12.10.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var currentQuestion: Question?
    var score: Int = 0
    
    var countries: [Country] = [
        Country(name: "Kazakhstan", flagName: "Kazakhstan", continent: "Asia"),
        Country(name: "Korea", flagName: "Korea", continent: "Asia"),
        Country(name: "Japan", flagName: "Japan", continent: "Asia"),
        Country(name: "China", flagName: "China", continent: "Asia"),
        Country(name: "Slovakia", flagName: "Slovakia", continent: "Europe"),
        Country(name: "Slovenia", flagName: "Slovania", continent: "Europe"),
        Country(name: "Thailand", flagName: "Thailand", continent: "Asia"),
        Country(name: "Turkey", flagName: "Turkey", continent: "Europe"),
        Country(name: "UK", flagName: "UK", continent: "Europe"),
        Country(name: "Ukraine", flagName: "Ukraine", continent: "Europe"),
    ]

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    override func viewDidLoad() {
        countries.shuffle()
        super.viewDidLoad()
        setQuestion()
    }
    
    func setQuestion(){
        let options = countries.prefix(4)
        let correctCountry = options[0]
        currentQuestion = Question(flag: correctCountry.flagName, correctAnswer: correctCountry, options: Array(options.shuffled()))
        countries.remove(at: 0)
        if let flagName = currentQuestion?.flag {
            image.image = UIImage(named: flagName)
        }
        
        for (index, button) in buttons.enumerated() {
            if index < currentQuestion?.options.count ?? 0 {
                button.setTitle(currentQuestion?.options[index].name, for: .normal)
            }
        }
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        guard let question = currentQuestion else { return }
        
        if let buttonIndex = buttons.firstIndex(of: sender){
            let selectedCountry = question.options[buttonIndex]
            if selectedCountry == question.correctAnswer {
                score += 1
                showAlert(title: "Correct", message: "You got it right")
            }else {
                showAlert(title: "Wrong", message: "That was not the correct country.")
            }
            
            scoreLabel.text = "Score: \(score)"
            setQuestion()
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Next", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

