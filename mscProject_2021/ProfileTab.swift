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
                numberOfScore.text = ""
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
                numberOfScore.text = ""
            }
        }
    }
    
    // Function to display results of PHQ-9 test.
    func displayPHQresults(numberElementsPHQ: Int) {
        let data = realm.objects(PhqTestResults.self).filter("identifier == %@", profileID!).first
        displayScoreText.text = "\((data?.scoreResPHQ[numberElementsPHQ])!)/27"
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
            
            numberOfScore.text = "Newest Results"
            displayScoreText.text = "\((data?.scoreResPHQ[numberOfElements])!)/27"
            severityText.text = "Severity: \((data?.severityResPHQ[numberOfElements])!)"
        }
        else { // Otherwise display nothing.
            maxIndex = 0
            numberOfScore.text = "No PHQ-9 test taken yet"
            displayScoreText.text = "N/A"
            severityText.text = "Severity: N/A"
        }
        
        // Function called to initially display the graph with the most up to date info.
        customizeChart()
    }
    
    // To display the graph of the most up to date information.
    func customizeChart() {
        
        // Returns all the objects based on the supplied ID.
        let emotionsData = realm.objects(EmotionAnalysisResults.self).filter("identifier == %@", profileID!)
        
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
            pieChartDataSet.colors = ChartColorTemplates.colorful()
            

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
    }
    
    
    func displayGraph(totalElementsEmotionFunc: Int) {
        let emotionsData = realm.objects(EmotionAnalysisResults.self).filter("identifier == %@", profileID!)
        var dataEntries:[ChartDataEntry] = []
        // Plotting the
        
        // emotionsData[totalElementsEmotion].emotionsDetected List<String>
        for i in 0..<emotionsData[totalElementsEmotionFunc].emotionsDetected.count {
            let dataEntry = PieChartDataEntry(value: emotionsData[totalElementsEmotionFunc].emotionsPercentage[i], label: emotionsData[totalElementsEmotionFunc].emotionsDetected[i], data: emotionsData[totalElementsEmotionFunc].emotionsDetected[i] as AnyObject)
            
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        pieChartDataSet.colors = ChartColorTemplates.colorful()
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChart.data = pieChartData
        
        sentimentAveScoreLabel.text = "Sentiment average score: \(emotionsData[totalElementsEmotion].sentimentAverage)"
        pieChart.legend.enabled = false
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
//            sentimentAveScoreLabel.text = "Sentiment average score: \(emotionsData[totalElementsEmotion].sentimentAverage)"
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
