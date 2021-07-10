//
//  UsefulFunctions.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 02/06/21.
//

import Foundation
import UIKit
import MessageUI // To open the text message and email composition emails.

// This class contains useful functions (i.e. to open websites) used in various other classes.

class UsefulFunctions: UIViewController {
    
    // Function to display an alert pop-up with a title and message.
    func displayAlert(displayTitle: String, msg: String) {
        let defAction = UIAlertController(title: displayTitle, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel) {
            alertAction in
        }
        
        defAction.addAction(okAction)
        self.present(defAction, animated: true, completion: nil)
    }
    
    func openSite(siteName: String) {
        UIApplication.shared.open(URL(string: siteName)! as URL, options: [:], completionHandler: nil)
    }
}
