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
    
    
    @IBOutlet var pieChart: PieChartView!
    var sampleData1 = PieChartDataEntry(value: 0)
    var sampleData2 = PieChartDataEntry(value: 1)
    var sampleData3 = PieChartDataEntry(value: 2)
    var dataSet = [PieChartDataEntry]()
    
    
    
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
            let data = realm.objects(PhqTestResults.self).filter("identifier == %@", profileID!).first
            
            if numberOfElements == 0 {
                numberOfScore.text = "Oldest Results"
            }
            else {
                numberOfScore.text = ""
            }
            displayScoreText.text = "\((data?.scoreResPHQ[numberOfElements])!)/27"
            severityText.text = "Severity: \((data?.severityResPHQ[numberOfElements])!)"
        }
    }
    
    @IBAction func nextPHQ(_ sender: Any) {
        numberOfElements += 1
        if numberOfElements > maxIndex {
            numberOfElements -= 1
            displayAlert(title: "No more results", msg: "You have reached the newest result from your PHQ-9 tests.")
        }
        else {
            let data = realm.objects(PhqTestResults.self).filter("identifier == %@", profileID!).first
            
            if numberOfElements == maxIndex {
                numberOfScore.text = "Newest Results"
            }
            else {
                numberOfScore.text = ""
            }
            displayScoreText.text = "\((data?.scoreResPHQ[numberOfElements])!)/27"
            severityText.text = "Severity: \((data?.severityResPHQ[numberOfElements])!)"
        }
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
            numberOfScore.text = "No results"
            displayScoreText.text = "N/A"
            severityText.text = "Severity: N/A"
        }
        
        
        pieChart.centerText = "Emotion analysis\nresults"
        pieChart.legend.enabled = false
        customizeChart(dataPoints: players, values: goals)
    }
    
    // Creating an instanceo of the pie chart class to create a pie chart.
    let players = ["Luca", "Arseniy", "Estefano"]
    let goals = [10, 13, 5]
    
    func customizeChart(dataPoints: [String], values: [Int]) {
        var dataEntries:[ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: Double(values[i]), label: dataPoints[i], data: dataPoints[i] as AnyObject)
            
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        pieChartDataSet.colors = ChartColorTemplates.colorful()
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        pieChart.data = pieChartData
    }
    
    // Function called to execute code only once when the view is presented the first time.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Passing the ID of the logged in user to the 'Questionnaires' tab-bar. This is necessary so to save the result of the questionnaires for the relative logged in user.
        let navigationController = self.tabBarController!.viewControllers![2] as! UINavigationController
        let destination = navigationController.topViewController as! TabBarPHQ
        destination.profileID = profileID!
        
        profileUsernameDisplay.text = "Welcome back \(String(describing: profileUsername!))"
        profilePic.image = UIImage(named: profileImage!)
        profilePic.roundedImage()
    }
}

extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.borderWidth = 4
    }
}
