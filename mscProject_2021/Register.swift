//
//  Register.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 25/05/21.
//

import UIKit
import RealmSwift

// This array is used to select/deselect the profile image chosen by the user to then save.
var pressedArray:[String: Bool] = ["bear":false, "cat":false, "dog":false, "frog":false, "giraffe":false, "gorilla":false, "lion":false, "rabbit":false, "tiger":false]

var profile:String = "N/A"

// MARK: Sign up to the app class
// This class contains functions and variables used for new users to sign up to the application.
class Register: UIViewController {
    // Creating an instance to open a connection to the database.
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // Outlets of the UI objects to make them interactive.
    @IBOutlet var tigerBack: UIButton!
    @IBOutlet var rabbitBack: UIButton!
    @IBOutlet var lionBack: UIButton!
    @IBOutlet var gorillaBack: UIButton!
    @IBOutlet var giraffeBack: UIButton!
    @IBOutlet var frogBack: UIButton!
    @IBOutlet var dogBack: UIButton!
    @IBOutlet var catBack: UIButton!
    @IBOutlet var bearBack: UIButton!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var repeatPassField: UITextField!
    @IBOutlet var errorMsg: UILabel!
    
    // Function called whenever an alert needs to be displayed.
    func fieldsAlert(title:String = "Missing Field!", msg: String) {
        
        let alertView = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction (title: "Ok", style: .cancel ) {  alertAction in

        }
        alertView.addAction(cancelAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    // Function called to highlight what is missing to be filled in, for the sign-up.
    func missingField() {
        if !pressedArray.values.contains(true) {
            fieldsAlert(title: "Missing Profile Picture!" , msg: "Please select an icon as your profile picture.")
        }
        else if usernameField.text!.isEmpty { // Missing username.
            errorMsg.text = "Enter a username"
            borderUsername()
        }
        else if passwordField.text!.isEmpty { // Missing password.
            errorMsg.text = "Enter a password"
            borderPassword()
        }
        else  if repeatPassField.text!.isEmpty { // Missing repeated password.
            errorMsg.text = "Enter your password again"
            borderRepeatPass()
        }
        else {
            resetBorders()
            return
        }
    }
    
    // Function used to either save the entered details or check if the entered details meet the sign-up field criteria.
    func errorCriteria() {
        // Highlight username containing whitespaces.
        if usernameField.text?.hasWhitespacesNewlines() == true || usernameField.text!.hasDigits() == true {
            errorMsg.text = "Username contains whitespaces or numbers"
            borderUsername()
        }
        // Highlight password being less than 8 characters or contains whitespaces.
        else if passwordField.text!.count < 8 || passwordField.text?.hasWhitespacesNewlines() == true {
            errorMsg.text = "Password doesn't match criteria"
            borderPassword()
        }
        // Highlight repeated password not matching original.
        else if passwordField.text != repeatPassField.text {
            errorMsg.text = "The repeated password doesn't match your initial one"
            borderRepeatPassWrong()
        }
        // If everything is correct save all the new information.
        else {
            // Check if username has been taken or not before saving everything!
            if realm.objects(User.self).filter("username == %@", usernameField.text!).first?.username != usernameField.text { // No same username has been found so save info.
                let newUser = User() // Create new instance of Realms User() object, to save all the new user's information.
                while true {
                    // Assign a randomly generated integer ID to the new user and make sure it's not taken already, otherwise change it.
                    let randomNumber = Int.random(in: 1...100)
                    let data = realm.objects(User.self).filter("identifier == %@", randomNumber).first
                    if (data == nil) { // No user with same ID was found.
                        newUser.identifier = randomNumber
                        break
                    }
                }
                // Save in the chosen profile picture, username and password to the database.
                newUser.profilePic = profile
                newUser.username = usernameField.text
                newUser.password = passwordField.text
                
                realm.beginWrite()
                realm.add(newUser)
                try! realm.commitWrite()
                resetBorders()
                errorMsg.text = ""
                
                // Display successful alert message to then perform a segue back to the app's launch page (aka login page) once a successful registration and data saving occurs.
                let alertView = UIAlertController(title: "Success!", message: "You have successfully registered!", preferredStyle: .actionSheet)

                let goHomeAction = UIAlertAction (title: "Go home", style: .default) { alertAction in
                    // Just for sercurity purposes remove all values from the outlets and variables used, whose values need to be saved.
                    profile = "N/A"
                    self.usernameField.text = ""
                    self.passwordField.text = ""
                    self.repeatPassField.text = ""
                    for (k,_) in pressedArray {
                        pressedArray[k] = false
                    }
                    self.resetBorders() // Resetting the borders of the UItexFields.
                    // Return to the homepage once "Go home" has been pressed.
                    self.performSegue(withIdentifier: "savedInfoGoHome", sender: self)
                }

                alertView.addAction(goHomeAction)
                self.present(alertView, animated: true, completion: nil)
            }
            else { // If someone with the same username has been found then create alert.
                errorMsg.text = "That username isn't available. Choose another one."
                borderUsername()
            }
        }
    }
    
    @IBAction func saveSignup(_ sender: Any) {
        
        // If a field is empty make an alert pop up.
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty || repeatPassField.text!.isEmpty || !pressedArray.values.contains(true) {
            
            missingField()
        }
        // Check, before saving everything, if the fields meet their required criteria.
        else if !usernameField.text!.isEmpty && !passwordField.text!.isEmpty && !repeatPassField.text!.isEmpty && pressedArray.values.contains(true) {
            
            errorCriteria()
        }
    }
    
    // If the exit button is pressed while some data has been inputted a warning will be displayed asking confirmation if exiting is what the user wants to do, otherwise if no data is inputted in any field then the app returns the user to the main page.
    @IBAction func exitSignup(_ sender: Any) {
        
        if usernameField.text!.isEmpty && passwordField.text!.isEmpty && repeatPassField.text!.isEmpty && !pressedArray.values.contains(true) {
            
            self.performSegue(withIdentifier: "goHome", sender: self)
        }
        else {
            let alertView = UIAlertController(title: "Warning!", message: "Are you sure you want to exit the sign-up page? Exiting will lose all entered fields.", preferredStyle: .actionSheet)

            let exitAction = UIAlertAction (title: "Yes", style: .destructive ) { alertAction in

                profile = "N/A"
                self.errorMsg.text = ""
                self.resetBorders()
                for (key,_) in pressedArray {
                    pressedArray[key] = false
                }
                self.performSegue(withIdentifier: "goHome", sender: self)
            }

            let cancelAction = UIAlertAction (title: "No", style: .cancel ) {  alertAction in

            }
            alertView.addAction(exitAction)
            alertView.addAction(cancelAction)
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    // Function used to check which animal's image was selected.
    func animalPressed(name: String) -> Void {
        for (key,_) in pressedArray {
            if key == name {
                continue
            }
            else {
                pressedArray[key] = false
            }
        }
    }
    
    // ###########################################
    // These next 9 IBAction functions are all respectively assigned to the animals images from which to select the profile picture. Whenever one is selected or deselected its background colour is changed to show this and the array storing the animals (pressedArray) will have that animals BOOL value changed to show it has been selected.
    @IBAction func bearFunc(_ sender: Any) {
        
        if pressedArray["bear"] == false {
            profile = "bear"
            pressedArray["bear"] = true
            animalPressed(name: "bear")
            
            tigerBack.backgroundColor = UIColor.clear
            dogBack.backgroundColor = UIColor.clear
            rabbitBack.backgroundColor = UIColor.clear
            giraffeBack.backgroundColor = UIColor.clear
            gorillaBack.backgroundColor = UIColor.clear
            catBack.backgroundColor = UIColor.clear
            bearBack.backgroundColor = UIColor.green
            frogBack.backgroundColor = UIColor.clear
            lionBack.backgroundColor = UIColor.clear
        }
        else {
            bearBack.backgroundColor = UIColor.clear
            pressedArray["bear"] = false
            profile = "N/A"
        }
    }
    
    @IBAction func catFunc(_ sender: Any) {
        
        if pressedArray["cat"] == false {
            profile = "cat"
            pressedArray["cat"] = true
            animalPressed(name: "cat")
            
            tigerBack.backgroundColor = UIColor.clear
            dogBack.backgroundColor = UIColor.clear
            rabbitBack.backgroundColor = UIColor.clear
            giraffeBack.backgroundColor = UIColor.clear
            gorillaBack.backgroundColor = UIColor.clear
            catBack.backgroundColor = UIColor.green
            bearBack.backgroundColor = UIColor.clear
            frogBack.backgroundColor = UIColor.clear
            lionBack.backgroundColor = UIColor.clear
        }
        else {
            catBack.backgroundColor = UIColor.clear
            pressedArray["cat"] = false
            profile = "N/A"
        }
    }

    @IBAction func dogFunc(_ sender: Any) {

        if pressedArray["dog"] == false {
            profile = "dog"
            pressedArray["dog"] = true
            animalPressed(name: "dog")
            
            tigerBack.backgroundColor = UIColor.clear
            dogBack.backgroundColor = UIColor.green
            rabbitBack.backgroundColor = UIColor.clear
            giraffeBack.backgroundColor = UIColor.clear
            gorillaBack.backgroundColor = UIColor.clear
            catBack.backgroundColor = UIColor.clear
            bearBack.backgroundColor = UIColor.clear
            frogBack.backgroundColor = UIColor.clear
            lionBack.backgroundColor = UIColor.clear
        }
        else {
            dogBack.backgroundColor = UIColor.clear
            pressedArray["dog"] = false
            profile = "N/A"
        }
    }

    @IBAction func frogFunc(_ sender: Any) {

        if pressedArray["frog"] == false {
            profile = "frog"
            pressedArray["frog"] = true
            animalPressed(name: "frog")
            
            tigerBack.backgroundColor = UIColor.clear
            dogBack.backgroundColor = UIColor.clear
            rabbitBack.backgroundColor = UIColor.clear
            giraffeBack.backgroundColor = UIColor.clear
            gorillaBack.backgroundColor = UIColor.clear
            catBack.backgroundColor = UIColor.clear
            bearBack.backgroundColor = UIColor.clear
            frogBack.backgroundColor = UIColor.green
            lionBack.backgroundColor = UIColor.clear
        }
        else {
            frogBack.backgroundColor = UIColor.clear
            pressedArray["frog"] = false
            profile = "N/A"
        }
    }

    @IBAction func giraffeFunc(_ sender: Any) {

        if pressedArray["giraffe"] == false {
            profile = "giraffe"
            pressedArray["giraffe"] = true
            animalPressed(name: "giraffe")
            
            tigerBack.backgroundColor = UIColor.clear
            dogBack.backgroundColor = UIColor.clear
            rabbitBack.backgroundColor = UIColor.clear
            giraffeBack.backgroundColor = UIColor.green
            gorillaBack.backgroundColor = UIColor.clear
            catBack.backgroundColor = UIColor.clear
            bearBack.backgroundColor = UIColor.clear
            frogBack.backgroundColor = UIColor.clear
            lionBack.backgroundColor = UIColor.clear
        }
        else {
            giraffeBack.backgroundColor = UIColor.clear
            pressedArray["giraffe"] = false
            profile = "N/A"
        }
    }


    @IBAction func gorillaFunc(_ sender: Any) {

        if pressedArray["gorilla"] == false {
            profile = "gorilla"
            pressedArray["gorilla"] = true
            animalPressed(name: "gorilla")
            
            tigerBack.backgroundColor = UIColor.clear
            dogBack.backgroundColor = UIColor.clear
            rabbitBack.backgroundColor = UIColor.clear
            giraffeBack.backgroundColor = UIColor.clear
            gorillaBack.backgroundColor = UIColor.green
            catBack.backgroundColor = UIColor.clear
            bearBack.backgroundColor = UIColor.clear
            frogBack.backgroundColor = UIColor.clear
            lionBack.backgroundColor = UIColor.clear
        }
        else {
            gorillaBack.backgroundColor = UIColor.clear
            pressedArray["gorilla"] = false
            profile = "N/A"
        }
    }

    @IBAction func lionFunc(_ sender: Any) {

        if pressedArray["lion"] == false {
            profile = "lion"
            pressedArray["lion"] = true
            animalPressed(name: "lion")
            
            tigerBack.backgroundColor = UIColor.clear
            dogBack.backgroundColor = UIColor.clear
            rabbitBack.backgroundColor = UIColor.clear
            giraffeBack.backgroundColor = UIColor.clear
            gorillaBack.backgroundColor = UIColor.clear
            catBack.backgroundColor = UIColor.clear
            bearBack.backgroundColor = UIColor.clear
            frogBack.backgroundColor = UIColor.clear
            lionBack.backgroundColor = UIColor.green
        }
        else {
            lionBack.backgroundColor = UIColor.clear
            pressedArray["lion"] = false
            profile = "N/A"
        }
    }


    @IBAction func rabbitFunc(_ sender: Any) {

        if pressedArray["rabbit"] == false {
            profile = "rabbit"
            pressedArray["rabbit"] = true
            animalPressed(name: "rabbit")
            
            tigerBack.backgroundColor = UIColor.clear
            dogBack.backgroundColor = UIColor.clear
            rabbitBack.backgroundColor = UIColor.green
            giraffeBack.backgroundColor = UIColor.clear
            gorillaBack.backgroundColor = UIColor.clear
            catBack.backgroundColor = UIColor.clear
            bearBack.backgroundColor = UIColor.clear
            frogBack.backgroundColor = UIColor.clear
            lionBack.backgroundColor = UIColor.clear
        }
        else {
            rabbitBack.backgroundColor = UIColor.clear
            pressedArray["rabbit"] = false
            profile = "N/A"
        }
    }

//    For the tiger background color.
    @IBAction func tigerFunc(_ sender: Any) {

        if pressedArray["tiger"] == false {
            profile = "tiger"
            pressedArray["tiger"] = true
            animalPressed(name: "tiger")
            
            tigerBack.backgroundColor = UIColor.green
            dogBack.backgroundColor = UIColor.clear
            rabbitBack.backgroundColor = UIColor.clear
            giraffeBack.backgroundColor = UIColor.clear
            gorillaBack.backgroundColor = UIColor.clear
            catBack.backgroundColor = UIColor.clear
            bearBack.backgroundColor = UIColor.clear
            frogBack.backgroundColor = UIColor.clear
            lionBack.backgroundColor = UIColor.clear
        }
        else {
            tigerBack.backgroundColor = UIColor.clear
            pressedArray["tiger"] = false
            profile = "N/A"
        }
    }
    // ###########################################
    
    
    // Functions called to change the border color of the input fields whenever an alert in regards to them appears.
    func borderName() {
        usernameField.layer.borderColor = UIColor.clear.cgColor
        usernameField.layer.borderWidth = 0
        passwordField.layer.borderColor = UIColor.clear.cgColor
        passwordField.layer.borderWidth = 0
        repeatPassField.layer.borderColor = UIColor.clear.cgColor
        repeatPassField.layer.borderWidth = 0
    }
    
    func borderUsername() {
        usernameField.layer.borderColor = UIColor.red.cgColor
        usernameField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.clear.cgColor
        passwordField.layer.borderWidth = 0
        repeatPassField.layer.borderColor = UIColor.clear.cgColor
        repeatPassField.layer.borderWidth = 0
    }
    
    func borderPassword() {
        usernameField.layer.borderColor = UIColor.clear.cgColor
        usernameField.layer.borderWidth = 0
        passwordField.layer.borderColor = UIColor.red.cgColor
        passwordField.layer.borderWidth = 1
        repeatPassField.layer.borderColor = UIColor.clear.cgColor
        repeatPassField.layer.borderWidth = 0
    }
    
    func borderRepeatPass() {
        usernameField.layer.borderColor = UIColor.clear.cgColor
        usernameField.layer.borderWidth = 0
        passwordField.layer.borderColor = UIColor.clear.cgColor
        passwordField.layer.borderWidth = 0
        repeatPassField.layer.borderColor = UIColor.red.cgColor
        repeatPassField.layer.borderWidth = 1
    }
    
    func borderRepeatPassWrong() {
        usernameField.layer.borderColor = UIColor.clear.cgColor
        usernameField.layer.borderWidth = 0
        passwordField.layer.borderColor = UIColor.red.cgColor
        passwordField.layer.borderWidth = 1
        repeatPassField.layer.borderColor = UIColor.red.cgColor
        repeatPassField.layer.borderWidth = 1
    }
    
    func resetBorders() {
        usernameField.layer.borderColor = UIColor.clear.cgColor
        usernameField.layer.borderWidth = 0
        passwordField.layer.borderColor = UIColor.clear.cgColor
        passwordField.layer.borderWidth = 0
        repeatPassField.layer.borderColor = UIColor.clear.cgColor
        repeatPassField.layer.borderWidth = 0
    }
}

// Extension created by me to check if a string contains whitespaces, newlines and decimal digits.
extension String {
    func hasWhitespacesNewlines() -> Bool {
        return rangeOfCharacter(from: .whitespacesAndNewlines) != nil
    }
    
    func hasDigits() -> Bool {
        return rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
    }
}
