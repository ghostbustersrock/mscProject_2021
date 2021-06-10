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
            
            // MARK: Pass identifier!!!
            
            errorLabel.text = ""
            self.performSegue(withIdentifier: "successfulLogin", sender: self)
        }
    }
    
    @IBAction func goHome(segue: UIStoryboardSegue) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
