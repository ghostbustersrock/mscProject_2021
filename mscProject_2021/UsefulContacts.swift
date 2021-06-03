//
//  UsefulContacts.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 02/06/21.
//

import UIKit

class UsefulContacts: UIViewController {
    
    let funcsToCall = UsefulFunctions()
    
    @IBOutlet var phone_email_text: [UIButton]!
    
    @IBAction func anxietyPhone(_ sender: Any) {
        
        funcsToCall.callNumber(numberToCall: String((phone_email_text[0].titleLabel?.text)!))
    }
    
    @IBAction func anxietyText(_ sender: Any) {
        funcsToCall.textNumber(numberToText: String((phone_email_text[1].titleLabel?.text)!))
    }
    
    @IBAction func anxietySite(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://www.\(String((phone_email_text[2].titleLabel?.text)!))")
    }
    
    @IBAction func beatHelpline(_ sender: Any) {
        funcsToCall.callNumber(numberToCall: String((phone_email_text[3].titleLabel?.text)!))
    }
    
    @IBAction func beatYouth(_ sender: Any) {
        funcsToCall.callNumber(numberToCall: String((phone_email_text[4].titleLabel?.text)!))
    }
    
    @IBAction func beatStudent(_ sender: Any) {
        funcsToCall.callNumber(numberToCall: String((phone_email_text[5].titleLabel?.text)!))
    }
    
    @IBAction func beatSite(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://www.\(String((phone_email_text[6].titleLabel?.text)!))")
    }
    
    @IBAction func carersPhone(_ sender: Any) {
        funcsToCall.callNumber(numberToCall: String((phone_email_text[7].titleLabel?.text)!))
    }
    
    @IBAction func carersEmail(_ sender: Any) {
        funcsToCall.sendEmail(recipientEmail: String((phone_email_text[8].titleLabel?.text)!))
    }
    
    @IBAction func carersSite(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://www.\(String((phone_email_text[9].titleLabel?.text)!))")
    }
    
    @IBAction func hvnSite(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://www.\(String((phone_email_text[10].titleLabel?.text)!))")
    }
    
    @IBAction func mindSite(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://www.\(String((phone_email_text[11].titleLabel?.text)!))")
    }
    
    @IBAction func movemberEmail(_ sender: Any) {
        funcsToCall.sendEmail(recipientEmail: String((phone_email_text[12].titleLabel?.text)!))
    }
    
    @IBAction func movemberSite(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://\(String((phone_email_text[13].titleLabel?.text)!))")
    }
    
    @IBAction func nhsSite(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://www.\(String((phone_email_text[14].titleLabel?.text)!))")
    }
    
    @IBAction func samaritansPhone(_ sender: Any) {
        funcsToCall.callNumber(numberToCall: String((phone_email_text[15].titleLabel?.text)!))
    }
    
    @IBAction func samaritansEmail(_ sender: Any) {
        funcsToCall.sendEmail(recipientEmail: String((phone_email_text[16].titleLabel?.text)!))
    }
    
    @IBAction func samaritansSite(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://www.\(String((phone_email_text[17].titleLabel?.text)!))")
    }
    
    @IBAction func moreContacts(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://www.mind.org.uk/information-support/types-of-mental-health-problems/mental-health-problems-introduction/useful-contacts/")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
