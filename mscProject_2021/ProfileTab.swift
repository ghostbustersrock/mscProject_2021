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

    var profileID: Int? // Where to store the ID of the person signed in.
    var profileImage: String? // Where to store the image of the person signed in.
    var profileName: String?
    var profileUsername: String?
    
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var profilename: UILabel!
    @IBOutlet var profileUsernameDisplay: UILabel!
    
    @IBAction func createGraph(_ sender: Any) {
        
    }
    
    @IBAction func updateGraph(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilename.text = profileName
        profileUsernameDisplay.text = profileUsername
        profilePic.image = UIImage(named: profileImage!)
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
