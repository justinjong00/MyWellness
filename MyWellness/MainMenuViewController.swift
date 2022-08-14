//
//  MainMenuViewController.swift
//  MyWellness
//
//  Created by Justin Ong on 8/3/22.
//

import UIKit
import Firebase

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var dateText: UILabel!
    var username = ""
    var todayDate = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " MM.dd.yyyy"
        dateText.text = "Today is " + dateFormatter.string(from: todayDate)
        
    }
    
    @IBAction func goToMood(_ sender: Any) {
        self.performSegue(withIdentifier: "toMood", sender: nil)
    }
    
    
    @IBAction func goToHabits(_ sender: Any) {
        self.performSegue(withIdentifier: "toHabits", sender: nil)
    }
    
    
    
    @IBAction func logOut(_ sender: Any) {
        try? Auth.auth().signOut()
        self.performSegue(withIdentifier: "toLogIn", sender: nil)
    }
    
    @IBAction func goToArchive(_ sender: Any) {
        self.performSegue(withIdentifier: "toArchive", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHabits" {
            let destination = segue.destination as! HabitsViewController
            destination.username = self.username
            
        }
        if segue.identifier == "toMood" {
            let destination = segue.destination as! MoodViewController
            destination.username = self.username
        }
        if segue.identifier == "toArchive" {
            let destination = segue.destination as! ArchiveViewController
            destination.username = self.username
        }
    } // prepare
    
    
    

}
