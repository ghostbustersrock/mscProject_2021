//
//  PHQquestionnaire.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 30/06/21.
//

import UIKit
import RealmSwift

class PHQquestionnaire: UIViewController {
    
    var profileID:Int? //The profile ID of the user taking the PHQ-9 test.
    var questionHeader:Int = 0
    var atQuestion:Int = 0
    var pressedButton:Int = 0
    var totalScore:Int = 0 // Keep track of score.
    var points:Int = 0 // To set the points for the question.
    var depressionSeverity: String = ""
    var depressionTreatment: String = ""
    
    let questionsPHQ:[String] = ["Little interest or pleasure in doing things", "Feeling down, depressed, or hopeless", "Trouble falling or staying asleep, or sleeping too much", "Feeling tired or having little energy", "Poor appetite or overeating", "Feeling bad about yourself — or that you are a failure or have let yourself or your family down", "Trouble concentrating on things, such as reading the newspaper or watching television", "Moving or speaking so slowly that other people could have noticed. Or the opposite — being so fidgety or restless that you have been moving around a lot more than usual", "Thoughts that you would be better off dead or of hurting yourself in some way"]
    
    
    @IBOutlet var questionDisplay: [UILabel]! // For question header number and question.
    @IBOutlet var answersPHQ: [UIButton]! // For the answers.
    @IBOutlet var submitButton: UIButton! // For the NEXT button.
    
    @IBAction func answer1(_ sender: Any) {
        pressedButton = 1
        points = 0
        answersPHQ[0].backgroundColor = .systemGray2
        answersPHQ[1].backgroundColor = .systemGray5
        answersPHQ[2].backgroundColor = .systemGray5
        answersPHQ[3].backgroundColor = .systemGray5
    }
    
    @IBAction func answer2(_ sender: Any) {
        pressedButton = 2
        points = 1
        answersPHQ[0].backgroundColor = .systemGray5
        answersPHQ[1].backgroundColor = .systemGray2
        answersPHQ[2].backgroundColor = .systemGray5
        answersPHQ[3].backgroundColor = .systemGray5
    }
    
    @IBAction func answer3(_ sender: Any) {
        pressedButton = 3
        points = 2
        answersPHQ[0].backgroundColor = .systemGray5
        answersPHQ[1].backgroundColor = .systemGray5
        answersPHQ[2].backgroundColor = .systemGray2
        answersPHQ[3].backgroundColor = .systemGray5
    }
    
    @IBAction func answer4(_ sender: Any) {
        pressedButton = 4
        points = 3
        answersPHQ[0].backgroundColor = .systemGray5
        answersPHQ[1].backgroundColor = .systemGray5
        answersPHQ[2].backgroundColor = .systemGray5
        answersPHQ[3].backgroundColor = .systemGray2
    }
    
    @IBAction func nextFinish(_ sender: Any) {
        
        answersPHQ[0].backgroundColor = .systemGray5
        answersPHQ[1].backgroundColor = .systemGray5
        answersPHQ[2].backgroundColor = .systemGray5
        answersPHQ[3].backgroundColor = .systemGray5
        
        atQuestion += 1
        questionHeader += 1
        
        if atQuestion == 8 {
            totalScore += points
            questionDisplay[0].text = "Question \(questionHeader)/9"
            questionDisplay[1].text = questionsPHQ[atQuestion]
            submitButton.setTitle("FINISH", for: .normal)
        }
        else if atQuestion < 9 {
            totalScore += points
            questionDisplay[0].text = "Question \(questionHeader)/9"
            questionDisplay[1].text = questionsPHQ[atQuestion]
        }
        else {
            totalScore += points
            phqResult()
            
            //MARK: SAVING PHQ SCORES
            let realm = try! Realm()
            let phqResults = PhqTestResults()
            
            if realm.objects(PhqTestResults.self).filter("identifier == %@", profileID!).first?.identifier == profileID {
                // Same user has been found so store new info.
                
                let data = realm.objects(PhqTestResults.self).filter("identifier == %@", profileID!).first
                
                try! realm.write {
                    data?.scoreResPHQ.append(totalScore)
                    data?.severityResPHQ.append(depressionSeverity)
                }
            }
            else {
                phqResults.identifier = profileID!
                phqResults.scoreResPHQ.append(totalScore)
                phqResults.severityResPHQ.append(depressionSeverity)
                realm.beginWrite()
                realm.add(phqResults)
                try! realm.commitWrite()
            }
            
            
            let alertView = UIAlertController(title: "Done!", message: "You have completed the PHQ-9 questionnaire with a score of \(totalScore)/27. From the PHQ-9 assessment table, your score suggests your depression severity to be \(depressionSeverity). The proposed treatment is the following: \(depressionTreatment). The results will be displayed on your profile underneath the pie chart. The newest scores will always be shown first.", preferredStyle: .alert)

            let goHomeAction = UIAlertAction (title: "Exit Test", style: .default) { alertAction in
                // Just for sercurity purposes remove all values from the outlets and variables used, whose values need to be saved.
                self.questionHeader = 0
                self.atQuestion = 0
                self.pressedButton = 0
                self.totalScore = 0
                self.points = 0
                self.depressionSeverity = ""
                self.depressionTreatment = ""
                
                // Return to the homepage once "Go home" has been pressed.
                self.performSegue(withIdentifier: "goBackToPHQ", sender: self)
            }

            alertView.addAction(goHomeAction)
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(profileID!) gugugugugugu")
        questionHeader = 1
        questionDisplay[0].text = "Question \(questionHeader)/9"
        questionDisplay[1].text = questionsPHQ[atQuestion]
    }
    
    func phqResult() {
        if totalScore == 0 {
            depressionSeverity = "N/A"
            depressionTreatment = "N/A"
        }
        else if totalScore >= 1 && totalScore <= 4 {
            depressionSeverity = "NONE"
            depressionTreatment = "none"
            
        }
        else if totalScore >= 5 && totalScore <= 9 {
            depressionSeverity = "MILD"
            depressionTreatment = "Watchful waiting; repeat PHQ-9 at follow-up"
        }
        else if totalScore >= 10 && totalScore <= 14 {
            depressionSeverity = "MODERATE"
            depressionTreatment = "Treatment plan, considering counseling, follow-up and/or pharmacotherapy"
        }
        else if totalScore >= 15 && totalScore <= 19 {
            depressionSeverity = "MODERATELY SEVERE"
            depressionTreatment = "Immediate initiation of pharmacotherapy and/or psychotherapy"
        }
        else {
            depressionSeverity = "SEVERE"
            depressionTreatment = " Immediate initiation of pharmacotherapy and, if severe impairment or poor response to therapy, expedited referral to a mental health specialist for psychotherapy and/or collaborative management"
        }
    }
}


class MainScreenPHQ: UIViewController {
    
    var profileID:Int? //The profile ID of the user taking the PHQ-9 test.
    
    @IBAction func infoPHQtest(_ sender: Any) {
        let usefulFunc = UsefulFunctions()
        usefulFunc.openSite(siteName: "https://www.phqscreeners.com/images/sites/g/files/g10016261/f/201412/instructions.pdf")
    }
    
    @IBAction func startPHQtest(_ sender: Any) {
        self.performSegue(withIdentifier: "toStartPHQtest", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Passing ID of logged in user to the next view controller.
        if segue.identifier == "toStartPHQtest" {
            let receiverVC = segue.destination as! PHQquestionnaire
            receiverVC.profileID = profileID
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("THIS IS THE LOG IN ID: \(profileID!)!!! OHMG")
    }
    
    @IBAction func goBackToPHQ(segue: UIStoryboardSegue) {

    }
}
