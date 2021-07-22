//
//  ProfileTab.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 27/05/21.
//

import UIKit
import RealmSwift
import Charts // Class to create graphs.

class ProfileTab: UIViewController, ChartViewDelegate {
    
    let realm = try! Realm()

    var profileID: Int? // Where to store the ID of the person signed in.
    var profileImage: String? // Where to store the image of the person signed in.
    var profileUsername: String?
    
    var data:PhqTestResults? // To save the information retrieved from the lists from the PHQ test results Realm class.
    var numberOfElements: Int = 0 // To save the size of the lists of the PHQ test results Realm class.
    var maxIndex: Int = 0
    
    //var emotionsData:EmotionAnalysisResults? // To save the information retrieved from the lists from the Emotion test results Realm class.
    var totalElementsEmotion:Int = 0
    var maxIndexEmotion:Int = 0
    
    @IBOutlet var pieChart: PieChartView! // Outlet to work on the graph view.
    @IBOutlet var sentimentAveScoreLabel: UILabel!
    @IBOutlet var severityText: UILabel!
    @IBOutlet var displayScoreText: UILabel!
    @IBOutlet var numberOfScore: UILabel!
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var profileUsernameDisplay: UILabel!
    
    @IBAction func infoOne(_ sender: Any) {
        
        let msg = ""
        displayResultInfo(infoToDisplay: 0, title: "Emotion Analysis Results", msg: msg)
    }
    
    @IBAction func infoTwo(_ sender: Any) {
        displayResultInfo(infoToDisplay: 1, title: severityText.text!)
    }
    
