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
    
    var questionsAlreadyAsked:[Int] = []
    
    let questionsToDisplay = ["Describe how you are feeling right now.", "Describe what is on your mind right now.", "Describe how you have been feeling this past week.", "Describe how something new recently made you feel.", "Describe how you are feeling mentally.", "Describe how you are feeling physically.", "What are your thoughts telling you about yourself right now?", "Describe what you think awaits you tomorrow.", "Describe how you would react to a sudden eventful change to your day right now.", "What would you tell your future self right now?", "Describe how recently, not having achieved something you wanted, made you feel.", "What are you expecting from yourself right now?", "Do you feel you are a glass half empty or full person right now and why?", "Do you feel you have the capability for real change in your life? Why or why not?", "Are you proud of the person you are today? Why or why not?", "Describe how you felt when you woke up this morning.", "How would you describe your current energy levels?", "Describe how, recently, eating has felt for you.", "Describe how, recently, you feel about your free time.", "Describe how, meeting someone new right now, would make you feel.", "Describe how, spending time by yourself or being alone right now, would make you feel."]
    
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
            
            modelsAnalysis(textToAnalyse: textToAnalyse)
            
            if atQuestion == 4 {
                displayQuestion.text = "Question \(atQuestion+1): \(questionsToDisplay[returnRandomNumber()])"
                nextButton.setTitle("FINISH", for: .normal)
            }
            else if atQuestion < 5 {
                displayQuestion.text = "Question \(atQuestion+1): \(questionsToDisplay[returnRandomNumber()])"
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
            questionsAlreadyAsked.removeAll()
        }
    }
    
    func returnRandomNumber() -> Int {
        var randomNumb = Int.random(in: 0..<21)
        
        while questionsAlreadyAsked.contains(randomNumb) {
            randomNumb = Int.random(in: 0..<21)
        }
        
        questionsAlreadyAsked.append(randomNumb)
        return randomNumb
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayQuestion.text = "Question \(atQuestion+1): \(questionsToDisplay[returnRandomNumber()])"
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
    
    @IBAction func interpretResults(_ sender: Any) {
        
        let msgToDisplay = "The first three values are the emotions detected by each trained machine model, while the decimal number (positive or negative) is the sentiment score. The application will count the number of times each emotion occured, throughout each question, and then calculate its percentage. These percentages, along to the emotion they relate to, will then be displayed on a pie chart on your profile The newest results will always be shown first.  The sentiment score will be displayed underneath the pie chart as an average, found using each question's sentiment score.  As these are not professional trained models, the identified emotions should always be taken with a pinch of salt. The sentiment score values are used to validate whether the identified emotions from the models are close to correct, in identifying the emotions the user was trying to transpire."
        
        let alertView = UIAlertController(title: "Interpreting the Results", message: msgToDisplay, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okay", style: .cancel)
        alertView.addAction(alertAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
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
    
    func displayInformation(title: String, msg: String) {
        let alertView = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okay", style: .cancel)
        alertView.addAction(alertAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func moreInfoED(_ sender: Any) {
        let msgToDisplay = "The emotion analysis questionnaire uses three trained machine learning models to detect for each question's response an emotion. Each model was trained with a dataset comprising of textual inputs and an emotion assigned to it, classifying the emotion that textual input was portraying. Three models are used in the emotion analysis questionnaire, so to have more accuracy in detecting emotions within a user's reponse, rather than having only one model identify a single emotion.   The detectable emotions are nine: sadness, anger, joy, fear, happy, worry, hate, relief and boredom."
        
        displayInformation(title: "Emotions Detected", msg: msgToDisplay)
    }
    
    @IBAction func moreInfoSS(_ sender: Any) {
        let msgToDisplay = "Along the three implemented machine leanring models, Apple's NLTagger class will be used to assign to each question's response a decimal value in the range of -1 and +1. This class analyzes a text's language so to a sentiment score of it, meaning how positive (+1 being very positive) or negative (-1 being very negative) the user expressed themselves in their answer. Receiving a score of 0 means the text was identified as emotionally neutral."
        
        displayInformation(title: "Sentiment Score", msg: msgToDisplay)
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
