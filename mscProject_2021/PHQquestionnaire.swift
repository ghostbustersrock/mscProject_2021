//
//  PHQquestionnaire.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 30/06/21.
//

import UIKit
import RealmSwift

//MARK: Class assigned to the UI used to display the questions of the PHQ-9 test.
class PHQquestionnaire: UIViewController {
    
    var profileID:Int? //The profile ID of the user taking the PHQ-9 test.
    var questionHeader:Int = 0
    var atQuestion:Int = 0
    var pressedButton:Int = 0
    var totalScore:Int = 0 // Keep track of score.
    var points:Int = 0 // To set the points for the question.
    var depressionSeverity: String = ""
    var depressionTreatment: String = ""
    
    //The nine official questions of the test.
    let questionsPHQ:[String] = ["Little interest or pleasure in doing things", "Feeling down, depressed, or hopeless", "Trouble falling or staying asleep, or sleeping too much", "Feeling tired or having little energy", "Poor appetite or overeating", "Feeling bad about yourself — or that you are a failure or have let yourself or your family down", "Trouble concentrating on things, such as reading the newspaper or watching television", "Moving or speaking so slowly that other people could have noticed. Or the opposite — being so fidgety or restless that you have been moving around a lot more than usual", "Thoughts that you would be better off dead or of hurting yourself in some way"]
    
    
    @IBOutlet var questionDisplay: [UILabel]! // For the question's header number and the question itself.
    @IBOutlet var answersPHQ: [UIButton]! // For the answers.
    @IBOutlet var submitButton: UIButton! // For the NEXT button.
    
    //######################################
    // These next four IBAction functions are used to have the four answer buttons interactive and have their background change color when clicked. The 'pressedButton' variable is used to keep track of which answer was given for a question.
    @IBAction func answer1(_ sender: Any) {
        pressedButton = 1
        points = 0
        answersPHQ[0].backgroundColor = UIColor(hex: 0x519BB2)
        answersPHQ[1].backgroundColor = UIColor(hex: 0x95C9E9)
        answersPHQ[2].backgroundColor = UIColor(hex: 0x95C9E9)
        answersPHQ[3].backgroundColor = UIColor(hex: 0x95C9E9)
    }
    
    @IBAction func answer2(_ sender: Any) {
        pressedButton = 2
        points = 1
        answersPHQ[0].backgroundColor = UIColor(hex: 0x95C9E9)
        answersPHQ[1].backgroundColor = UIColor(hex: 0x519BB2)
        answersPHQ[2].backgroundColor = UIColor(hex: 0x95C9E9)
        answersPHQ[3].backgroundColor = UIColor(hex: 0x95C9E9)
    }
    
    @IBAction func answer3(_ sender: Any) {
        pressedButton = 3
        points = 2
        answersPHQ[0].backgroundColor = UIColor(hex: 0x95C9E9)
        answersPHQ[1].backgroundColor = UIColor(hex: 0x95C9E9)
        answersPHQ[2].backgroundColor = UIColor(hex: 0x519BB2)
        answersPHQ[3].backgroundColor = UIColor(hex: 0x95C9E9)
    }
    
    @IBAction func answer4(_ sender: Any) {
        pressedButton = 4
        points = 3
        answersPHQ[0].backgroundColor = UIColor(hex: 0x95C9E9)
        answersPHQ[1].backgroundColor = UIColor(hex: 0x95C9E9)
        answersPHQ[2].backgroundColor = UIColor(hex: 0x95C9E9)
        answersPHQ[3].backgroundColor = UIColor(hex: 0x519BB2)
    }
    //######################################
    
