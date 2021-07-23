//
//  ViewController.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 23/05/21.
//

import UIKit
import RealmSwift

// MARK: Launch View Class
// This class is in regards to the app's first view presented once launched.
class ViewController: UIViewController {

    // Creating an instance to open a connection to the database.
    let realm = try! Realm()
    
    // Outlets to make the UI's text fields and labels functional.
    @IBOutlet var usernameInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    // Button action outlet to do stuff if pressed.
    @IBAction func loginButton(_ sender: Any) {
        
        // Checking if the login details are complete and correct before logging in by looking for the inputted login details on the database Realm and seeing if they return the inputs given, indicating that a login is possible.
        // If details are wrong or missing show errors.
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
        // If details are correct login and re-direct with segue to the profile.
        else {
            errorLabel.text = ""
            self.performSegue(withIdentifier: "successfulLogin", sender: self)
        }
    }
    
    @IBAction func goHome(segue: UIStoryboardSegue) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Print path to access Realm file to view saved objects and field's values.
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // Setting some tesxt to the username and password fields placeholders.
        usernameInput.attributedPlaceholder = NSAttributedString(string: "Username",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x3F8098)])
        
        passwordInput.attributedPlaceholder = NSAttributedString(string: "Password",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x3F8098)])
        
    }

    // When a segue to another UI occurs bring within the ProfileTab UI class the unique ID of the logged in user along other information to be displayed on their profile.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "successfulLogin" {
            
            let receiverVC = segue.destination as! UITabBarController
            let destinationVC = receiverVC.viewControllers![0] as! ProfileTab
            // Information to pass to the profile's UI.
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

// Extension used so to use throughout the application, HEX coded colours.
extension UIColor {
    convenience init(hex: Int) {
        let rgbComponents = (R: CGFloat((hex>>16) & 0xff)/255, G: CGFloat((hex>>08) & 0xff)/255, B: CGFloat((hex>>00) & 0xff)/255)
        self.init(red: rgbComponents.R, green: rgbComponents.G, blue: rgbComponents.B, alpha: 1)
    }

}

// Extension used to check if a string contains whitespaces, newlines and decimal digits.
extension String {
    func hasWhitespacesNewlines() -> Bool {
        return rangeOfCharacter(from: .whitespacesAndNewlines) != nil
    }
    
    func hasDigits() -> Bool {
        return rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
    }
}
