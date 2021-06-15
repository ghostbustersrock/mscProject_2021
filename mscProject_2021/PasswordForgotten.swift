//
//  PasswordForgotten.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 10/06/21.
//

import UIKit
import RealmSwift

class PasswordForgotten: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var newPass: UITextField!
    @IBOutlet var repeatNewPass: UITextField!
    @IBOutlet var errorMsg: UILabel!
    
    @IBAction func saveNewPass(_ sender: Any) {
        
        if usernameField.text!.isEmpty || newPass.text!.isEmpty || repeatNewPass.text!.isEmpty {
            
            if usernameField.text!.isEmpty && newPass.text!.isEmpty && repeatNewPass.text!.isEmpty {
                errorMsg.text = "Fill in missing fields"
                usernameField.layer.borderColor = UIColor.red.cgColor
                usernameField.layer.borderWidth = 1
                newPass.layer.borderColor = UIColor.red.cgColor
                newPass.layer.borderWidth = 1
                repeatNewPass.layer.borderColor = UIColor.red.cgColor
                repeatNewPass.layer.borderWidth = 1
            }
            else if usernameField.text!.isEmpty {
                errorMsg.text = "Fill in username field"
                usernameField.layer.borderColor = UIColor.red.cgColor
                usernameField.layer.borderWidth = 1
                newPass.layer.borderColor = UIColor.clear.cgColor
                newPass.layer.borderWidth = 0
                repeatNewPass.layer.borderColor = UIColor.clear.cgColor
                repeatNewPass.layer.borderWidth = 0
            }
            else if newPass.text!.isEmpty {
                errorMsg.text = "Insert new password"
                usernameField.layer.borderColor = UIColor.clear.cgColor
                usernameField.layer.borderWidth = 0
                newPass.layer.borderColor = UIColor.red.cgColor
                newPass.layer.borderWidth = 1
                repeatNewPass.layer.borderColor = UIColor.clear.cgColor
                repeatNewPass.layer.borderWidth = 0
            }
            else {
                errorMsg.text = "Repeat new password"
                usernameField.layer.borderColor = UIColor.clear.cgColor
                usernameField.layer.borderWidth = 0
                newPass.layer.borderColor = UIColor.clear.cgColor
                newPass.layer.borderWidth = 0
                repeatNewPass.layer.borderColor = UIColor.red.cgColor
                repeatNewPass.layer.borderWidth = 1
            }
        }
        else if realm.objects(User.self).filter("username == %@", usernameField.text!).first?.username != usernameField.text {
            errorMsg.text = "No username matches yours"
            usernameField.layer.borderColor = UIColor.red.cgColor
            usernameField.layer.borderWidth = 1
        }
        else {
            if newPass.text!.count < 8 || newPass.text?.hasWhitespacesNewlines() == true {
                errorMsg.text = "Password doesn't match critera"
            }
            else if newPass.text != repeatNewPass.text {
                errorMsg.text = "Passwords don't match"
                newPass.layer.borderColor = UIColor.red.cgColor
                newPass.layer.borderWidth = 1
                repeatNewPass.layer.borderColor = UIColor.red.cgColor
                repeatNewPass.layer.borderWidth = 1
            }
            else {
                // MARK: Update database!!!
                errorMsg.text = "SUCCESS!!!"
                usernameField.layer.borderColor = UIColor.clear.cgColor
                usernameField.layer.borderWidth = 0
                newPass.layer.borderColor = UIColor.clear.cgColor
                newPass.layer.borderWidth = 0
                repeatNewPass.layer.borderColor = UIColor.clear.cgColor
                repeatNewPass.layer.borderWidth = 0
                
                // Make an alert saying everything was saved and then do an unwind segue to the homepage.
                let alertView = UIAlertController(title: "Success!", message: "\(usernameField.text!) you have successfully changed your password", preferredStyle: .actionSheet)

                let goHomeAction = UIAlertAction (title: "Go home", style: .default) { alertAction in
                    
                    let data = self.realm.objects(User.self).filter("username == %@", self.usernameField.text!).first
                    
                    try! self.realm.write {
                        data?.password = self.newPass.text
                    }
                    
                    // Just for sercurity purposes remove all values from the outlets used, whose values need to be saved.
                    self.usernameField.text = ""
                    self.newPass.text = ""
                    self.repeatNewPass.text = ""
                    
                    // Return to the homepage once "Go home" has been pressed.
                    self.performSegue(withIdentifier: "exitReset", sender: self)
                }

                alertView.addAction(goHomeAction)
                self.present(alertView, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func exitPassReset(_ sender: Any) {
        if usernameField.text!.isEmpty && newPass.text!.isEmpty && repeatNewPass.text!.isEmpty {
            
            self.performSegue(withIdentifier: "exitReset", sender: self)
        }
        else {
            let alertView = UIAlertController(title: "Warning!", message: "Are you sure you want to exit the page? Exiting will lose all entered fields.", preferredStyle: .actionSheet)

            let exitAction = UIAlertAction (title: "Yes", style: .destructive ) { alertAction in

                self.usernameField.text = ""
                self.newPass.text = ""
                self.repeatNewPass.text = ""
                self.performSegue(withIdentifier: "exitReset", sender: self)
            }

            let cancelAction = UIAlertAction (title: "No", style: .cancel ) {  alertAction in

            }
            alertView.addAction(exitAction)
            alertView.addAction(cancelAction)
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    // This function is called to hide the keyboard whenever we touch the screen, after it appears.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
