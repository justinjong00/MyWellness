//
//  ArchiveViewController.swift
//  MyWellness
//
//  Created by Justin Ong on 8/13/22.
//

import UIKit
import Firebase

class ArchiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    
    
    @IBOutlet weak var tableView: UITableView!
    var date = ""
    var username = ""
    var documentIdArray = [String]()
    var moodArray = [Int]()
    var happinessArray = [Int]()
    var sleepArray = [Bool]()
    var exerciseArray = [Bool]()
    var nutritionArray = [Bool]()
    var cardioArray = [Bool]()
    var meditationArray = [Bool]()
    var miscArray = [Bool]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " MM.dd.yyyy"
        date = dateFormatter.string(from: Date())

        getDataFromFirestore()
    }
    
    func getDataFromFirestore() {
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("\(username)").addSnapshotListener {(snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if (snapshot != nil && !(snapshot!.isEmpty)) {
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    self.moodArray.removeAll(keepingCapacity: false)
                    self.happinessArray.removeAll(keepingCapacity: false)
                    self.sleepArray.removeAll(keepingCapacity: false)
                    self.meditationArray.removeAll(keepingCapacity: false)
                    self.exerciseArray.removeAll(keepingCapacity: false)
                    self.nutritionArray.removeAll(keepingCapacity: false)
                    self.cardioArray.removeAll(keepingCapacity: false)
                    self.miscArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents{
                        let documentId = document.documentID
                        self.documentIdArray.append(documentId)
                        
                        if let mood = document.get("mood") as? Int {
                            self.moodArray.append(mood)
                        } else {
                            self.moodArray.append(-1)
                        }
                        if let happiness = document.get("happiness") as? Int {
                            self.happinessArray.append(happiness)
                        } else {
                            self.happinessArray.append(-1)
                        }
                        
                        if let sleep = document.get("sleep") as? Bool {
                            self.sleepArray.append(sleep)
                        } else {
                            self.sleepArray.append(false)
                        }
                        if let exercise = document.get("exercise") as? Bool {
                            self.exerciseArray.append(exercise)
                        } else {
                            self.exerciseArray.append(false)
                        }
                        if let nutrition = document.get("nutrition") as? Bool {
                            self.nutritionArray.append(nutrition)
                        } else {
                            self.nutritionArray.append(false)
                        }
                        if let meditation = document.get("meditation") as? Bool {
                            self.meditationArray.append(meditation)
                        } else {
                            self.meditationArray.append(false)
                        }
                        if let cardio = document.get("cardio") as? Bool {
                            self.cardioArray.append(cardio)
                        } else {
                            self.cardioArray.append(false)
                        }
                        if let misc = document.get("misc") as? Bool {
                            self.miscArray.append(misc)
                        } else {
                            self.miscArray.append(false)
                        }
                    } // for
                    self.tableView.reloadData()
                    
                } // if
            } //else
        } // firestore
    } // getDataFromFirestore
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentIdArray.count
        
    } // numberOfRowsInSection
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArchiveCell", for: indexPath) as! ArchiveCell
        
        cell.date.text = "Date: \(documentIdArray[indexPath.row])"
        
        let mood = moodArray[indexPath.row]
        if (mood==0) {
            cell.mood.image = UIImage(named: "sad-1")
        } else if (mood==1) {
            cell.mood.image = UIImage(named: "neutral-1")
            cell.mood.sizeToFit()
        } else if (mood==2) {
            cell.mood.image = UIImage(named: "happy-1")
            cell.mood.sizeToFit()
        } else if (mood == -1) {
            cell.mood.image = UIImage(named: "empty")
        }
        
        let happiness = happinessArray[indexPath.row]
        cell.happinessLevel.text = "Happiness Level: \(happiness)"
    
        
        let meditation = meditationArray[indexPath.row]
        let sleep = sleepArray[indexPath.row]
        let nutrition = nutritionArray[indexPath.row]
        let exercise = exerciseArray[indexPath.row]
        let cardio = cardioArray[indexPath.row]
        let misc = miscArray[indexPath.row]
        
        if (meditation==false) {
            cell.meditation.image = UIImage(named: "empty")
        } else {
            cell.meditation.image = UIImage(named: "meditation")
        }
        if (sleep==false) {
            cell.sleep.image = UIImage(named: "empty")
        } else {
            cell.sleep.image = UIImage(named: "sleep")
        }
        if (nutrition==false) {
            cell.nutrition.image = UIImage(named: "empty")
        } else {
            cell.nutrition.image = UIImage(named: "nutrition")
        }
        if (exercise==false) {
                cell.exercise.image = UIImage(named: "empty")
        } else {
            cell.exercise.image = UIImage(named: "workout")
        }
        if (cardio==false) {
            cell.cardio.image = UIImage(named: "empty")
        } else {
            cell.cardio.image = UIImage(named: "cardio")
        }
        if (misc==false) {
            cell.misc.image = UIImage(named: "empty")
        } else {
            cell.misc.image = UIImage(named: "misc")
        }
      
        return cell
        
    } // cellForRowAt
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200 //or whatever you need
    } // heightForRowAt

    
    
}
