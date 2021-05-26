//
//  Register.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 25/05/21.
//

import UIKit

var pressedArray:[String: Bool] = ["bear":false, "cat":false, "dog":false, "frog":false, "giraffe":false, "gorilla":false, "lion":false, "rabbit":false, "tiger":false]

var profile:String = "N/A"

//var emptyOrNote:[Bool] = [false, false, false, false, false, false]

class Register: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // CHECK IF WE CAN PUT OUTLETS IN AN ARRAY!!!!
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
    
    func fieldsAlert(title:String = "Missing Field!", msg: String) -> Void {
        
        let alertView = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction (title: "Ok", style: .cancel ) {  alertAction in

        }
        alertView.addAction(cancelAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func missingField() -> Void {
        if !pressedArray.values.contains(true) {
            fieldsAlert(title: "Missing Profile Picture!" , msg: "Please select a picutre as your profile picture.")
        }
        else if nameField.text!.isEmpty {
            fieldsAlert(msg: "Please enter your name.")
        }
        else if usernameField.text!.isEmpty {
            fieldsAlert(msg: "Please enter a username.")
        }
        else if passwordField.text!.isEmpty {
            fieldsAlert(msg: "Please enter a password.")
        }
        else  if repeatPassField.text!.isEmpty {
            fieldsAlert(msg: "Please re-enter your password.")
        }
        else {
            return
        }
    }
    
    func errorCriteria() -> Void {
        if nameField.text?.hasWhitespacesNewlines() == true || nameField.text!.hasDigits() == true {
            fieldsAlert(title: "Invalid Name!", msg: "Your name contains invalid characters (i.e. whitespaces or numbers).")
        }
        else if usernameField.text?.hasWhitespacesNewlines() == true || usernameField.text!.hasDigits() == true {
            fieldsAlert(title: "Invalid Username!", msg: "Your username contains invalid characters (i.e. whitespaces or numbers).")
        }
        else if passwordField.text!.count < 8 || passwordField.text?.hasWhitespacesNewlines() == true {
            fieldsAlert(title: "Invalid Password!", msg: "Your password doesn't meet the required criteria.")
        }
        else if passwordField.text != repeatPassField.text {
            fieldsAlert(title: "No Match!", msg: "The reinputted password doesn't match your initial one.")
        }
        else {
            print("Wohoo everything's correct!!!")
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
