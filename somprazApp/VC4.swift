import UIKit

class VC4: UIViewController {
    
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var quesInMinImgView: UIImageView!
    
    
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var astroBtn: UIButton!
    @IBOutlet weak var entrtnBtn: UIButton!
    @IBOutlet weak var historyBtn: UIButton!
    
    
    @IBOutlet weak var stackView2: UIStackView!
    @IBOutlet weak var scienceBtn: UIButton!
    @IBOutlet weak var literBtn: UIButton!
    @IBOutlet weak var geoBtn: UIButton!
    
    
    @IBOutlet weak var stackView3: UIStackView!
    @IBOutlet weak var wildBtn: UIButton!
    @IBOutlet weak var techBtn: UIButton!
    @IBOutlet weak var mathsBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var intTag = 0
        
        entrtnBtn.setBackgroundImage(UIImage(named: "EntertainmentYellow"), for: .selected)
        astroBtn.setBackgroundImage(UIImage(named: "AstronomyYellow"), for: .selected)
        historyBtn.setBackgroundImage(UIImage(named: "HistoryYellow"), for: .selected)
        
        scienceBtn.setBackgroundImage(UIImage(named: "Science Yellow"), for: .selected)
        literBtn.setBackgroundImage(UIImage(named: "Literature Yellow"), for: .selected)
        geoBtn.setBackgroundImage(UIImage(named: "Geography Yellow"), for: .selected)
        
        wildBtn.setBackgroundImage(UIImage(named: "Wildlife Yellow"), for: .selected)
        techBtn.setBackgroundImage(UIImage(named: "Technology Yellow"), for: .selected)
        mathsBtn.setBackgroundImage(UIImage(named: "Mathematics Yellow"), for: .selected)
        
        //        // Add tap gesture recognizer to entertnIV
        //              let gesture1 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        //              entertnIV.isUserInteractionEnabled = true
        //              entertnIV.addGestureRecognizer(gesture1)
        //        
        //        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        //        astroIV.isUserInteractionEnabled = true
        //        astroIV.addGestureRecognizer(tapGesture2)
        
        //        entrtnBtn.backgroundImage(UIImage(named: "EntertainmentWhite"), for: .normal)
        
        //        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        //        historyIV.isUserInteractionEnabled = true
        //        historyIV.addGestureRecognizer(tapGesture3)
        //        
        // Add similar tap gestures for other image views
    }
    @IBAction func onBtnTapped(_ sender: UIButton) {
        
        var intTag = ""
        //        var selectedImageName: String = ""
        var selectedCategory = ""
        
        if sender.tag == 1 {
            entrtnBtn.isSelected = true
            astroBtn.isSelected = false
            historyBtn.isSelected = false
            scienceBtn.isSelected = false
            literBtn.isSelected = false
            geoBtn.isSelected = false
            wildBtn.isSelected = false
            techBtn.isSelected = false
            mathsBtn.isSelected = false
            intTag = "EntertainmentYellow"
            
        } else if sender.tag == 2 {
            entrtnBtn.isSelected = false
            astroBtn.isSelected = true
            historyBtn.isSelected = false
            scienceBtn.isSelected = false
            literBtn.isSelected = false
            geoBtn.isSelected = false
            wildBtn.isSelected = false
            techBtn.isSelected = false
            mathsBtn.isSelected = false
            intTag = "AstronomyYellow"
            
            //
        } else if sender.tag == 3 {
            entrtnBtn.isSelected = false
            astroBtn.isSelected = false
            historyBtn.isSelected = true
            scienceBtn.isSelected = false
            literBtn.isSelected = false
            geoBtn.isSelected = false
            wildBtn.isSelected = false
            techBtn.isSelected = false
            mathsBtn.isSelected = false
            intTag = "HistoryYellow"
            
        } else if sender.tag == 4 {
            entrtnBtn.isSelected = false
            astroBtn.isSelected = false
            historyBtn.isSelected = false
            scienceBtn.isSelected = true
            literBtn.isSelected = false
            geoBtn.isSelected = false
            wildBtn.isSelected = false
            techBtn.isSelected = false
            mathsBtn.isSelected = false
            intTag = "Science Yellow"
            
        } else if sender.tag == 5 {
            entrtnBtn.isSelected = false
            astroBtn.isSelected = false
            historyBtn.isSelected = false
            scienceBtn.isSelected = false
            literBtn.isSelected = true
            geoBtn.isSelected = false
            wildBtn.isSelected = false
            techBtn.isSelected = false
            mathsBtn.isSelected = false
            intTag = "Literature Yellow"
            
        } else if sender.tag == 6 {
            entrtnBtn.isSelected = false
            astroBtn.isSelected = false
            historyBtn.isSelected = false
            scienceBtn.isSelected = false
            literBtn.isSelected = false
            geoBtn.isSelected = true
            wildBtn.isSelected = false
            techBtn.isSelected = false
            mathsBtn.isSelected = false
            intTag = "Geography Yellow"
            
        } else if sender.tag == 7 {
            entrtnBtn.isSelected = false
            astroBtn.isSelected = false
            historyBtn.isSelected = false
            scienceBtn.isSelected = false
            literBtn.isSelected = false
            geoBtn.isSelected = false
            wildBtn.isSelected = true
            techBtn.isSelected = false
            mathsBtn.isSelected = false
            intTag = "Wildlife Yellow"
            
        } else if sender.tag == 8 {
            entrtnBtn.isSelected = false
            astroBtn.isSelected = false
            historyBtn.isSelected = false
            scienceBtn.isSelected = false
            literBtn.isSelected = false
            geoBtn.isSelected = false
            wildBtn.isSelected = false
            techBtn.isSelected = true
            mathsBtn.isSelected = false
            intTag = "Technology Yellow"
            
        } else if sender.tag == 9 {
            entrtnBtn.isSelected = false
            astroBtn.isSelected = false
            historyBtn.isSelected = false
            scienceBtn.isSelected = false
            literBtn.isSelected = false
            geoBtn.isSelected = false
            wildBtn.isSelected = false
            techBtn.isSelected = false
            mathsBtn.isSelected = true
            intTag = "Mathematics Yellow"
            
        }
        
        // Determine the selected category based on the button's tag
           switch sender.tag {
           case 1:
               selectedCategory = "Entertainment"
           case 2:
               selectedCategory = "Astronomy"
           case 3:
               selectedCategory = "History"
           case 4:
               selectedCategory = "Science"
           case 5:
               selectedCategory = "Literature"
           case 6:
               selectedCategory = "Geography"
           case 7:
               selectedCategory = "Wildlife"
           case 8:
               selectedCategory = "Technology"
           case 9:
               selectedCategory = "Mathematics"
           
           default:
               break
           }
        
        print("Selected image identifier: \(intTag)")
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "VC5") as! VC5
        VC.Id = intTag
        VC.selectedCategory = selectedCategory
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    
    
}