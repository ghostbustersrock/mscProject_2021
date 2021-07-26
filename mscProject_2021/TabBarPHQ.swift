//
//  TabBarPHQ.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 30/06/21.
//

import UIKit

//MARK: Class of the homepage from which to choose either the emotion analysis or PHQ-9 questionnaire.
class TabBarPHQ: UIViewController {
    //Variable holding the profile ID of the user taking the PHQ-9 test that was passed to this class.
    var profileID:Int?
    
    //If selecting the PHQ-9 questionnaire button then redirect to its 'before starting' information page.
    @IBAction func phqTest(_ sender: Any) {
        self.performSegue(withIdentifier: "toPHQtest", sender: self)
    }
    
    //If selecting the emotion analysis questionnaire button then redirect to its 'before starting' information page.
    @IBAction func emotionTest(_ sender: Any) {
        self.performSegue(withIdentifier: "toEMOTIONtest", sender: self)
    }
    
    //For an unwind segue to occur from either's questionnaire results page, after the test has ended.
    @IBAction func goBackQsHome(segue: UIStoryboardSegue) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //For both the emotion analysis and PHQ-9 questionnaire pass to their classes the ID of the profile, needed within those classes to then save the questionnaire's results, later used to be displayed on the user's profile.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPHQtest" {
            let receiverVC = segue.destination as! MainScreenPHQ
            receiverVC.profileID = profileID
        }
        else if segue.identifier == "toEMOTIONtest" {
            let receiverVC = segue.destination as! HomeQuestionnaireAnalysis
            receiverVC.profileID = profileID
        }
    }
}
