//
//  VC5.swift
//  somprazApp
//
//  Created by digiLATERAL on 11/10/23.
//

import UIKit
import Foundation

class VC5: UIViewController {
    
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var ques4IV: UIImageView!
    @IBOutlet weak var topicIV: UIImageView!
    @IBOutlet weak var quesLbl: UILabel!
    
    @IBOutlet weak var timerLbl: UILabel!
    
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    
    @IBOutlet weak var stackView2: UIStackView!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    var question: String = ""
    var arrAllQuestions = [QuizModelElement]()
    var arrSelectedCategoryQuestion = [QuizModelElement]()
    var currentQuestion : QuizModelElement?
    var answers = [AnswerOption]()
    var correctAnswer: Int?
    var selectedCategory: String = ""
    var displayedQuestionsID = [String]()
    var Id: String = ""
    
    var selectedDoctorName = ""
    var selectedDoctorID = ""
    
    // timer
    var time = 0
    
    weak var timer: Timer?
    // Add a property to store the remaining time
    var remainingTime = 10 // Adjust the initial time as needed
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "" // Set an empty title
        // or
        self.navigationItem.title = nil
        
        
        // Start the timer when the view loads
        startTimer()
        quiz()
        
        btn1.layer.borderWidth = 4
        btn2.layer.borderWidth = 4
        btn3.layer.borderWidth = 4
        btn4.layer.borderWidth = 4
        
        btn1.layer.borderColor = UIColor.white.cgColor
        btn2.layer.borderColor = UIColor.white.cgColor
        btn3.layer.borderColor = UIColor.white.cgColor
        btn4.layer.borderColor = UIColor.white.cgColor
        
