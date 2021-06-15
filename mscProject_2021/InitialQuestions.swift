//
//  InitialQuestions.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 13/06/21.
//

import UIKit
import RealmSwift

class InitialQsHome: UIViewController {
    
    let realm = try! Realm()
    
    var profileID:Int?
    @IBOutlet var presentationText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let data = realm.objects(User.self).filter("identifier == %@", profileID!).first
        presentationText.text = "Hello \(String(data!.name!))! Welcome to *insert app name*. Before accessing your profile you will need to answer some questions to initially assess your mood. Don't worry it will only take a moment of your time. Thank you and again... welcome to *insert app name*"
    }
    
    @IBAction func startQuestions(_ sender: Any) {
        self.performSegue(withIdentifier: "startQs", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startQs" {
            let receiverVC = segue.destination as! InitialQuestions
            receiverVC.profileID = profileID
        }
    }
}


class InitialQuestions: UIViewController {
    
    var profileID:Int?
    var atQuestion:Int = 0
    
    @IBOutlet var questionNumber: UILabel!
    @IBOutlet var question: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    @IBAction func nextButtonFunc(_ sender: Any) {
        
        if atQuestion == 3 {
            question.text = "WOHOOOOOO FINISHED!!!!"
            atQuestion += 1
            
        }
        else if atQuestion > 3 {
            self.performSegue(withIdentifier: "qsFinished", sender: self)
        }
        else {
            atQuestion += 1
            question.text = "Question \(String(atQuestion))"
            questionNumber.text = "Question \(String(atQuestion)) of 3"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        atQuestion = 1
        questionNumber.text = "Question \(String(atQuestion)) of 3"
        question.text = "Question \(String(atQuestion))"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "qsFinished" {
            let receiverVC = segue.destination as! QuestionsFinished
            receiverVC.profileID = profileID
            print(atQuestion)
            atQuestion = 0
            print(atQuestion)
        }
    }
}


class QuestionsFinished: UIViewController {
    var profileID:Int?
    
    let realm = try! Realm()
    var data:User?
    
    @IBAction func goToProfile(_ sender: Any) {
        self.performSegue(withIdentifier: "accessProfile", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(User.self).filter("identifier == %@", profileID!).first
        
        try! realm.write {
            data?.initialQuestionnaire = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "accessProfile" {
            let receiverVC = segue.destination as! UITabBarController
            let destinationVC = receiverVC.viewControllers![0] as! ProfileTab
            destinationVC.profileID = profileID
            destinationVC.profileImage = data?.profilePic
            destinationVC.profileName = data?.name
            destinationVC.profileUsername = data?.username
        }
    }
}
