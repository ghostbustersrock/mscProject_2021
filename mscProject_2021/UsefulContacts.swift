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
    
    
    @IBAction func anxietySite(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://www.\(String((phone_email_text[0].titleLabel?.text)!))")
    }
    
    
    @IBAction func beatSite(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://www.\(String((phone_email_text[1].titleLabel?.text)!))")
    }
    
    @IBAction func carersSite(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://www.\(String((phone_email_text[2].titleLabel?.text)!))")
    }
    
    @IBAction func hvnSite(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://www.\(String((phone_email_text[3].titleLabel?.text)!))")
    }
    
    @IBAction func mindSite(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://www.\(String((phone_email_text[4].titleLabel?.text)!))")
    }
    
    @IBAction func movemberSite(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://\(String((phone_email_text[5].titleLabel?.text)!))")
    }
    
    @IBAction func nhsSite(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://www.\(String((phone_email_text[6].titleLabel?.text)!))")
    }
    
    @IBAction func samaritansSite(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://www.\(String((phone_email_text[7].titleLabel?.text)!))")
    }
    
    @IBAction func moreContacts(_ sender: Any) {
        funcsToCall.openSite(siteName: "https://www.mind.org.uk/information-support/types-of-mental-health-problems/mental-health-problems-introduction/useful-contacts/")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
