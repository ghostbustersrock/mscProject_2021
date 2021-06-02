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
//        funcsToCall.callNumber(numberToCall: String((phone_email_text[1].titleLabel?.text!)!))
        print(String((phone_email_text[1].titleLabel?.text!)!))
    }
    
    @IBAction func anxietyText(_ sender: Any) {
    }
    
    @IBAction func anxietySite(_ sender: Any) {
    }
    
    @IBAction func beatHelpline(_ sender: Any) {
    }
    
    @IBAction func beatYouth(_ sender: Any) {
    }
    
    @IBAction func beatStudent(_ sender: Any) {
    }
    
    @IBAction func beatSite(_ sender: Any) {
    }
    
    @IBAction func carersPhone(_ sender: Any) {
    }
    
    @IBAction func carersEmail(_ sender: Any) {
    }
    
    @IBAction func carersSite(_ sender: Any) {
    }
    
    @IBAction func hvnSite(_ sender: Any) {
    }
    
    @IBAction func mindSite(_ sender: Any) {
    }
    
    @IBAction func movemberEmail(_ sender: Any) {
    }
    
    @IBAction func movemberSite(_ sender: Any) {
    }
    
    @IBAction func nhsSite(_ sender: Any) {
    }
    
    @IBAction func samaritansPhone(_ sender: Any) {
    }
    
    @IBAction func samaritansEmail(_ sender: Any) {
    }
    
    @IBAction func samaritansSite(_ sender: Any) {
    }
    
    @IBAction func moreContacts(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