    // This IBAction function is for the test's NEXT button, to navigate through the questions.
    @IBAction func nextFinish(_ sender: Any) {
        
        answersPHQ[0].backgroundColor = UIColor(hex: 0x95C9E9)
        answersPHQ[1].backgroundColor = UIColor(hex: 0x95C9E9)
        answersPHQ[2].backgroundColor = UIColor(hex: 0x95C9E9)
        answersPHQ[3].backgroundColor = UIColor(hex: 0x95C9E9)
        
        atQuestion += 1
        questionHeader += 1
        
        //Checking if the second last question has been reached so to change the text of the NEXT button to FINISH.
        if atQuestion == 8 {
            totalScore += points
            questionDisplay[0].text = "Question \(questionHeader)/9"
            questionDisplay[1].text = questionsPHQ[atQuestion]
            submitButton.setTitle("FINISH", for: .normal)
        }
        // Checking if the last question has been reached.
        else if atQuestion < 9 {
            totalScore += points
            questionDisplay[0].text = "Question \(questionHeader)/9"
            questionDisplay[1].text = questionsPHQ[atQuestion]
        }
        // Checking if the test has finished.
        else {
            
            totalScore += points
            // Function to set the severity and treatment variables to a specific answer based on the total number of points assigned.
            phqResult()
            
            // Creating a Realm instance to save the results.
            let realm = try! Realm()
            // Creating an instance of the Realm object class to save these new scores.
            let phqResults = PhqTestResults()
            
            // If the same user as the profile ID passed to this class has been found on the database, store this test's new info for them.
            if realm.objects(PhqTestResults.self).filter("identifier == %@", profileID!).first?.identifier == profileID {
                
                let data = realm.objects(PhqTestResults.self).filter("identifier == %@", profileID!).first
                
                //Appending (overwrite) to the already existing values of user's PHQ-9 test, the resulting score and depression severity for the newly taken test.
                try! realm.write {
                    data?.scoreResPHQ.append(totalScore)
                    data?.severityResPHQ.append(depressionSeverity)
                }
            }
            //If the user doesn't have previous PHQ-9 test results then write completely new results for them.
            else {
                phqResults.identifier = profileID!
                phqResults.scoreResPHQ.append(totalScore)
                phqResults.severityResPHQ.append(depressionSeverity)
                realm.beginWrite()
                realm.add(phqResults)
                try! realm.commitWrite()
            }
        
            // Alert displaying the user's results, depression severity and treatment results along other information.
            let alertView = UIAlertController(title: "Done!", message: "You have completed the PHQ-9 questionnaire with a score of \(totalScore)/27. From the PHQ-9 assessment table, your score suggests your depression severity to be \(depressionSeverity). The proposed treatment is the following: \(depressionTreatment). The results will be displayed on your profile underneath the emotion analysis' pie chart and sentiment score results. The newest scores will always be shown first.", preferredStyle: .alert)

            let goHomeAction = UIAlertAction (title: "Exit Test", style: .default) { alertAction in
                
                //If the user selects any answer but the first one (Not at all) on the last question (involving self-harm), then perform a segue to a warning page indicating the user that they selected any answer other than 'Not at all' and that they should contact their personal doctor.
                if self.points != 0 {
                    self.performSegue(withIdentifier: "cbtInfo", sender: self)
                }
                // Otherwise go directly back to the Questionnaires home page.
                else {
                    // Just for security purposes remove all values from the outlets and variables used, whose values need to be saved.
                    self.questionHeader = 0
                    self.atQuestion = 0
                    self.pressedButton = 0
                    self.totalScore = 0
                    self.points = 0
                    self.depressionSeverity = ""
                    self.depressionTreatment = ""
                    
                    // Return to the homepage once "Go home" has been pressed.
                    self.performSegue(withIdentifier: "goBackHome", sender: self)
                }
            }

            alertView.addAction(goHomeAction)
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Display the first question upon launching this class' UI.
        questionHeader = 1
        questionDisplay[0].text = "Question \(questionHeader)/9"
        questionDisplay[1].text = questionsPHQ[atQuestion]
    }
    
    // Based on the range in which the total score falls, the depression severity and treatment variables will be set to a standard answer.
    func phqResult() {
        if totalScore >= 0 && totalScore <= 4 {
            depressionSeverity = "NONE-MINIMAL"
            depressionTreatment = "None"
            
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
            depressionTreatment = "Active treatment with pharmacotherapy and/or psychotherapy"
        }
        else {
            depressionSeverity = "SEVERE"
            depressionTreatment = "Immediate initiation of pharmacotherapy and, if severe impairment or poor response to therapy, expedited referral to a mental health specialist for psychotherapy and/or collaborative management"
        }
    }
}


//MARK: Class to show the warning when the user selects anything but 'Not at all' in the questionnaire's last test.
class CbtInformation: UIViewController {
    
    //IBAaction function to open a website for CBT information and contact details.
    @IBAction func cbtMoreInfo(_ sender: Any) {
        let usefulFunc = UsefulFunctions()
        usefulFunc.openSite(siteName: "https://www.nhs.uk/mental-health/talking-therapies-medicine-treatments/talking-therapies-and-counselling/cognitive-behavioural-therapy-cbt/overview/")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


//MARK: Class of the 'before starting' page for the PHQ-9 questionnaire.
class MainScreenPHQ: UIViewController {
    
    //Varible to store the profile ID of the user, being passed to this class.
    var profileID:Int?
    
    //To open the websited containing the official PHQ-9 documenation.
    @IBAction func infoPHQtest(_ sender: Any) {
        let usefulFunc = UsefulFunctions()
        usefulFunc.openSite(siteName: "https://www.phqscreeners.com/images/sites/g/files/g10016261/f/201412/instructions.pdf")
    }
    
    //Button to start the PHQ-9 test and redirect the user to the test UI.
    @IBAction func startPHQtest(_ sender: Any) {
        self.performSegue(withIdentifier: "toStartPHQtest", sender: self)
    }
    
    //Function used to pass the profile ID of the user taking the test, to the class used to display the PHQ-9 test.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Passing ID of logged in user to the next view controller.
        if segue.identifier == "toStartPHQtest" {
            let receiverVC = segue.destination as! PHQquestionnaire
            receiverVC.profileID = profileID
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
