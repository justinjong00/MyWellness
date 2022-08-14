//
//  HabitsViewController.swift
//  MyWellness
//
//  Created by Justin Ong on 8/3/22.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore


class HabitsViewController: UIViewController {
    
    var username = ""
    @IBOutlet weak var sleepButton: UIButton!
    @IBOutlet weak var nutritionButton: UIButton!
    @IBOutlet weak var exerciseButton: UIButton!
    @IBOutlet weak var meditationButton: UIButton!
    @IBOutlet weak var cardioButton: UIButton!
    @IBOutlet weak var miscButton: UIButton!
    let db = Firestore.firestore()
    var date = ""
    var sleep = false
    var nutrition = false
    var exercise = false
    var meditation = false
    var cardio = false
    var misc = false

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
            self.exercise = dict["exercise", default: false] as! Bool
            self.sleep = dict["sleep", default: false] as! Bool
            self.nutrition = dict["nutrition", default: false] as! Bool
            self.meditation = dict["meditate", default: false] as! Bool
            self.cardio = dict["cardio", default: false] as! Bool
            self.misc = dict["misc", default: false] as! Bool
            
            if (self.exercise == true) {
                self.exerciseButton.backgroundColor = UIColor.lightGray
            } else {
                self.exerciseButton.backgroundColor = UIColor.clear
            }
            if (self.sleep == true) {
                self.sleepButton.backgroundColor = UIColor.lightGray
            } else {
                self.sleepButton.backgroundColor = UIColor.clear
            }
            if (self.nutrition == true) {
                self.nutritionButton.backgroundColor = UIColor.lightGray
            } else {
                self.nutritionButton.backgroundColor = UIColor.clear
            }
            if (self.meditation == true) {
                self.meditationButton.backgroundColor = UIColor.lightGray
            } else {
                self.meditationButton.backgroundColor = UIColor.clear
            }
            if (self.cardio == true) {
                self.cardioButton.backgroundColor = UIColor.lightGray
            } else {
                self.cardioButton.backgroundColor = UIColor.clear
            }
            if (self.misc == true) {
                self.miscButton.backgroundColor = UIColor.lightGray
            } else {
                self.miscButton.backgroundColor = UIColor.clear
            }
        })



    }
    @IBAction func nutritionHabit(_ sender: Any) {
        if nutritionButton.backgroundColor == UIColor.clear {
            nutritionButton.backgroundColor = UIColor.lightGray
            nutrition = true
        }
        else if nutritionButton.backgroundColor == UIColor.lightGray {
            nutritionButton.backgroundColor = UIColor.clear
            nutrition = false
        }
    }
    //
    @IBAction func sleepHabit(_ sender: Any) {
        if sleepButton.backgroundColor == UIColor.clear {
            sleepButton.backgroundColor = UIColor.lightGray
            sleep = true
        }
        else if sleepButton.backgroundColor == UIColor.lightGray {
            sleepButton.backgroundColor = UIColor.clear
            sleep = false
        }
    }

        
        
        
    @IBAction func meditationHabit(_ sender: Any) {
        if meditationButton.backgroundColor == UIColor.clear {
            meditationButton.backgroundColor = UIColor.lightGray
            meditation = true
        }
        else if meditationButton.backgroundColor == UIColor.lightGray {
            meditationButton.backgroundColor = UIColor.clear
            meditation = false
        }
    }
    

    
    @IBAction func exerciseHabit(_ sender: Any) {
        if exerciseButton.backgroundColor == UIColor.clear {
            exerciseButton.backgroundColor = UIColor.lightGray
            exercise = true
        }
        else if exerciseButton.backgroundColor == UIColor.lightGray {
            exerciseButton.backgroundColor = UIColor.clear
            exercise = false
        }
    }
    
    
    @IBAction func cardioHabit(_ sender: Any) {
        if cardioButton.backgroundColor == UIColor.clear {
            cardioButton.backgroundColor = UIColor.lightGray
            cardio = true
        }
        else if cardioButton.backgroundColor == UIColor.lightGray {
            cardioButton.backgroundColor = UIColor.clear
            cardio = false
        }
    }
    
    @IBAction func miscHabit(_ sender: Any) {
        if miscButton.backgroundColor == UIColor.clear {
            miscButton.backgroundColor = UIColor.lightGray
            misc = true
        }
        else if miscButton.backgroundColor == UIColor.lightGray {
            miscButton.backgroundColor = UIColor.clear
            misc = false
        }
    }
    
    
    @IBAction func saveHabit(_ sender: Any) {
        db.collection("\(username)").document("\(date)").setData(["sleep": sleep], merge: true ) { err in
            if let err = err {
                print("Error writing document: \(err)")
            }
        } // db
    
        db.collection("\(username)").document("\(date)").setData(["misc": misc], merge: true ) { err in
            if let err = err {
                print("Error writing document: \(err)")
            }
        } // db
        
        db.collection("\(username)").document("\(date)").setData(["cardio": cardio], merge: true ) { err in
            if let err = err {
                print("Error writing document: \(err)")
            }
        } // db
        
        db.collection("\(username)").document("\(date)").setData(["nutrition": nutrition], merge: true ) { err in
            if let err = err {
                print("Error writing document: \(err)")
            }
        } // db
        
        db.collection("\(username)").document("\(date)").setData(["meditation": meditation], merge: true ) { err in
            if let err = err {
                print("Error writing document: \(err)")
            }
        } // db
        
        db.collection("\(username)").document("\(date)").setData(["exercise": exercise], merge: true ) { err in
            if let err = err {
                print("Error writing document: \(err)")
            }
        } // db
        
        self.dismiss(animated: true, completion: nil)
    }
    
   

}
