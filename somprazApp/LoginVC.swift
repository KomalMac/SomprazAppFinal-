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
        // Check if the text fields are empty
        if let employeeText = employeeTF.text, let passwordText = passswordTF.text, !employeeText.isEmpty, !passwordText.isEmpty {
            // Check if the text fields contain the expected values
            //            if employeeText == "MR@gmail.com" && passwordText == "pass" {
            if employeeText == "a" && passwordText == "a" {
                
                // Text fields match the expected values, proceed to the next screen
                let VC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(VC, animated: true)
            } else {
                // Display an alert if the provided credentials don't match
                let alert = UIAlertController(title: "Login Error", message: "ID and password don't match.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            // Display an alert if either or both text fields are empty
            let alert = UIAlertController(title: "Validation Error", message: "Please fill in both Employee and Password fields.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
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
