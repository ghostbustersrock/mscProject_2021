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

    @IBOutlet var profilePic: UIImageView!
    
    @IBAction func createGraph(_ sender: Any) {
        
    }
    
    @IBAction func updateGraph(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.roundedImage()
        // Do any additional setup after loading the view.
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
