//
//  VC5.swift
//  somprazApp
//
//  Created by digiLATERAL on 11/10/23.
//

import UIKit
import Foundation

class QuesAnsVC: UIViewController {
    
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var ques4IV: UIImageView!
    @IBOutlet weak var topicIV: UIImageView!
    @IBOutlet weak var quesLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var stackView2: UIStackView!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var AlertImageView: UIImageView!
    @IBOutlet weak var drNameScorelbl: UILabel!
    @IBOutlet weak var MainAlertView: UIView!
    
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
    var remainingTime = 60 // Adjust the initial time as needed
    var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "" // Set an empty title
        // or
        self.navigationItem.title = nil
        MainAlertView.isHidden = true
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
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.MainAlertView.isHidden = true
            self.timer?.invalidate()
            self.timer = nil
        }
        
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
                    self?.startTimer()
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
            self.displayNoQuestionAlert()
        }
    }
    
    func displayNoQuestionAlert() {
        self.showAlertwithImage(id: "completed")
        self.submitScore()
    }
    
    
    func updateSelectedCategoryQuestionList() {
        // Filter questions based on the selected category
        arrSelectedCategoryQuestion = [QuizModelElement]()
        arrSelectedCategoryQuestion = arrAllQuestions.filter { $0.category == self.selectedCategory }
        
        if arrSelectedCategoryQuestion.isEmpty {
            print("No questions found for category: \(self.selectedCategory)")
            displayNoQuestionAlert()
        } else {
            self.updateCurrentQuestion() // Update the UI with the selected question
        }
    }
    
    
    func displayQuestion() {
        DispatchQueue.main.async {
            // Start the timer when the ready for display question
            if let currentQuestion = self.currentQuestion {
                self.displayedQuestionsID.append(currentQuestion.id)
                for i in 0..<self.arrSelectedCategoryQuestion.count {
                    if currentQuestion.id == self.arrSelectedCategoryQuestion[i].id {
                        self.arrSelectedCategoryQuestion.remove(at: i)
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
            
            DispatchQueue.main.async {
                // Time's up, create and present the custom alert view controller
                self.timer?.invalidate() // Stop the timer
                self.timer = nil
                
                print(self.timer)
                self.submitScore() // Submit score
                self.showAlertwithImage(id: "timeout")
                
            }
        }
    }
    
    func showAlertwithImage(id: String) {
        self.drNameScorelbl.text = "Dr \(self.selectedDoctorName), your score is \(score) points"
        self.MainAlertView.isHidden = false
        
        // Set the image based on the provided 'id'
        if id == "timeout" {
            AlertImageView.image = UIImage(named: "Timeout4")
        } else if id == "completed" {
            AlertImageView.image = UIImage(named: "QuizCompleted")
            
            // Stop the timer if it's running
            self.timer?.invalidate()
            self.timer = nil
        }
        
        // Use a Dispatch Queue to navigate to VC6 after 4 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.MainAlertView.isHidden = true
            
            // Create an instance of VC6
            let vc6 = self.storyboard?.instantiateViewController(withIdentifier: "LeaderBoardVC") as! LeaderBoardVC
            vc6.selectedDoctorID = self.selectedDoctorID
            vc6.selectedDoctorName = self.selectedDoctorName
            vc6.selectedCategory = self.selectedCategory
            vc6.score = self.score
            // Push VC6 onto the navigation stack
            self.navigationController?.pushViewController(vc6, animated: true)
        }
    }
    
    
    
    //            post api to save tottals points ,categoryname and userid
    //            api = https://quizapi-omsn.onrender.com/api/submit/score
    
    
    func submitScore() {
        // Define the URL for the API
        let apiUrl = "https://quizapi-omsn.onrender.com/api/submit/score"
        
        // Define the JSON data to be sent in the request
        let json: [String: Any] = [
            "totalPoints": score,
            "categoryName": selectedCategory,
            "userId": selectedDoctorID
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json)
            
            // Create the URLRequest
            var request = URLRequest(url: URL(string: apiUrl)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            // Create a URLSession task for the request
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    // Handle the error, e.g., show an alert
                } else if let data = data {
                    // Handle the response data, if needed
                    print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                    
                    //            post api to save tottals points ,categoryname and userid
                    //            api = https://quizapi-omsn.onrender.com/api/submit/score
                }
            }
            
            // Execute the task
            task.resume()
        } catch {
            print("Error serializing JSON: \(error)")
            // Handle the error, e.g., show an alert
        }
    }
    
    func calculateScore() -> Int {
        // Implement your logic to calculate the score based on user's answers
        // Return the score value
        return score // Replace with your score calculation
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
        //        checkAnswer(button: sender, answerIndex: sender.tag)
        if let currentQuestion = currentQuestion {
            if currentQuestion.answerOptions[sender.tag].isCorrect {
                // Correct answer selected
                // Increase the score by 10
                score += 10
            }
            // Update the score label with the current score
            scoreLbl.text = "Score: \(score)"
            checkAnswer(button: sender, answerIndex: sender.tag)
        }
    }
    
}

extension QuesAnsVC {
    
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

