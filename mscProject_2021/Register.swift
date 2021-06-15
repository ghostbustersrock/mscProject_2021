//
//  Register.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 25/05/21.
//

import UIKit
import RealmSwift

var pressedArray:[String: Bool] = ["bear":false, "cat":false, "dog":false, "frog":false, "giraffe":false, "gorilla":false, "lion":false, "rabbit":false, "tiger":false]

var profile:String = "N/A"

//var emptyOrNote:[Bool] = [false, false, false, false, false, false]

class Register: UIViewController {
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet var tigerBack: UIButton!
    @IBOutlet var rabbitBack: UIButton!
    @IBOutlet var lionBack: UIButton!
    @IBOutlet var gorillaBack: UIButton!
    @IBOutlet var giraffeBack: UIButton!
    @IBOutlet var frogBack: UIButton!
    @IBOutlet var dogBack: UIButton!
    @IBOutlet var catBack: UIButton!
    @IBOutlet var bearBack: UIButton!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var repeatPassField: UITextField!
    @IBOutlet var errorMsg: UILabel!
    
    func fieldsAlert(title:String = "Missing Field!", msg: String) -> Void {
        
        let alertView = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction (title: "Ok", style: .cancel ) {  alertAction in

        }
        alertView.addAction(cancelAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func missingField() -> Void {
        if !pressedArray.values.contains(true) {
            fieldsAlert(title: "Missing Profile Picture!" , msg: "Please select an icon as your profile picture.")
        }
        else if nameField.text!.isEmpty {
            errorMsg.text = "Enter a name"
            borderName()
        }
        else if usernameField.text!.isEmpty {
            errorMsg.text = "Enter a username"
            borderUsername()
        }
        else if passwordField.text!.isEmpty {
            errorMsg.text = "Enter a password"
            borderPassword()
        }
        else  if repeatPassField.text!.isEmpty {
            errorMsg.text = "Enter your password again"
            borderRepeatPass()
        }
        else {
            resetBorders()
            return
        }
    }
    
    func errorCriteria() -> Void {
        if nameField.text?.hasWhitespacesNewlines() == true || nameField.text!.hasDigits() == true {
            errorMsg.text = "Name contains whitespaces or numbers"
            borderName()
        }
        else if usernameField.text?.hasWhitespacesNewlines() == true || usernameField.text!.hasDigits() == true {
            errorMsg.text = "Username contains whitespaces or numbers"
            borderUsername()
        }
        else if passwordField.text!.count < 8 || passwordField.text?.hasWhitespacesNewlines() == true {
            errorMsg.text = "Password doesn't match criteria"
            borderPassword()
        }
        else if passwordField.text != repeatPassField.text {
            errorMsg.text = "The repeated password doesn't match your initial one"
            borderRepeatPassWrong()
        }
        else {
            // Check if username has been taken or not before saving everything!
            if realm.objects(User.self).filter("username == %@", usernameField.text!).first?.username != usernameField.text { // No same username has been found so save info.
                let newUser = User()
                while true {
                    let randomNumber = Int.random(in: 1...100)
                    let data = realm.objects(User.self).filter("identifier == %@", randomNumber).first
                    if (data == nil) { // No user with same ID was found.
                        newUser.identifier = randomNumber
                        break
                    }
                }
                newUser.profilePic = profile
                newUser.name = nameField.text
                newUser.username = usernameField.text
                newUser.password = passwordField.text
                newUser.initialQuestionnaire = false
                // MARK: Add initial mood values when decided which and how many to use!!!
                realm.beginWrite()
                realm.add(newUser)
                try! realm.commitWrite()
                print(Realm.Configuration.defaultConfiguration.fileURL!)
                resetBorders()
                errorMsg.text = ""
                
                let alertView = UIAlertController(title: "Success!", message: "You have successfully registered!", preferredStyle: .actionSheet)

                let goHomeAction = UIAlertAction (title: "Go home", style: .default) { alertAction in
                    // Just for sercurity purposes remove all values from the outlets and variables used, whose values need to be saved.
                    profile = "N/A"
                    self.nameField.text = ""
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
        if nameField.text!.isEmpty || usernameField.text!.isEmpty || passwordField.text!.isEmpty || repeatPassField.text!.isEmpty || !pressedArray.values.contains(true) {
            
            missingField()
        }
        // Check, before saving everything, if the fields meet their required criteria.
        else if !nameField.text!.isEmpty && !usernameField.text!.isEmpty && !passwordField.text!.isEmpty && !repeatPassField.text!.isEmpty && pressedArray.values.contains(true) {
            
            errorCriteria()
        }
    }
    
    @IBAction func exitSignup(_ sender: Any) {
        
        if nameField.text!.isEmpty && usernameField.text!.isEmpty && passwordField.text!.isEmpty && repeatPassField.text!.isEmpty && !pressedArray.values.contains(true) {
            
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
    
    @IBAction func bearFunc(_ sender: Any) {
        
        if pressedArray["bear"] == false {
            profile = "bear"
            pressedArray["bear"] = true
            animalPressed(name: "bear")
            
            tigerBack.backgroundColor = UIColor.white
            dogBack.backgroundColor = UIColor.white
            rabbitBack.backgroundColor = UIColor.white
            giraffeBack.backgroundColor = UIColor.white
            gorillaBack.backgroundColor = UIColor.white
            catBack.backgroundColor = UIColor.white
            bearBack.backgroundColor = UIColor.green
            frogBack.backgroundColor = UIColor.white
            lionBack.backgroundColor = UIColor.white
        }
        else {
            bearBack.backgroundColor = UIColor.white
            pressedArray["bear"] = false
            profile = "N/A"
        }
    }
    
    @IBAction func catFunc(_ sender: Any) {
        
        if pressedArray["cat"] == false {
            profile = "cat"
            pressedArray["cat"] = true
            animalPressed(name: "cat")
            
            tigerBack.backgroundColor = UIColor.white
            dogBack.backgroundColor = UIColor.white
            rabbitBack.backgroundColor = UIColor.white
            giraffeBack.backgroundColor = UIColor.white
            gorillaBack.backgroundColor = UIColor.white
            catBack.backgroundColor = UIColor.green
            bearBack.backgroundColor = UIColor.white
            frogBack.backgroundColor = UIColor.white
            lionBack.backgroundColor = UIColor.white
        }
        else {
            catBack.backgroundColor = UIColor.white
            pressedArray["cat"] = false
            profile = "N/A"
        }
    }

    @IBAction func dogFunc(_ sender: Any) {

        if pressedArray["dog"] == false {
            profile = "dog"
            pressedArray["dog"] = true
            animalPressed(name: "dog")
            
            tigerBack.backgroundColor = UIColor.white
            dogBack.backgroundColor = UIColor.green
            rabbitBack.backgroundColor = UIColor.white
            giraffeBack.backgroundColor = UIColor.white
            gorillaBack.backgroundColor = UIColor.white
            catBack.backgroundColor = UIColor.white
            bearBack.backgroundColor = UIColor.white
            frogBack.backgroundColor = UIColor.white
            lionBack.backgroundColor = UIColor.white
        }
        else {
            dogBack.backgroundColor = UIColor.white
            pressedArray["dog"] = false
            profile = "N/A"
        }
    }

    @IBAction func frogFunc(_ sender: Any) {

        if pressedArray["frog"] == false {
            profile = "frog"
            pressedArray["frog"] = true
            animalPressed(name: "frog")
            
            tigerBack.backgroundColor = UIColor.white
            dogBack.backgroundColor = UIColor.white
            rabbitBack.backgroundColor = UIColor.white
            giraffeBack.backgroundColor = UIColor.white
            gorillaBack.backgroundColor = UIColor.white
            catBack.backgroundColor = UIColor.white
            bearBack.backgroundColor = UIColor.white
            frogBack.backgroundColor = UIColor.green
            lionBack.backgroundColor = UIColor.white
        }
        else {
            frogBack.backgroundColor = UIColor.white
            pressedArray["frog"] = false
            profile = "N/A"
        }
    }

    @IBAction func giraffeFunc(_ sender: Any) {

        if pressedArray["giraffe"] == false {
            profile = "giraffe"
            pressedArray["giraffe"] = true
            animalPressed(name: "giraffe")
            
            tigerBack.backgroundColor = UIColor.white
            dogBack.backgroundColor = UIColor.white
            rabbitBack.backgroundColor = UIColor.white
            giraffeBack.backgroundColor = UIColor.green
            gorillaBack.backgroundColor = UIColor.white
            catBack.backgroundColor = UIColor.white
            bearBack.backgroundColor = UIColor.white
            frogBack.backgroundColor = UIColor.white
            lionBack.backgroundColor = UIColor.white
        }
        else {
            giraffeBack.backgroundColor = UIColor.white
            pressedArray["giraffe"] = false
            profile = "N/A"
        }
    }


    @IBAction func gorillaFunc(_ sender: Any) {

        if pressedArray["gorilla"] == false {
            profile = "gorilla"
            pressedArray["gorilla"] = true
            animalPressed(name: "gorilla")
            
            tigerBack.backgroundColor = UIColor.white
            dogBack.backgroundColor = UIColor.white
            rabbitBack.backgroundColor = UIColor.white
            giraffeBack.backgroundColor = UIColor.white
            gorillaBack.backgroundColor = UIColor.green
            catBack.backgroundColor = UIColor.white
            bearBack.backgroundColor = UIColor.white
            frogBack.backgroundColor = UIColor.white
            lionBack.backgroundColor = UIColor.white
        }
        else {
            gorillaBack.backgroundColor = UIColor.white
            pressedArray["gorilla"] = false
            profile = "N/A"
        }
    }

    @IBAction func lionFunc(_ sender: Any) {

        if pressedArray["lion"] == false {
            profile = "lion"
            pressedArray["lion"] = true
            animalPressed(name: "lion")
            
            tigerBack.backgroundColor = UIColor.white
            dogBack.backgroundColor = UIColor.white
            rabbitBack.backgroundColor = UIColor.white
            giraffeBack.backgroundColor = UIColor.white
            gorillaBack.backgroundColor = UIColor.white
            catBack.backgroundColor = UIColor.white
            bearBack.backgroundColor = UIColor.white
            frogBack.backgroundColor = UIColor.white
            lionBack.backgroundColor = UIColor.green
        }
        else {
            lionBack.backgroundColor = UIColor.white
            pressedArray["lion"] = false
            profile = "N/A"
        }
    }


    @IBAction func rabbitFunc(_ sender: Any) {

        if pressedArray["rabbit"] == false {
            profile = "rabbit"
            pressedArray["rabbit"] = true
            animalPressed(name: "rabbit")
            
            tigerBack.backgroundColor = UIColor.white
            dogBack.backgroundColor = UIColor.white
            rabbitBack.backgroundColor = UIColor.green
            giraffeBack.backgroundColor = UIColor.white
            gorillaBack.backgroundColor = UIColor.white
            catBack.backgroundColor = UIColor.white
            bearBack.backgroundColor = UIColor.white
            frogBack.backgroundColor = UIColor.white
            lionBack.backgroundColor = UIColor.white
        }
        else {
            rabbitBack.backgroundColor = UIColor.white
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
            dogBack.backgroundColor = UIColor.white
            rabbitBack.backgroundColor = UIColor.white
            giraffeBack.backgroundColor = UIColor.white
            gorillaBack.backgroundColor = UIColor.white
            catBack.backgroundColor = UIColor.white
            bearBack.backgroundColor = UIColor.white
            frogBack.backgroundColor = UIColor.white
            lionBack.backgroundColor = UIColor.white
        }
        else {
            tigerBack.backgroundColor = UIColor.white
            pressedArray["tiger"] = false
            profile = "N/A"
        }
    }
    
    func borderName() {
        nameField.layer.borderColor = UIColor.red.cgColor
        nameField.layer.borderWidth = 1
        usernameField.layer.borderColor = UIColor.clear.cgColor
        usernameField.layer.borderWidth = 0
        passwordField.layer.borderColor = UIColor.clear.cgColor
        passwordField.layer.borderWidth = 0
        repeatPassField.layer.borderColor = UIColor.clear.cgColor
        repeatPassField.layer.borderWidth = 0
    }
    
    func borderUsername() {
        nameField.layer.borderColor = UIColor.clear.cgColor
        nameField.layer.borderWidth = 0
        usernameField.layer.borderColor = UIColor.red.cgColor
        usernameField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.clear.cgColor
        passwordField.layer.borderWidth = 0
        repeatPassField.layer.borderColor = UIColor.clear.cgColor
        repeatPassField.layer.borderWidth = 0
    }
    
    func borderPassword() {
        nameField.layer.borderColor = UIColor.clear.cgColor
        nameField.layer.borderWidth = 0
        usernameField.layer.borderColor = UIColor.clear.cgColor
        usernameField.layer.borderWidth = 0
        passwordField.layer.borderColor = UIColor.red.cgColor
        passwordField.layer.borderWidth = 1
        repeatPassField.layer.borderColor = UIColor.clear.cgColor
        repeatPassField.layer.borderWidth = 0
    }
    
    func borderRepeatPass() {
        nameField.layer.borderColor = UIColor.clear.cgColor
        nameField.layer.borderWidth = 0
        usernameField.layer.borderColor = UIColor.clear.cgColor
        usernameField.layer.borderWidth = 0
        passwordField.layer.borderColor = UIColor.clear.cgColor
        passwordField.layer.borderWidth = 0
        repeatPassField.layer.borderColor = UIColor.red.cgColor
        repeatPassField.layer.borderWidth = 1
    }
    
    func borderRepeatPassWrong() {
        nameField.layer.borderColor = UIColor.clear.cgColor
        nameField.layer.borderWidth = 0
        usernameField.layer.borderColor = UIColor.clear.cgColor
        usernameField.layer.borderWidth = 0
        passwordField.layer.borderColor = UIColor.red.cgColor
        passwordField.layer.borderWidth = 1
        repeatPassField.layer.borderColor = UIColor.red.cgColor
        repeatPassField.layer.borderWidth = 1
    }
    
    func resetBorders() {
        nameField.layer.borderColor = UIColor.clear.cgColor
        nameField.layer.borderWidth = 0
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
