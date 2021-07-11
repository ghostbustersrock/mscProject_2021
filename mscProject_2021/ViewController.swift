//
//  ViewController.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 23/05/21.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    let realm = try! Realm()
    
    @IBOutlet var usernameInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    @IBAction func loginButton(_ sender: Any) {
        
        if usernameInput.text!.isEmpty || passwordInput.text!.isEmpty {
            if usernameInput.text!.isEmpty && passwordInput.text!.isEmpty {
                errorLabel.text = "No username and password entered"
            }
            else if usernameInput.text!.isEmpty {
                errorLabel.text = "Enter a username"
            }
            else {
                errorLabel.text = "Enter a password"
            }
        }
        else if (realm.objects(User.self).filter("username == %@", usernameInput.text!).first?.username != usernameInput.text) || (realm.objects(User.self).filter("username == %@", usernameInput.text!).first?.password != passwordInput.text) {
            
            if(realm.objects(User.self).filter("username == %@", usernameInput.text!).first?.username != usernameInput.text) && (realm.objects(User.self).filter("username == %@", usernameInput.text!).first?.password != passwordInput.text) {
                errorLabel.text = "No matches with the inputs"
            }
            else if realm.objects(User.self).filter("username == %@", usernameInput.text!).first?.username != usernameInput.text {
                errorLabel.text = "No username match"
            }
            else {
                errorLabel.text = "No password match"
            }
        }
        else {
            errorLabel.text = ""
            self.performSegue(withIdentifier: "successfulLogin", sender: self)
        }
    }
    
    @IBAction func goHome(segue: UIStoryboardSegue) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "successfulLogin" {
            let receiverVC = segue.destination as! UITabBarController
            let destinationVC = receiverVC.viewControllers![0] as! ProfileTab
            destinationVC.profileID = realm.objects(User.self).filter("username == %@", usernameInput.text!).first!.identifier
            destinationVC.profileImage = realm.objects(User.self).filter("username == %@", usernameInput.text!).first!.profilePic
            destinationVC.profileUsername = realm.objects(User.self).filter("username == %@", usernameInput.text!).first!.username
            usernameInput.text! = ""
            passwordInput.text! = ""
        }
    }
    
    // This function is called to hide the keyboard whenever we touch the screen, after it appears.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
