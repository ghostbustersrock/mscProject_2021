//
//  UsefulFunctions.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 02/06/21.
//

import Foundation
import UIKit
import MessageUI // To open the text message and email composition emails.

// This class contains useful functions (i.e. to make calls) used in various other classes.
class UsefulFunctions: UIViewController, MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {
    
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
    
    func callNumber(numberToCall: String) {
        if let call = NSURL(string: "TEL://\(numberToCall)") {
            UIApplication.shared.open(call as URL, options: [:], completionHandler: nil)
        }
        else {
//          create an alert with error message!!!
        }
    }
    
    func textNumber(numberToText: String) {
        let msgToSend = MFMessageComposeViewController()
        msgToSend.recipients = [numberToText]
        msgToSend.messageComposeDelegate = self
        self.present(msgToSend, animated: true, completion: nil)
    }
    
    func sendEmail(recipientEmail: String) {
        // Check if the user has an email set on the device allowing for a successful email to be sent from their account.
        if MFMailComposeViewController.canSendMail() {
            let mailToSend = MFMailComposeViewController()
            mailToSend.delegate = self
            mailToSend.setToRecipients([recipientEmail])
            present(UINavigationController(rootViewController: mailToSend), animated: true, completion: nil)
        }
        else {
//            create an alert with an error message!!!
        }
    }
    
    // To tell the delegate that the user finished composing the text message.
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        // Do nothing
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil) //Once we are done with the email dismiss the view controller (its pop-up).
    }
}
