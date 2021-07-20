//
//  EmotionQuestionnaire.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 04/07/21.
//

import UIKit
import NaturalLanguage // For Apple's sentiment analysis score retrieval.
import CoreML
import RealmSwift


// MARK: EmotionQuestionnaire class
// This class is for the emotion analysis questionnaire itself where my trained model and Apple's NLP framework are applied to calculate the results from the user's input.
class EmotionQuestionnaire: UIViewController {
    
    // Where to store the ID of the logged in user passed from the HomeQuestionnaireAnalysis view controller.
    var profileID:Int?
    
    // Array and variable to store all the emotions and sentiment text scores found for each question.
    var emotionsQsDetected:[String] = []
    var qsSentimentScores:[Double] = []
    
    let questionsToDisplay:[String] = ["Describe how you are feeling and what is on your mind.", "Describe how you have been feeling in the past two weeks.", "Describe how something new recently made you feel.", "Describe how you are feeling mentally and physically.", "What are your thoughts telling you about yourself?"]
    
    var atQuestion:Int = 0
    var questionNumber:Int = 0
    
    @IBOutlet var displayQuestion:UILabel!
    @IBOutlet var inputText: UITextView!
    @IBOutlet var nextButton:UIButton!
    
//    function called to identify and return the emotion dected using my trained model, and the score of the text using Apple's NLP framework.
    func modelsAnalysis(textToAnalyse: String) {
        // Creating an instance of the three emotion detecting models I created.
        let model1 = TrainedModel1()
        let model2 = TrainedModel2()
        let model3 = TrainedModel3()
        
        do {
            // Predicting the text's emotion using all three models.
            let model1Pred = try model1.prediction(text: textToAnalyse)
            let model2Pred = try model2.prediction(text: textToAnalyse)
            let model3Pred = try model3.prediction(text: textToAnalyse)
            
            // Score of input text's emotion using Apple's NLP framework.
            let tagger = NLTagger(tagSchemes: [.sentimentScore])
            tagger.string = textToAnalyse
            let sentimentAnalysis = tagger.tag(at: textToAnalyse.startIndex, unit: .paragraph, scheme: .sentimentScore).0
            let appleScore = Double(sentimentAnalysis?.rawValue ?? "0") ?? 0
            
            // MARK: Saving stuff in class variables!!!
            emotionsQsDetected.append(model1Pred.label)
            emotionsQsDetected.append(model2Pred.label)
            emotionsQsDetected.append(model3Pred.label)
            qsSentimentScores.append(appleScore)
            
            // For DEBUGGING purposes!!!
            print("##########################")
            // Printing each model's results.
            print("Model 1 results: \(model1Pred.label)")
            print("Model 2 results: \(model2Pred.label)")
            print("Model 3 results: \(model3Pred.label)")
            print("Apple model result: \(appleScore)")
            print("##########################")
            
        } catch  {
            // If an error occurs during the emotion sentiment analysis, print an alert with the error and exit the questionnaire.
            let alertView = UIAlertController(title: "Error!", message: "The following error occured: \(error). Please exit the questionnaire.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Exit", style: .default) {
                alertAction in
                
                self.performSegue(withIdentifier: "errorExitQs", sender: self)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    func alertMessage(msg: String) {
        // Alert displayed if 'next' is pressed with not inputted text.
        let alertView = UIAlertController(title: "Warning", message: msg, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Ok", style: .cancel) {
            alertAction in
        }
        alertView.addAction(okayAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func buttonFunc(_ sender: Any) {
        
        if inputText.text.isEmpty {
            alertMessage(msg: "Please input some text before pressing the 'next' button. Thank you.")
        }
        else if !inputText.text.contains(" ") || inputText.text.count == 1 {
            alertMessage(msg: "Please input a more descriptive answer. A good amount would be one to two sentences. Thank you.")
        }
        else {
            let textToAnalyse = inputText.text!
            inputText.text = ""
            atQuestion += 1
            questionNumber += 1
            
            modelsAnalysis(textToAnalyse: textToAnalyse)
            
            if atQuestion == 4 {
                displayQuestion.text = "Question \(questionNumber+1): \(questionsToDisplay[questionNumber])"
                nextButton.setTitle("FINISH", for: .normal)
            }
            else if atQuestion < 5 {
                displayQuestion.text = "Question \(questionNumber+1): \(questionsToDisplay[questionNumber])"
            }
            else {
                self.performSegue(withIdentifier: "endAnalysis", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "endAnalysis" {
            let receiverVC = segue.destination as! ResultEmotionAnalysis
            receiverVC.emotionsDetected = emotionsQsDetected
            receiverVC.sentimentsDetected = qsSentimentScores
            receiverVC.profileID = profileID
            
            // Removing all elements just to be safe once the values have been passed.
            emotionsQsDetected.removeAll()
            qsSentimentScores.removeAll()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayQuestion.text = "Question \(questionNumber+1): \(questionsToDisplay[questionNumber])"
    }
}


// MARK: ResultEmotionAnalysis class
// This class is used for the UI to display the results of the emotion analysis.
class ResultEmotionAnalysis: UIViewController {
    
    // Where to store the ID of the logged in user passed from the HomeQuestionnaireAnalysis view controller.
    var profileID:Int?
    var emotionsDetected:[String]?
    var sentimentsDetected:[Double]?
    var percentagesEmotions:[String: Double] = [:]
    
    @IBOutlet var resultsQ1: UILabel!
    @IBOutlet var resultsQ2: UILabel!
    @IBOutlet var resultsQ3: UILabel!
    @IBOutlet var resultsQ4: UILabel!
    @IBOutlet var resultsQ5: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsQ1.text = "\(emotionsDetected![0]), \(emotionsDetected![1]), \(emotionsDetected![2]), \(sentimentsDetected![0])"
        
        resultsQ2.text = "\(emotionsDetected![3]), \(emotionsDetected![4]), \(emotionsDetected![5]), \(sentimentsDetected![1])"
        
        resultsQ3.text = "\(emotionsDetected![6]), \(emotionsDetected![7]), \(emotionsDetected![8]), \(sentimentsDetected![2])"
        
        resultsQ4.text = "\(emotionsDetected![9]), \(emotionsDetected![10]), \(emotionsDetected![11]), \(sentimentsDetected![3])"
        
        resultsQ5.text = "\(emotionsDetected![12]), \(emotionsDetected![13]), \(emotionsDetected![14]), \(sentimentsDetected![4])"
        
        calculatePercentages()
        
    }
    
    func calculatePercentages() {
        // Average of all the sentiment text scores.
        let averageSentiments = ((sentimentsDetected?.reduce(0, +))!)/5
        
        print(averageSentiments)
        
        for item in emotionsDetected! {
            percentagesEmotions[item] = (percentagesEmotions[item] ?? 0) + 1
        }
        
        print(percentagesEmotions)
        
        // These two arrays are used to store the information of the emotions detected and their calculated percentages, seperately on two differnt arrays.
        var emotions:[String] = []
        var calculatedPercent:[Double] = []
        
        // Convert total count of emotions into percentages
        for (key, _) in percentagesEmotions {
            let percentage = (percentagesEmotions[key]! * 100)/15
            // Rounding to two decimal places.
            // Storing the dictionary's key and percent values separately on two different arrays for realm.
            calculatedPercent.append(round(100*percentage)/100) //percents in two decimal places.
            emotions.append(key) //keys.
        }
        
        //Function called to save information for the graph on Realm.
        saveInfoForGraph(emotionDetected: emotions, percentEmotion: calculatedPercent, sentimentAverage: averageSentiments)
    }
    
    func saveInfoForGraph(emotionDetected: [String], percentEmotion: [Double], sentimentAverage: Double) {
        let realm = try! Realm()
        // Storing new items in Realm properties.
        // ##########################################
        let emotionResults = EmotionAnalysisResults()
        emotionResults.identifier = profileID!
        
        for x in emotionDetected {
            emotionResults.emotionsDetected.append(x)
        }
        for x in percentEmotion {
            emotionResults.emotionsPercentage.append(x)
        }
        
        //Rounding the average sentiment score to two decimal places.
        emotionResults.sentimentAverage = round(100*sentimentAverage)/100
        // ##########################################
        
        realm.beginWrite()
        realm.add(emotionResults)
        try! realm.commitWrite()
    }
    
    @IBAction func exitButton(_ sender: Any) {
        
    }
}


// MARK: HomeQuestionnaireAnalysis class
// This class is used for the home of the emotion analysis test, where information and the start button are presented to the user.
class HomeQuestionnaireAnalysis: UIViewController {
    
    // Where to store the ID of the logged in user passed from the TabBarPHQ view controller.
    var profileID:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButton(_ sender: Any) {
        self.performSegue(withIdentifier: "startAnalysisQ", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startAnalysisQ" {
            let receiverVC = segue.destination as! EmotionQuestionnaire
            receiverVC.profileID = profileID
        }
    }
    
}
