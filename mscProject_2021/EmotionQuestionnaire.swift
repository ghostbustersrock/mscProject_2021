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
    @IBOutlet var inputText:UITextField!
    @IBOutlet var nextButton:UIButton!
    
//    function called to identify and return the emotion dected using my trained model, and the score of the text using Apple's NLP framework.
    func modelsAnalysis(textToAnalyse: String) -> (myModelRes: String, appleModelRes: Double) {
        let emotionModel = TrainedModel()
        do {
            // Emotion calculatd using my trained model.
            let emotionModelPrediction = try emotionModel.prediction(text: textToAnalyse)
            
            // Score of input text's emotion using Apple's NLP framework.
            let tagger = NLTagger(tagSchemes: [.sentimentScore])
            tagger.string = textToAnalyse
            let sentimentAnalysis = tagger.tag(at: textToAnalyse.startIndex, unit: .paragraph, scheme: .sentimentScore).0
            let appleScore = Double(sentimentAnalysis?.rawValue ?? "0") ?? 0
            
            // Return both results
            return (emotionModelPrediction.label, appleScore)
            
        } catch  {
            print("OH NO AN ERROR OCCURED!!!")
        }
        
        return ("FAILURE", 0.0)
    }
    
    @IBAction func buttonFunc(_ sender: Any) {
        
        if inputText.text == "" {
            // MARK: ALERT NOT TEXT!!!
            print("NO TEXT HAS BEEN INPUTTED!!!")
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
