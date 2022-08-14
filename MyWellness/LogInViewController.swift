//
//  LogInViewController.swift
//  MyWellness
//
//  Created by Justin Ong on 8/3/22.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    public var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let currentUser = Auth.auth().currentUser
        
        if currentUser != nil {
            self.performSegue(withIdentifier: "toMainMenu", sender: nil)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: Any) {
        if (emailField.text! != "" && passwordField.text! != "") {
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) {(authdata, error) in
                if error != nil {
                    self.sendAlert(titleSent: "Error!", messageSent: error?.localizedDescription ?? "Error")
                }else {
                    self.performSegue(withIdentifier: "toMainMenu", sender: nil)
                }
            
            }
        }
        else {
           sendAlert(titleSent: "Error", messageSent: "Username or Password is missing")
        }
    } // signUp
    
    @IBAction func logIn(_ sender: Any) {
        if (emailField.text! != "" && passwordField.text! != "") {
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (authdata, error) in
                if error != nil {

                        self.sendAlert(titleSent: "Error!", messageSent: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toMainMenu", sender: nil)
                }
            }
        }
        else {
            sendAlert(titleSent: "Error", messageSent: "Username or Password is missing")
        }
    } // logIn
    
    
    func sendAlert(titleSent : String, messageSent : String) {
        let alert = UIAlertController(title: titleSent, message: messageSent, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }//sendAlert
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toMainMenu") {
            let destination = segue.destination as! MainMenuViewController
            destination.username = emailField.text!
        }
    } // prepare
    
    


}
