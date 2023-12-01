//
//  QuesOptionVC.swift
//  somprazApp
//
//  Created by digiLATERAL on 28/11/23.
//

import UIKit

class QuesOptionVC: UIViewController {

    @IBOutlet weak var ques4Btn: UIButton!
    
    @IBOutlet weak var quesMultipleBtn: UIButton!
    
    var selectedDoctorID = ""
    var selectedDoctorName = ""
    var selectedMRID = ""
    
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
    var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a custom back button
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "backImage1"), for: .normal) // Set your custom back button image
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        // Add the custom back button to the view
        view.addSubview(backButton)
        // Position the custom back button as needed
        backButton.frame = CGRect(x: 16, y: 40, width: 30, height: 30) // Adjust the frame as needed
        
        view.bringSubviewToFront(backButton)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func quiz1() {
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
                    let VC = self?.storyboard?.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
                    VC.selectedMRID = self?.selectedMRID ?? ""
                    self?.navigationController?.pushViewController(VC, animated: true)
                }
            case .failure(let error):
                print(error)
                print("playAgain")
            }
            //             Dismiss the loading indicator when the network request is complete
            self?.stopLoader(loader: loader)
        }
    }
    
    
    func quiz2() {
        guard let url = URL(string: "https://backup-quiz-server.onrender.com/api/questionfour?category=\(selectedCategory)") else {
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
                    let VC = self?.storyboard?.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
                    VC.selectedMRID = self?.selectedMRID ?? ""
                    self?.navigationController?.pushViewController(VC, animated: true)
                }
            case .failure(let error):
                print(error)
                print("playAgain")
            }
            //             Dismiss the loading indicator when the network request is complete
            self?.stopLoader(loader: loader)
        }
    }
    
    // Function to start the timer
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
//            timerLbl.text = String(remainingTime)
        } else {
            
            DispatchQueue.main.async {
                // Time's up, create and present the custom alert view controller
                self.timer?.invalidate() // Stop the timer
                self.timer = nil
                
                print(self.timer)
                self.submitScore() // Submit score
//                self.showAlertwithImage(id: "timeout")
                
            }
        }
    }
    
 
    
    func updateSelectedCategoryQuestionList() {
        // Filter questions based on the selected category
        arrSelectedCategoryQuestion = [QuizModelElement]()
        arrSelectedCategoryQuestion = arrAllQuestions.filter { $0.category == self.selectedCategory }
        
        if arrSelectedCategoryQuestion.isEmpty {
            print("No questions found for category: \(self.selectedCategory)")
//            displayNoQuestionAlert()
        } else {
            self.updateCurrentQuestion() // Update the UI with the selected question
        }
    }
    
    func displayNoQuestionAlert() {
//        self.showAlertwithImage(id: "completed")
        self.submitScore()
    }
//    
//    func displayQuestion() {
//        DispatchQueue.main.async {
//            // Start the timer when the ready for display question
//            if let currentQuestion = self.currentQuestion {
//                self.displayedQuestionsID.append(currentQuestion.id)
//                for i in 0..<self.arrSelectedCategoryQuestion.count {
//                    if currentQuestion.id == self.arrSelectedCategoryQuestion[i].id {
//                        self.arrSelectedCategoryQuestion.remove(at: i)
//                        break
//                    }
//                }
////                self.quesLbl.text = currentQuestion.question
//                if currentQuestion.answerOptions.count >= 4 {
//                    self.btn1.setTitle(currentQuestion.answerOptions[0].answer, for: .normal)
//                    self.btn2.setTitle(currentQuestion.answerOptions[1].answer, for: .normal)
//                    self.btn3.setTitle(currentQuestion.answerOptions[2].answer, for: .normal)
//                    self.btn4.setTitle(currentQuestion.answerOptions[3].answer, for: .normal)
//                }
//            }
//        }
//    }

    
    
    func updateCurrentQuestion() {
        print("arrSelectedCategoryQuestion count is \(arrSelectedCategoryQuestion.count)")
        if !arrSelectedCategoryQuestion.isEmpty {
            
            for i in 0..<arrSelectedCategoryQuestion.count {
                let quest = arrSelectedCategoryQuestion[i]
                if !displayedQuestionsID.contains(quest.id) {
                    currentQuestion = quest
//                    displayQuestion()
                    break
                }
            }
        } else {
            self.displayNoQuestionAlert()
        }
    }
    
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
    

    @IBAction func ques4BtnTapped(_ sender: UIButton) {
        
        quiz2()
        
     
    }
    
    @IBAction func quesMultipleBtnTapped(_ sender: UIButton) {
        
        quiz1()
        

    }
    
}

extension QuesOptionVC {
    
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
