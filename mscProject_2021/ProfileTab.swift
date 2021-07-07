//
//  ProfileTab.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 27/05/21.
//

//import Charts
import UIKit
import RealmSwift

class ProfileTab: UIViewController {
    
    let realm = try! Realm()

    var profileID: Int? // Where to store the ID of the person signed in.
    var profileImage: String? // Where to store the image of the person signed in.
    var profileName: String?
    var profileUsername: String?
    
    var data:PhqTestResults? // To save the information retrieved from the lists from the PHQ test results Realm class.
    var numberOfElements: Int = 0 // To save the size of the lists of the PHQ test results Realm class.
    var maxIndex: Int?
    
    @IBOutlet var severityText: UILabel!
    @IBOutlet var displayScoreText: UILabel!
    @IBOutlet var numberOfScore: UILabel!
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var profilename: UILabel!
    @IBOutlet var profileUsernameDisplay: UILabel!
    
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
        if numberOfElements > maxIndex! {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieving information from the user signed in.
        data = realm.objects(PhqTestResults.self).filter("identifier == %@", profileID!).first
        print(data!.scoreResPHQ.count)
        // If the user already as data to display, then display it.
        if data != nil {
            numberOfElements = data!.scoreResPHQ.count-1
            maxIndex = data!.scoreResPHQ.count-1
            
            numberOfScore.text = "Newest Results"
            displayScoreText.text = "\((data?.scoreResPHQ[numberOfElements])!)/27"
            severityText.text = "Severity: \((data?.severityResPHQ[numberOfElements])!)"
        }
        else { // Otherwise display nothing.
            numberOfScore.text = "No results"
            displayScoreText.text = "N/A"
            severityText.text = "N/A"
        }
        
        // Passing the ID of the logged in user to the 'Questionnaires' tab-bar. This is necessary so to save the result of the questionnaires for the relative logged in user.
        let navigationController = self.tabBarController!.viewControllers![3] as! UINavigationController
        let destination = navigationController.topViewController as! TabBarPHQ
        destination.profileID = profileID!
        
        profilename.text = profileName
        profileUsernameDisplay.text = profileUsername
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
