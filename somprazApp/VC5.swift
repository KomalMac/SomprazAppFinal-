//
//  VC5.swift
//  somprazApp
//
//  Created by digiLATERAL on 11/10/23.
//

import UIKit
import Foundation

struct Question {
    
    var Question : String!
    var Answers : [String]!
    var Answer : Int!
    
    var answer: String
       var isCorrect: Bool
       var id: String
    
    
}

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
    
    
    //    var Questions  = [Question]()
    //    var QNumber = Int()
    //    var AnswerNumber = Int()
    var question: String = ""
    var arrAllQuestions = [QuizModelElement]()
    var arrSelectedCategoryQuestion = [QuizModelElement]()
    var currentQuestion : QuizModelElement?
    var answers = [AnswerOption]()
    var correctAnswer: Int?
    var selectedCategory: String = ""
    var displayedQuestionsID = [String]()
    
    
    
    var Id: String = ""
    // timer
    var time = 0
    
    weak var timer: Timer?
    // Add a property to store the remaining time
    var remainingTime = 60 // Adjust the initial time as needed
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.title = "" // Set an empty title
        // or
        self.navigationItem.title = nil
        
        
        //        var Buttons = [btn1, btn2, btn3, btn4]
        
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
        
        
        
        //        Questions = [
        //            Question(Question: "Which is our national Animal?", Answers: ["Lion", "Tiger", "Elephant", "Bear"], Answer: 1),
        //            // Add more questions here
        //            Question(Question: "Which is our national flower?", Answers: ["Rose", "Lily", "Jasmine", "Lotus"], Answer: 3),
        //            Question(Question: "Which is our national Fruit?", Answers: ["Mango", "Apple", "Chikoo", "Banana"], Answer: 0),
        //            Question(Question: "Which is our national Sport?", Answers: ["Cricket", "VollyBall", "Hockey", "Running"], Answer: 3)
        //        ]
        
        //        PickQuestion()
        
        
    }
    
    
    
    func quiz() {
        guard let url = URL(string: "https://backup-quiz-server.onrender.com/api/questions?category=\(selectedCategory)") else {
            print("QUIZ ERROR OCCURRED")
            return
        }
        
        URLSession.shared.makeRequest(url: url, expecting: [QuizModelElement].self) { [weak self] result in
            switch result {
            case .success(let questions):
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
        }
    }
    func selectCategory() {
        
        
        //                    self?.questions.sort(by: <#T##(QuizModelElement, QuizModelElement) throws -> Bool#>)
        
        
        
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
            
//            arrSelectedCategoryQuestion.forEach { quest in
//                if !displayedQuestionsID.contains(quest.id), displayedQuestionsID.count <= arrSelectedCategoryQuestion.count {
//                    currentQuestion = quest
//                    displayQuestion()
//                }
//            }
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
        arrSelectedCategoryQuestion = arrAllQuestions.filter { $0.category.rawValue == self.selectedCategory }
        
        if arrSelectedCategoryQuestion.isEmpty {
            print("No questions found for category: \(self.selectedCategory)")
        } else {
            self.updateCurrentQuestion() // Update the UI with the selected question
        }
    }
    
    func displayQuestion() {
        
//        selectCategory()
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
        
//        if let firstQuestion = arrAllQuestions.first {
//            self.quesLbl.text = firstQuestion.question
//            
//            if firstQuestion.answerOptions.count >= 4 {
//                self.btn1.setTitle(firstQuestion.answerOptions[0].answer, for: .normal)
//                self.btn2.setTitle(firstQuestion.answerOptions[1].answer, for: .normal)
//                self.btn3.setTitle(firstQuestion.answerOptions[2].answer, for: .normal)
//                self.btn4.setTitle(firstQuestion.answerOptions[3].answer, for: .normal)
//            }
//            
//            
//        }
    }
    
    
    
    //    func PickQuestion() {
    //        if Questions.count > 0 {
    //            // If QNumber reaches the end of the array, reset it to 0
    //            if QNumber >= Questions.count {
    //                QNumber = 0
    //            }
    //            quesLbl.text = Questions[QNumber].Question
    //
    //            AnswerNumber = Questions[QNumber].Answer
    //
    //            if let answers = Questions[QNumber].Answers {
    //                btn1.setTitle(answers[0], for: .normal)
    //                btn2.setTitle(answers[1], for: .normal)
    //                btn3.setTitle(answers[2], for: .normal)
    //                btn4.setTitle(answers[3], for: .normal)
    //            }
    //        } else {
    //            // Handle the case where there are no questions or questions are exhausted
    //            // For example, you can show a message or take appropriate action
    //        }
    //    }
    
    
    
    
    // Function to start the timer
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    // Selector method to update the timer label
    @objc func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
            timerLbl.text = String(remainingTime)
        } else {
            // Time's up, you can perform any action here
            // For example, stop the timer or navigate to a different screen
            timer?.invalidate() // Stop the timer
            // Add your action here
        }
    }
    
    func displayNextQuestion() {
//        if let currentQuestion = arrAllQuestions.first {
//            quesLbl.text = currentQuestion.question
//        } else {
//            // Handle the case when there are no more questions
//        }
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
//            arrAllQuestions.removeFirst()
            displayNextQuestion()
        }
    }
    
    @IBAction func onBtnTapped(_ sender: UIButton) {

        checkAnswer(button: sender, answerIndex: sender.tag)
        
    }
    
    
    //
    @IBAction func btn1Tapped(_ sender: UIButton) {
        //
        checkAnswer(button: sender, answerIndex: 0)
//        if let currentQuestion = currentQuestion {
//               checkAnswer(button: sender, answerIndex: 0)
//               if currentQuestion.answerOptions.first?.isCorrect == true {
//                   sender.layer.borderColor = UIColor.green.cgColor
//               } else {
//                   sender.layer.borderColor = UIColor.red.cgColor
//                   if let correctIndex = currentQuestion.answerOptions.firstIndex(where: { $0.isCorrect }) {
//                       // Highlight the correct answer with a green border
//                       highlightCorrectAnswer(index: correctIndex)
//                   }
//               }
               // Load the next question
               displayNextQuestion()
            
            //        if let currentQuestion = questions.first {
            //
            //            checkAnswer(button: sender, answerIndex: 0)
            //            if currentQuestion.answerOptions.first?.isCorrect == true {
            //                    // Correct answer selected
            //                    sender.layer.borderColor = UIColor.green.cgColor
            //                } else {
            //                    // Wrong answer selected
            //                    sender.layer.borderColor = UIColor.red.cgColor
            //
            //                }
            //                // Load the next question
            //                questions.removeFirst()
            //                displayNextQuestion()
            //            }
            //
            //
            //
            //        //        // Set the border color of the tapped button to yellow
            //        //        sender.layer.borderColor = UIColor.yellow.cgColor
            //        //
            //        //        // Set the border color of other buttons to white
            //        //        if sender.tag != 1 {
            //        //            btn1.layer.borderColor = UIColor.white.cgColor
            //        //        }
            //        //        if sender.tag != 2 {
            //        //            btn2.layer.borderColor = UIColor.white.cgColor
            //        //        }
            //        //        if sender.tag != 3 {
            //        //            btn3.layer.borderColor = UIColor.white.cgColor
            //        //        }
            //        //        if sender.tag != 4 {
            //        //            btn4.layer.borderColor = UIColor.white.cgColor
            //        //        }
            //        //
            //        //        if AnswerNumber == 0 {
            //        //                // Correct answer selected
            //        //                sender.layer.borderColor = UIColor.green.cgColor
            //        //            } else {
            //        //                // Wrong answer selected
            //        //                sender.layer.borderColor = UIColor.red.cgColor
            //        //                setCorrectAnswerBorderColor()
            //        //            }
            //        //            QNumber += 1
            //        //            PickQuestion()
            //    }
            
            //    func setCorrectAnswerBorderColor() {
            //        let correctButton: UIButton?
            //        switch AnswerNumber {
            //        case 0: correctButton = btn1
            //        case 1: correctButton = btn2
            //        case 2: correctButton = btn3
            //        case 3: correctButton = btn4
            //        default: correctButton = nil
            //        }
            //        correctButton?.layer.borderColor = UIColor.green.cgColor
            //   }
            
//        }
        
    }
        
        //
        @IBAction func btn2Tapped(_ sender: UIButton) {
            //
            checkAnswer(button: sender, answerIndex: 1)
//            if let currentQuestion = currentQuestion {
//                   checkAnswer(button: sender, answerIndex: 0)
//                   if currentQuestion.answerOptions.first?.isCorrect == true {
//                       sender.layer.borderColor = UIColor.green.cgColor
//                   } else {
//                       sender.layer.borderColor = UIColor.red.cgColor
//                       if let correctIndex = currentQuestion.answerOptions.firstIndex(where: { $0.isCorrect }) {
//                           // Highlight the correct answer with a green border
//                           highlightCorrectAnswer(index: correctIndex)
//                       }
//                   }
//                   // Load the next question
//                   displayNextQuestion()
                //        if let currentQuestion = questions.first {
                //            checkAnswer(button: sender, answerIndex: 1)
                //                if currentQuestion.answerOptions.first?.isCorrect == true {
                //                    sender.layer.borderColor = UIColor.green.cgColor
                //                } else {
                //                    sender.layer.borderColor = UIColor.red.cgColor
                //
                //                }
                //                // Load the next question
                //                questions.removeFirst()
                //                displayNextQuestion()
                //            }
                //
                //        //        if AnswerNumber == 1 {
                //        //            sender.layer.borderColor = UIColor.green.cgColor
                //        //        } else {
                //        //            sender.layer.borderColor = UIColor.red.cgColor
                //        //            setCorrectAnswerBorderColor()
                //        //        }
                //        //        QNumber += 1
                //        //        PickQuestion()
                //    }
                
                //
//            }
        }
            
    @IBAction func btn3Tapped(_ sender: UIButton) {
        //
        checkAnswer(button: sender, answerIndex: 2)
//        if let currentQuestion = currentQuestion {
//            checkAnswer(button: sender, answerIndex: 0)
//            if currentQuestion.answerOptions.first?.isCorrect == true {
//                sender.layer.borderColor = UIColor.green.cgColor
//            } else {
//                sender.layer.borderColor = UIColor.red.cgColor
//                if let correctIndex = currentQuestion.answerOptions.firstIndex(where: { $0.isCorrect }) {
//                    // Highlight the correct answer with a green border
//                    highlightCorrectAnswer(index: correctIndex)
//                }
//            }
//            // Load the next question
//            displayNextQuestion()
            
            
            //        if let currentQuestion = questions.first {
            //            checkAnswer(button: sender, answerIndex: 2)
            //                if currentQuestion.answerOptions.first?.isCorrect == true {
            //                    sender.layer.borderColor = UIColor.green.cgColor
            //                } else {
            //                    sender.layer.borderColor = UIColor.red.cgColor
            //
            //                }
            //                // Load the next question
            //                questions.removeFirst()
            //                displayNextQuestion()
            //            }
            //
            //
            //        //        if AnswerNumber == 2 {
            //        //            sender.layer.borderColor = UIColor.green.cgColor
            //        //        } else {
            //        //            sender.layer.borderColor = UIColor.red.cgColor
            //        //            setCorrectAnswerBorderColor()
            //        //        }
            //        //        QNumber += 1
            //        //        PickQuestion()
//        }
    }
            @IBAction func btn4Tapped(_ sender: UIButton) {
                
                checkAnswer(button: sender, answerIndex: 3)
//                if let currentQuestion = currentQuestion {
//                    checkAnswer(button: sender, answerIndex: 0)
//                    if currentQuestion.answerOptions.first?.isCorrect == true {
//                        sender.layer.borderColor = UIColor.green.cgColor
//                    } else {
//                        sender.layer.borderColor = UIColor.red.cgColor
//                        if let correctIndex = currentQuestion.answerOptions.firstIndex(where: { $0.isCorrect }) {
//                            // Highlight the correct answer with a green border
//                            highlightCorrectAnswer(index: correctIndex)
//                        }
//                    }
//                    // Load the next question
//                    
//                    displayNextQuestion()
                    
                    //        if let currentQuestion = questions.first {
                    //            checkAnswer(button: sender, answerIndex: 3)
                    //                if currentQuestion.answerOptions.first?.isCorrect == true {
                    //                    sender.layer.borderColor = UIColor.green.cgColor
                    //                } else {
                    //                    sender.layer.borderColor = UIColor.red.cgColor
                    //
                    //
                    //                }
                    //                // Load the next question
                    //                questions.removeFirst()
                    //                displayNextQuestion()
                    //            }
                    //
                    //
                    //        //        if AnswerNumber == 3 {
                    //        //            sender.layer.borderColor = UIColor.green.cgColor
                    //        //        } else {
                    //        //            sender.layer.borderColor = UIColor.red.cgColor
                    //        //            setCorrectAnswerBorderColor()
                    //        //        }
                    //        //        QNumber += 1
                    //        //        PickQuestion()
                    //        //    }
                    //    }
                    
//                }
            }
            
}

