//
//  TabBarPHQ.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 30/06/21.
//

import UIKit

class TabBarPHQ: UIViewController {

    var profileID:Int? //The profile ID of the user taking the PHQ-9 test.
    
    @IBAction func phqTest(_ sender: Any) {
        self.performSegue(withIdentifier: "toPHQtest", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("THIS IS THE LOG IN ID: \(profileID!)!!!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Passing ID of logged in user to the next view controller.
        if segue.identifier == "toPHQtest" {
            let receiverVC = segue.destination as! MainScreenPHQ
            receiverVC.profileID = profileID
        }
    }
}
