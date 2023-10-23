import UIKit
import iOSDropDown

class VC1: UIViewController {
    
    @IBOutlet weak var enterDocNameTF: UITextField!
    @IBOutlet weak var placeTF: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var orLbl: UILabel!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var selectDocName: DropDown!
    @IBOutlet weak var somprazLbl: UILabel!
    
    var doctorList = [String]()
    
    //    let dropDown = DropDown()
    
//        let dropDownValues = ["DR A", "DR B", "DR C", "DR D", "DR E"]
//     Define an empty array to store the fetched values
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBtn.layer.cornerRadius = 30
        submitBtn.layer.cornerRadius = 30
        
        enterDocNameTF.delegate = self
        placeTF.delegate = self
        
        // Configure the DropDown to enable searching
        selectDocName.isSearchEnable = true
        
        // Prevent the keyboard from showing up when tapping on selectDocName
        selectDocName.inputView = UIView()
        
        getDoctorList()
//                Assign the data source to the selectDocNameTF (which is now a DropDown)
//        selectDocName.optionArray = ["DR A", "DR B", "DR C", "DR D", "DR E"]
        
        
        selectDocName.didSelect{(selectedText , index ,id) in
            print("Selected item: \(selectedText) at index: \(index)")
            
            // Close the dropdown when an item is selected
            self.selectDocName.hideList()
            
            self.view.endEditing(true)
        }
    }
    
    func getDoctorList() {
    
        guard let url = URL(string: "https://quizapi-omsn.onrender.com/api/get/get-only-name-with-id") else {
                print("QUIZ ERROR OCCURRED")
                return
            }

            URLSession.shared.makeRequest(url: url, expecting: SelectDoctorModel.self) { [weak self] result in
                switch result {
                case .success(let doctors):
                    DispatchQueue.main.async {
                      
                        self?.doctorList = [String]()
                        for i in 0..<doctors.count {
                            let docObj = doctors[i]
                            if let name = docObj.doctorName {
                                let n = "Dr. " + name
                                self?.doctorList.append(n)
                            }
                        }
                        self?.selectDocName.optionArray = self?.doctorList ?? [String]()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        
    }
 
    @IBAction func addBtnTapped(_ sender: UIButton) {
        
        
        // Check if both text fields are filled
        if let enterDocNameText = enterDocNameTF.text, !enterDocNameText.isEmpty,
           let placeText = placeTF.text, !placeText.isEmpty {
            // Text fields are not empty, proceed to the next screen
            let VC = storyboard?.instantiateViewController(withIdentifier: "VC4") as! VC4
            self.navigationController?.pushViewController(VC, animated: true)
        } else {
            // Display an alert if either or both text fields are empty
            let alert = UIAlertController(title: "Validation Error", message: "Please fill in both text fields.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        guard let url = URL(string: "https://quizapi-omsn.onrender.com/api/user") else {
                    return
                }

                // Prepare the data to send in the request body
                let doctorName = enterDocNameTF.text ?? ""
                let state = placeTF.text ?? ""
        
        // Create a dictionary with a single key "data"
            let bodyParameters: [String: Any] = [
                
                    "doctorName": doctorName,
                    "state": state
                
            ]

                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: bodyParameters, options: .prettyPrinted)

                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.httpBody = jsonData

                    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        if let error = error {
                            print("Error: \(error)")
                        } else if let data = data {
                            if let jsonString = String(data: data, encoding: .utf8) {
                                print("Response: \(jsonString)")
                            }
                        }
                    }
                    task.resume()
                } catch {
                    print("Error creating JSON data: \(error)")
                }
        
        
        
        
    }
    
    
    //        // Handle the "Add" button action
    //        let VC = storyboard?.instantiateViewController(withIdentifier: "VC4") as! VC4
    //        self.navigationController?.pushViewController(VC, animated: true)
    
//
    @IBAction func docNameDrpDownTapped(_ sender: DropDown) {
//        if let apiUrl = URL(string: "https://quizapi-omsn.onrender.com/api/get/docter/name") {
//            let session = URLSession.shared
//            let task = session.dataTask(with: apiUrl) { (data, response, error) in
//                if let error = error {
//                    print("Error: \(error)")
//                    // Handle the error, such as displaying an alert
//                    return
//                }
//
//                if let data = data {
//                    do {
//                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [String] {
//                            self.dropDownValues = jsonArray
//                            print(self.dropDownValues)
//                        }
//                    } catch {
//                        print("Error parsing JSON: \(error)")
//                    }
//                }
//            }
//            task.resume()
//        } else {
//            print("Invalid URL")
//        }
    }


    // Add an action for the Submit button
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        // Check if a selection has been made in the dropdown
        if let selectedDoctorName = selectDocName.text, !selectedDoctorName.isEmpty {
            // Proceed to the next screen
            if let VC = self.storyboard?.instantiateViewController(withIdentifier: "VC4") as? VC4 {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        } else {
            // Display an alert if the dropdown is not selected
            let alert = UIAlertController(title: "Validation Error", message: "Please select Doctor's Name.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
extension VC1: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == enterDocNameTF {
            placeTF.becomeFirstResponder() // Move focus to the placeTF
        } else if textField == placeTF {
            textField.resignFirstResponder() // Hide the keyboard
        }
        return true
    }
}


