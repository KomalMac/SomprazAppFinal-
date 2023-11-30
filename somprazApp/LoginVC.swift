//
//  ViewController.swift
//  somprazApp
//
//  Created by digiLATERAL on 09/10/23.
//

import UIKit



class LoginVC: UIViewController {
    
    @IBOutlet weak var userLoginLbl: UILabel!
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var employeeTF: UITextField!
    @IBOutlet weak var passswordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgotLbl: UILabel!
    @IBOutlet weak var somprazLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.layer.cornerRadius = 30
        
        employeeTF.delegate = self
        passswordTF.delegate = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        // Check if both text fields are filled
        if let enterDocNameText = employeeTF.text, !enterDocNameText.isEmpty,
           let placeText = passswordTF.text, !placeText.isEmpty {
            // Text fields are not empty, proceed to the next screen
            postMRData() 
        } else {
            // Display an alert if either or both text fields are empty
            let alert = UIAlertController(title: "Validation Error", message: "Please fill in both text fields.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func postMRData() {
        guard let url = URL(string: "https://quizapi-omsn.onrender.com/api/login-mr") else {
            return
        }

        let MRName = employeeTF.text ?? ""
        let password = passswordTF.text ?? ""

        let bodyParameters: [String: Any] = [
            "MRID": MRName,
            "PASSWORD": password
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: bodyParameters, options: .prettyPrinted)

            // Print the raw JSON data before attempting to decode
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Request JSON: \(jsonString)")
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Network Error: \(error)")
                    // Handle network error (e.g., show an alert to the user)
                    return
                }

                if let data = data {
                    // Print the raw JSON data received from the API
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Received JSON: \(jsonString)")
                    }

                    do {
                        let decoder = JSONDecoder()
                        let mrInsert = try decoder.decode(SelectMRModel.self, from: data)

                        DispatchQueue.main.async {
                            // Print the decoded data
                            print("API Result Before Navigation: \(mrInsert)")

                            let VC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                            VC.selectedMRID = mrInsert.MRID
                            self.navigationController?.pushViewController(VC, animated: true)
                        }
                    } catch let decodingError {
                        print("Error decoding JSON data: \(decodingError)")
                        // Handle decoding error (e.g., show an alert to the user)
                    }
                }
            }
            task.resume()
        } catch {
            print("Error creating JSON data: \(error)")
            // Handle JSON serialization error
        }
    }

    
    
}
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == employeeTF {
            passswordTF.becomeFirstResponder() // Move focus to the password field
        } else if textField == passswordTF {
            textField.resignFirstResponder() // Hide the keyboard
        }
        return true
    }
}