        btn1.layer.cornerRadius = 16
        btn2.layer.cornerRadius = 16
        btn3.layer.cornerRadius = 16
        btn4.layer.cornerRadius = 16
        
        
        setUpUI()
        
        
    }
    
    func setUpUI() {
        
        if Id == "EntertainmentYellow" {
            topicIV.image = UIImage(named: "EntertainmentWhite" )
        } else if Id == "AstronomyYellow" {
            topicIV.image = UIImage(named: "AstronomyWhite" )
        } else if Id == "HistoryYellow" {
            topicIV.image = UIImage(named: "HistoryWhite" )
        } else if Id == "Science Yellow" {
            topicIV.image = UIImage(named: "Science White 1" )
        } else if Id == "Literature Yellow" {
            topicIV.image = UIImage(named: "Literature White" )
        } else if Id == "Geography Yellow" {
            topicIV.image = UIImage(named: "Geography White" )
        } else if Id == "Wildlife Yellow" {
            topicIV.image = UIImage(named: "Wildlife White" )
        } else if Id == "Technology Yellow" {
            topicIV.image = UIImage(named: "Technology White" )
        } else if Id == "Mathematics Yellow" {
            topicIV.image = UIImage(named: "Mathematics White" )
        }
        
    }
    
    
    func quiz() {
        guard let url = URL(string: "https://backup-quiz-server.onrender.com/api/questions?category=\(selectedCategory)") else {
            print("QUIZ ERROR OCCURRED")
            return
        }
        
        let loader = self.loader()
        
        URLSession.shared.makeRequest(url: url, expecting: [QuizModelElement].self) { [weak self] result in
            switch result {
            case .success(let questions):
                print(result)
                DispatchQueue.main.async {
                    self?.displayedQuestionsID = [String]()
                    self?.arrAllQuestions = [QuizModelElement]()
                    self?.arrAllQuestions = questions
                    self?.updateSelectedCategoryQuestionList()
                }
            case .failure(let error):
                print(error)
                print("playAgain")
            }
//             Dismiss the loading indicator when the network request is complete
            self?.stopLoader(loader: loader)
        }
    }
    
    func updateCurrentQuestion() {
        print("arrSelectedCategoryQuestion count is \(arrSelectedCategoryQuestion.count)")
        if !arrSelectedCategoryQuestion.isEmpty {
            
            for i in 0..<arrSelectedCategoryQuestion.count {
                let quest = arrSelectedCategoryQuestion[i]
                if !displayedQuestionsID.contains(quest.id) {
                    currentQuestion = quest
                    displayQuestion()
                    break
                }
            }
        } else {
            let alert = UIAlertController(title: "Oops", message: "No questions available for \(selectedCategory)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func updateSelectedCategoryQuestionList() {
        // Filter questions based on the selected category
        arrSelectedCategoryQuestion = [QuizModelElement]()
        arrSelectedCategoryQuestion = arrAllQuestions.filter { $0.category == self.selectedCategory }
        
        if arrSelectedCategoryQuestion.isEmpty {
            print("No questions found for category: \(self.selectedCategory)")
        } else {
            self.updateCurrentQuestion() // Update the UI with the selected question
        }
    }
    
    
    func displayQuestion() {
        if let currentQuestion = currentQuestion {
            displayedQuestionsID.append(currentQuestion.id)
            for i in 0..<arrSelectedCategoryQuestion.count {
                if currentQuestion.id == arrSelectedCategoryQuestion[i].id {
                    arrSelectedCategoryQuestion.remove(at: i)
                    break
                }
            }
            self.quesLbl.text = currentQuestion.question
            if currentQuestion.answerOptions.count >= 4 {
                self.btn1.setTitle(currentQuestion.answerOptions[0].answer, for: .normal)
                self.btn2.setTitle(currentQuestion.answerOptions[1].answer, for: .normal)
                self.btn3.setTitle(currentQuestion.answerOptions[2].answer, for: .normal)
                self.btn4.setTitle(currentQuestion.answerOptions[3].answer, for: .normal)
            }
        }
    }
    
    
    // Function to start the timer
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
            timerLbl.text = String(remainingTime)
        } else {
            // Time's up, create and present the custom alert view controller
            self.timer?.invalidate() // Stop the timer
            
            // Create an instance of CustomTimeoutAlertViewController
            let customTimeoutAlert = storyboard?.instantiateViewController(withIdentifier: "CustomTimeoutAlertViewController") as! CustomTimeoutAlertViewController
            customTimeoutAlert.score = self.calculateScore() // Set the score
            customTimeoutAlert.name = selectedDoctorName
            // Present the CustomTimeoutAlertViewController modally
            customTimeoutAlert.modalPresentationStyle = .overCurrentContext // Set the presentation style as needed
            customTimeoutAlert.modalTransitionStyle = .crossDissolve // Set the transition style as needed
            self.present(customTimeoutAlert, animated: true, completion: nil)
            
            // After 5 seconds, dismiss the alert controller and push VC6
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        customTimeoutAlert.dismiss(animated: true) {
                            // Create an instance of VC6
                            let vc6 = self.storyboard?.instantiateViewController(withIdentifier: "VC6") as! VC6
                            vc6.selectedDoctorID = self.selectedDoctorID
                            vc6.selectedDoctorName = self.selectedDoctorName
                            // Push VC6 onto the navigation stack
                            self.navigationController?.pushViewController(vc6, animated: true)
                        }
                    }
            
        }
    }
    
    func calculateScore() -> Int {
        // Implement your logic to calculate the score based on user's answers
        // Return the score value
        return 42 // Replace with your score calculation
    }
    
    
    func displayNextQuestion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.resetAnswers()
            self.updateCurrentQuestion()
        }
    }
    
    func resetAnswers() {
        btn1.layer.borderColor = UIColor.white.cgColor
        btn2.layer.borderColor = UIColor.white.cgColor
        btn3.layer.borderColor = UIColor.white.cgColor
        btn4.layer.borderColor = UIColor.white.cgColor
    }
    
    func setCorrectAnswerBorderColor(answer: Int) {
        // Implement the logic to set the correct answer button's border color
        // based on the 'answer' parameter.
    }
    
    func highlightCorrectAnswer(index: Int) {
        // Implement the logic to set the correct answer button's border color
        // based on the 'index' parameter.
        switch index {
        case 0:
            btn1.layer.borderColor = UIColor.green.cgColor
        case 1:
            btn2.layer.borderColor = UIColor.green.cgColor
        case 2:
            btn3.layer.borderColor = UIColor.green.cgColor
        case 3:
            btn4.layer.borderColor = UIColor.green.cgColor
        default:
            break
        }
    }
    
    func checkAnswer(button: UIButton, answerIndex: Int) {
        if let currentQuestion = currentQuestion {
            if currentQuestion.answerOptions[answerIndex].isCorrect {
                // Correct answer selected
                button.layer.borderColor = UIColor.green.cgColor
            } else {
                // Wrong answer selected
                button.layer.borderColor = UIColor.red.cgColor
                // Highlight the correct answer with a green border
                if let correctIndex = currentQuestion.answerOptions.firstIndex(where: { $0.isCorrect }) {
                    // Modify the border color of the correct answer button
                    switch correctIndex {
                    case 0: btn1.layer.borderColor = UIColor.green.cgColor
                    case 1: btn2.layer.borderColor = UIColor.green.cgColor
                    case 2: btn3.layer.borderColor = UIColor.green.cgColor
                    case 3: btn4.layer.borderColor = UIColor.green.cgColor
                    default:
                        break
                    }
                }
            }
            // Load the next question
            displayNextQuestion()
        }
    }
    
    @IBAction func onBtnTapped(_ sender: UIButton) {
        checkAnswer(button: sender, answerIndex: sender.tag)
    }
    
}

extension VC5 {
    
    func loader() -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 60, height: 60))
        loadingIndicator.hidesWhenStopped = true
        if #available(iOS 13.0, *) {
            loadingIndicator.style = UIActivityIndicatorView.Style.large
        } else {
            // Fallback on earlier versions
        }
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        return alert
        
    }
    
    func stopLoader(loader : UIAlertController) {
        
        DispatchQueue.main.async {
            loader.dismiss(animated: true,completion: nil)
        }
    }
}

