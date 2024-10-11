import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet var optionButtons: [UIButton]!
    
    var continents: [Continent] = []
    var currentQuestion: Question?
    var score = 0
    let countries = [
        Country(name: "Kazakhstan", flagImage: UIImage(named: "Kazakhstan") ?? UIImage(), continent: "Asia"),
        Country(name: "Ukraine", flagImage: UIImage(named: "Ukraine") ?? UIImage(), continent: "Europe"),
        Country(name: "China", flagImage: UIImage(named: "China") ?? UIImage(), continent: "Asia"),
        Country(name: "Japan", flagImage: UIImage(named: "Japan") ?? UIImage(), continent: "Asia"),
        Country(name: "Korea", flagImage: UIImage(named: "Korea") ?? UIImage(), continent: "Asia"),
        Country(name: "Slovakia", flagImage: UIImage(named: "Slovakia") ?? UIImage(), continent: "Europe"),
        Country(name: "Slovenia", flagImage: UIImage(named: "Slovenia") ?? UIImage(), continent: "Europe"),
        Country(name: "Thailand", flagImage: UIImage(named: "Thailand") ?? UIImage(), continent: "Asia"),
        Country(name: "Turkey", flagImage: UIImage(named: "Turkey") ?? UIImage(), continent: "Europe"),
        Country(name: "UK", flagImage: UIImage(named: "UK") ?? UIImage(), continent: "Europe")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContinents()
        generateNewQuestion()
    }
    
    func setupContinents() {
        let asiaCountries = countries.filter { $0.continent == "Asia" }
        let europeCountries = countries.filter { $0.continent == "Europe" }
        
        continents = [
            Continent(name: "Asia", countries: asiaCountries),
            Continent(name: "Europe", countries: europeCountries)
        ]
    }
    
    func generateNewQuestion() {
        guard let selectedContinent = continents.randomElement() else { return }
        let availableCountries = selectedContinent.countries
        
        let correctCountry = availableCountries.randomElement()!
        let incorrectCountries = availableCountries.shuffled().prefix(3)
        
        let options = (incorrectCountries + [correctCountry]).shuffled()
        
        currentQuestion = Question(flag: correctCountry.flagImage, correctAnswer: correctCountry, options: Array(options))
        
        updateViewWithQuestion()
    }
    
    func updateViewWithQuestion() {
        guard let question = currentQuestion else { return }
        
        flagImageView.image = question.flag
        
        for (index, button) in optionButtons.enumerated() {
            button.setTitle(question.options[index].name, for: .normal)
        }
    }
    
    @IBAction func countryButtonTapped(_ sender: UIButton) {
        guard let question = currentQuestion else { return }
        
        if let buttonIndex = optionButtons.firstIndex(of: sender) {
            let selectedCountry = question.options[buttonIndex]
            
            if selectedCountry == question.correctAnswer {
                score += 1
                showAlert(title: "Correct!", message: "You got it right!")
            } else {
                showAlert(title: "Wrong!", message: "That was not the correct country.")
            }
            
            scoreLabel.text = "Score: \(score)"
            generateNewQuestion()
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Next", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
