//
//  MoodViewController.swift
//  MyWellness
//
//  Created by Justin Ong on 8/3/22.
//

import UIKit
import Firebase

class MoodViewController: UIViewController {
    

    @IBOutlet weak var happinessLabel: UILabel!
    @IBOutlet weak var happinessOutlet: UISlider!
    
    @IBOutlet weak var badOutlet: UIButton!
    @IBOutlet weak var okayOutlet: UIButton!
    @IBOutlet weak var goodOutlet: UIButton!
    var username = ""
    var moodSelected = -1
    let db = Firestore.firestore()
    var date = ""
    var hapLevel = -1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        happinessLabel.text = "~"
        
        badOutlet.backgroundColor = UIColor.clear
        okayOutlet.backgroundColor = UIColor.clear
        goodOutlet.backgroundColor = UIColor.clear
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " MM.dd.yyyy"
        date = dateFormatter.string(from: Date())
        
        let dateRef = db.collection("\(username)").document("\(date)")
        dateRef.getDocument(completion: { snapshot, error in
            if let err = error {
                print(err.localizedDescription)
            }
            guard let snap = snapshot else { return }
            guard let dict = snap.data() else { return }
            self.moodSelected = dict["mood", default: -1] as! Int
        
            if (self.moodSelected == 0) {
                self.badOutlet.backgroundColor = UIColor.lightGray
            }
            else if (self.moodSelected == 1) {
                self.okayOutlet.backgroundColor = UIColor.lightGray
            }
            else if (self.moodSelected == 2) {
                self.goodOutlet.backgroundColor = UIColor.lightGray
            }
            
            self.hapLevel = dict["happiness", default: -1] as! Int
            
            if (self.hapLevel != -1) {
                self.happinessLabel.text = String(self.hapLevel)
            }
            
        })
        
    
        
        
    }
    
    @IBAction func happinessLevel(_ sender: UISlider) {
        let value = sender.value
        let roundedVal = round(value)
        hapLevel = Int(roundedVal)
        happinessLabel.text = String(hapLevel)

    }
    
    @IBAction func badMood(_ sender: Any) {
        if badOutlet.backgroundColor == UIColor.clear {
            badOutlet.backgroundColor = UIColor.lightGray
            okayOutlet.backgroundColor = UIColor.clear
            goodOutlet.backgroundColor = UIColor.clear
            moodSelected = 0
        } else {
            badOutlet.backgroundColor = UIColor.clear
            moodSelected = -1
        }
    }
    
    @IBAction func okayMood(_ sender: Any) {
        if okayOutlet.backgroundColor == UIColor.clear {
            badOutlet.backgroundColor = UIColor.clear
            okayOutlet.backgroundColor = UIColor.lightGray
            goodOutlet.backgroundColor = UIColor.clear
            moodSelected = 1
        } else {
            okayOutlet.backgroundColor = UIColor.clear
            moodSelected = -1
        }
    }
    
    @IBAction func goodMood(_ sender: Any) {
        if goodOutlet.backgroundColor == UIColor.clear {
            badOutlet.backgroundColor = UIColor.clear
            okayOutlet.backgroundColor = UIColor.clear
            goodOutlet.backgroundColor = UIColor.lightGray
            moodSelected = 2
        } else {
            goodOutlet.backgroundColor = UIColor.clear
            moodSelected = -1
        }
    }
    
    
    @IBAction func saveMood(_ sender: Any) {
        db.collection("\(username)").document("\(date)").setData(["mood": moodSelected ], merge: true ) { err in
            if let err = err {
                print("Error writing document: \(err)")
            }
        } // db
        db.collection("\(username)").document("\(date)").setData(["happiness": hapLevel], merge: true ) { err in
            if let err = err {
                print("Error writing document: \(err)")
            }
        }
        
    
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
 

}
