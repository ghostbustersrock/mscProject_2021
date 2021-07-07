//
//  EmotionQuestionnaire.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 04/07/21.
//

import UIKit
import NaturalLanguage // For Apple's sentiment analysis score retrieval.
import CoreML

// This class is for the emotion analysis questionnaire itself where my trained model and Apple's NLP framework are applied to calculate the results from the user's input.
class EmotionQuestionnaire: UIViewController {
    
    var atQuestion:Int = 0
    var questionNumber:Int = 0
    
    @IBOutlet var displayQuestion:UILabel!
    @IBOutlet var inputText: UITextView!
    @IBOutlet var nextButton:UIButton!
    
//    function called to identify and return the emotion dected using my trained model, and the score of the text using Apple's NLP framework.
    func modelsAnalysis(textToAnalyse: String) -> (myModelRes: String, appleModelRes: Double) {
        
        // Creating an instance of the three emotion detecting models I created.
        let model1 = TrainedModel1()
        let model2 = TrainedModel2()
        let model3 = TrainedModel3()
        
        do {
            // Predicting the text's emotion using all three models.
            let model1Pred = try model1.prediction(text: textToAnalyse)
            let model2Pred = try model2.prediction(text: textToAnalyse)
            let model3Pred = try model3.prediction(text: textToAnalyse)
            
            // MARK: Debug purposes
            // Printing each model's results.
            print("##########################")
            print("KAGGLE 1 RESULT: \(model1Pred.label)")
            print("KAGGLE 2 RESULT: \(model2Pred.label)")
            print("KAGGLE 3 RESULT: \(model3Pred.label)")
            print("##########################")
            
            // Score of input text's emotion using Apple's NLP framework.
            let tagger = NLTagger(tagSchemes: [.sentimentScore])
            tagger.string = textToAnalyse
            let sentimentAnalysis = tagger.tag(at: textToAnalyse.startIndex, unit: .paragraph, scheme: .sentimentScore).0
            let appleScore = Double(sentimentAnalysis?.rawValue ?? "0") ?? 0
            
            // Return both results
            return ("prova", appleScore)
            
        } catch  {
            print("OH NO AN ERROR OCCURED!!!")
        }
        return ("FAILURE", 0.0)
    }
    
    @IBAction func buttonFunc(_ sender: Any) {
        
        if inputText.text == "" {
            // Alert displayed if 'next' is pressed with not inputted text.
            let alertView = UIAlertController(title: "Warning", message: "Please input text before pressing the 'next' button. Thank you!", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Ok", style: .cancel) {
                alertAction in
            }
            alertView.addAction(okayAction)
            self.present(alertView, animated: true, completion: nil)
        }
        else {
            let textToAnalyse = inputText.text!
            inputText.text = ""
            atQuestion += 1
            questionNumber += 1
            
            let modelResults = modelsAnalysis(textToAnalyse: textToAnalyse)
            print("My model result: \(modelResults.myModelRes)")
            print("Apple model result: \(modelResults.appleModelRes)")
            
            if atQuestion == 4 {
                displayQuestion.text = "Question \(questionNumber)"
                nextButton.setTitle("FINISH", for: .normal)
            }
            else if atQuestion < 5 {
                displayQuestion.text = "Question \(questionNumber)"
            }
            else {
                self.performSegue(withIdentifier: "endAnalysis", sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionNumber = 1
        displayQuestion.text = "Question \(questionNumber)"
    }
}


// This class is used for the UI to display the results of the emotion analysis.
class ResultEmotionAnalysis: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func exitButton(_ sender: Any) {
        
    }
}


// This class is used for the home of the emotion analysis test, where information and the start button are presented to the user.
class HomeQuestionnaireAnalysis: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButton(_ sender: Any) {
        self.performSegue(withIdentifier: "startAnalysisQ", sender: self)
    }
    
    @IBAction func homeAnalysis(segue: UIStoryboardSegue) {

    }
}