    func displayResultInfo(infoToDisplay: Int, title: String, msg: String = "") {
        var displayMsg = ""
        var displayTitle = ""
        
        if infoToDisplay == 0 {
            if pieChart.noDataText == "No emotion analysis test taken yet" {
                displayTitle = "N/A"
                displayMsg = "\nFor results and an overall explanation of these above two sections, please take the Emotions Questionnaire, from within the Questionnaires."
            }
            else {
                displayTitle = title
                displayMsg = "\nThe pie chart shows the percentage of how much an emotion has been identified by the three machine learning models during each of the emotion analysis questions.\n\nThe average sentiment score identified by Apple's NLTagger, calculated using each question's sentiment score from this emotion analysis test, is beneath the pie chart. Values tending towards -1 indicate overall a negative sentiment expression identified from your answers, while values tending towards +1 indicate overall a positive sentiment. Values close to 0 indicate overall a neutral sentiment."
            }
        }
        else {
            if title.contains("NONE-MINIMAL") {
                displayTitle = "NONE-MINIMAL"
                displayMsg = "\nTreatment: None"
            }
            else if title.contains("MILD") {
                displayTitle = "MILD"
                displayMsg = "\nTreatment: Watchful waiting; repeat PHQ-9 at follow-up"
            }
            else if title.contains("MODERATELY SEVERE") {
                displayTitle = "MODERATELY SEVERE"
                displayMsg = "\nTreatment: Active treatment with pharmacotherapy and/or psychotherapy"
            }
            else if title.contains("MODERATE") {
                displayTitle = "MODERATE"
                displayMsg = "\nTreatment: Treatment plan, considering counseling, follow-up and/or pharmacotherapy"
            }
            else if title.contains("SEVERE"){
                displayTitle = "SEVERE"
                displayMsg = "\nTreatment: Immediate initiation of pharmacotherapy and, if severe impairment or poor response to therapy, expedited referral to a mental health specialist for psychotherapy and/or collaborative management"
            }
            else {
                displayTitle = "N/A"
                displayMsg = "\nTreatment: No treatment to reccomend because no PHQ-9 test has been taken yet.\n\nPlease take one, within the Questionnaires tab, for your results to be displayed and explained here."
            }
        }
        
        let alertView = UIAlertController(title: displayTitle, message: displayMsg, preferredStyle: .alert)
        
        let exitView = UIAlertAction(title: "Okay", style: .cancel)
        
        alertView.addAction(exitView)
        self.present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        let alertView = UIAlertController(title: "Log out?", message: "Are you sure you want to log out of your profile?", preferredStyle: .alert)
        
        let yesLogOut = UIAlertAction(title: "Yes", style: .destructive) { alertAction in
            self.performSegue(withIdentifier: "logOut", sender: self)
        }
        let noLogOut = UIAlertAction(title: "No", style: .cancel) { alertAction in
        }
        
        alertView.addAction(yesLogOut)
        alertView.addAction(noLogOut)
        self.present(alertView, animated: true, completion: nil)
    }
    
    
    func displayAlert(title: String, msg: String) {
        let alertView = UIAlertController(title: title, message: msg, preferredStyle: .alert)

        let goHomeAction = UIAlertAction (title: "Okay", style: .cancel) {
            alertAction in
        }
        alertView.addAction(goHomeAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func previousPHQ(_ sender: Any) {
        numberOfElements -= 1
        if numberOfElements < 0 {
            numberOfElements += 1
            displayAlert(title: "No more results", msg: "You have reached the oldest result from your PHQ-9 tests.")
        }
        else {
            // Function to display results of PHQ-9 test.
            displayPHQresults(numberElementsPHQ: numberOfElements)
            if numberOfElements == 0 {
                numberOfScore.text = "Oldest PHQ-9 test results"
            }
            else {
                numberOfScore.text = "PHQ-9 test result"
            }
        }
    }
    
    @IBAction func nextPHQ(_ sender: Any) {
        numberOfElements += 1
        if numberOfElements > maxIndex {
            numberOfElements -= 1
            displayAlert(title: "No more results", msg: "You have reached the newest result from your PHQ-9 tests.")
        }
        else {
            // Function to display results of PHQ-9 test.
            displayPHQresults(numberElementsPHQ: numberOfElements)
            if numberOfElements == maxIndex {
                numberOfScore.text = "Newest PHQ-9 test results"
            }
            else {
                numberOfScore.text = "PHQ-9 test result"
            }
        }
    }
    
    // Function to display results of PHQ-9 test.
    func displayPHQresults(numberElementsPHQ: Int) {
        let data = realm.objects(PhqTestResults.self).filter("identifier == %@", profileID!).first
        displayScoreText.text = "Score: \((data?.scoreResPHQ[numberElementsPHQ])!) out of 27"
        severityText.text = "Severity: \((data?.severityResPHQ[numberElementsPHQ])!)"
    }
    
    // Function called everytime the profile tab bar is clicked to refresh the page in order for new content to appear.
    override func viewWillAppear(_ animated: Bool) {
        // Retrieving information from the user signed in.
        data = realm.objects(PhqTestResults.self).filter("identifier == %@", profileID!).first
        // If the user already as data to display, then display it.
        if data != nil {
            numberOfElements = data!.scoreResPHQ.count-1
            maxIndex = data!.scoreResPHQ.count-1
            
            numberOfScore.text = "Newest PHQ-9 test results"
            displayScoreText.text = "Score: \((data?.scoreResPHQ[numberOfElements])!) out of 27"
            severityText.text = "Severity: \((data?.severityResPHQ[numberOfElements])!)"
        }
        else { // Otherwise display nothing.
            maxIndex = 0
            numberOfScore.text = "No PHQ-9 test taken yet"
            displayScoreText.text = "Score: N/A"
            severityText.text = "Severity: N/A"
        }
        
        // Function called to initially display the graph with the most up to date info.
        customizeChart()
    }
    
    // To display the graph of the most up to date information.
    func customizeChart() {
        
        // Returns all the objects based on the supplied ID.
        let emotionsData = realm.objects(EmotionAnalysisResults.self).filter("identifier == %@", profileID!)
        
        //---------------------------------------------------------------------------
        /*
        Title: Charts
        Author: Daniel Cohen Gindi (danielgindi)
        Release date: 2015
        Code version: v4.0.1 Release, 6 Nov. 2020
        Availability: https://github.com/danielgindi/Charts.git */
        
        
        // If the user already has data to display, then display it.
        if emotionsData.count > 0 {
            
            totalElementsEmotion = emotionsData.count-1
            maxIndexEmotion = emotionsData.count-1
            
            //MARK: PLOT GRAPH!!!
            var dataEntries:[ChartDataEntry] = []
            // Plotting the
            for i in 0..<emotionsData[maxIndexEmotion].emotionsDetected.count {
                let dataEntry = PieChartDataEntry(value: emotionsData[maxIndexEmotion].emotionsPercentage[i], label: emotionsData[maxIndexEmotion].emotionsDetected[i], data: emotionsData[maxIndexEmotion].emotionsDetected[i] as AnyObject)
                
                dataEntries.append(dataEntry)
            }

            let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
            
            pieChartDataSet.colors = [UIColor(hex: 0xff6b6b), UIColor(hex: 0xF94144), UIColor(hex: 0xffe66d), UIColor(hex: 0xF9A32B), UIColor(hex: 0xF9C74F), UIColor(hex: 0x90BE6D), UIColor(hex: 0x6AB47C), UIColor(hex: 0x43AA8B), UIColor(hex: 0x577590)]
            
            pieChartDataSet.valueColors = [UIColor.black]

            let pieChartData = PieChartData(dataSet: pieChartDataSet)
            pieChart.data = pieChartData
            pieChart.legend.enabled = false
            
            pieChart.centerText = "Newest\nemotion analysis\nresults"
            
            sentimentAveScoreLabel.text = "Sentiment average score: \(emotionsData[totalElementsEmotion].sentimentAverage)"
        }
        else { // Otherwise display nothing.
            pieChart.noDataText = "No emotion analysis test taken yet"
            sentimentAveScoreLabel.text = "Sentiment average score: N/A"
        }
        //---------------------------------------------------------------------------
    }
    
    func displayGraph(totalElementsEmotionFunc: Int) {
        let emotionsData = realm.objects(EmotionAnalysisResults.self).filter("identifier == %@", profileID!)
        var dataEntries:[ChartDataEntry] = []
        // Plotting the
        
        //---------------------------------------------------------------------------
        /*
        Title: Charts
        Author: Daniel Cohen Gindi (danielgindi)
        Release date: 2015
        Code version: v4.0.1 Release, 6 Nov. 2020
        Availability: https://github.com/danielgindi/Charts.git */
        
        // emotionsData[totalElementsEmotion].emotionsDetected List<String>
        for i in 0..<emotionsData[totalElementsEmotionFunc].emotionsDetected.count {
            let dataEntry = PieChartDataEntry(value: emotionsData[totalElementsEmotionFunc].emotionsPercentage[i], label: emotionsData[totalElementsEmotionFunc].emotionsDetected[i], data: emotionsData[totalElementsEmotionFunc].emotionsDetected[i] as AnyObject)
            
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        pieChartDataSet.colors = [UIColor(hex: 0xff6b6b), UIColor(hex: 0xF94144), UIColor(hex: 0xffe66d), UIColor(hex: 0xF9A32B), UIColor(hex: 0xF9C74F), UIColor(hex: 0x90BE6D), UIColor(hex: 0x6AB47C), UIColor(hex: 0x43AA8B), UIColor(hex: 0x577590)]
        
        pieChartDataSet.valueColors = [UIColor.black]
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChart.data = pieChartData
        
        sentimentAveScoreLabel.text = "Sentiment average score: \(emotionsData[totalElementsEmotion].sentimentAverage)"
        pieChart.legend.enabled = false
        
        //---------------------------------------------------------------------------
    }
    
    
    
    @IBAction func newerEmotionsButton(_ sender: Any) {
        totalElementsEmotion += 1
        if totalElementsEmotion > maxIndexEmotion {
            totalElementsEmotion -= 1
            displayAlert(title: "No more results", msg: "You have reached the newest result from your emotionAnalysis tests.")
        }
        else {
            // Call function to display graph's data.
            displayGraph(totalElementsEmotionFunc: totalElementsEmotion)
            
            if totalElementsEmotion == maxIndexEmotion {
                pieChart.centerText = "Newest\nemotion analysis\nresults"
            }
            else {
                pieChart.centerText = "Emotion analysis\nresults"
            }
        }
    }
    
    @IBAction func olderEmotionsButton(_ sender: Any) {
        totalElementsEmotion -= 1
        if totalElementsEmotion < 0 {
            totalElementsEmotion += 1
            displayAlert(title: "No more results", msg: "You have reached the oldest result from your emotion analysis tests.")
        }
        else {
            // Call function to display graph's data.
            displayGraph(totalElementsEmotionFunc: totalElementsEmotion)
            
            if totalElementsEmotion == 0 {
                pieChart.centerText = "Oldest\nemotion analysis\nresults"
            }
            else {
                pieChart.centerText = "Emotion analysis\nresults"
            }
        }
    }

    
    // Function called to execute code only once when the view is presented the first time.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChart.highlightPerTapEnabled = false
        pieChart.holeColor = .clear
        
        
        // Passing the ID of the logged in user to the 'Questionnaires' tab-bar. This is necessary so to save the result of the questionnaires for the relative logged in user.
        let navigationController = self.tabBarController!.viewControllers![1] as! UINavigationController
        let destination = navigationController.topViewController as! TabBarPHQ
        destination.profileID = profileID!
        
        profileUsernameDisplay.text = "Welcome back \(String(describing: profileUsername!))"
        profilePic.image = UIImage(named: profileImage!)
    }
}

// Extension to use in case we want to display the proile images rounded.
extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.borderWidth = 4
    }
}
