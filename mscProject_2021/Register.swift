//
//  Register.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 25/05/21.
//

import UIKit

class Register: UIViewController {

    var tigerPress: Bool = false
    var rabbitPress: Bool = false
    var lionPress: Bool = false
    var gorillaPress: Bool = false
    var giraffePress: Bool = false
    var frogPress: Bool = false
    var dogPress: Bool = false
    var catPress: Bool = false
    var bearPress: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var tigerBack: UIButton!
    @IBOutlet var rabbitBack: UIButton!
    @IBOutlet var lionBack: UIButton!
    @IBOutlet var gorillaBack: UIButton!
    @IBOutlet var giraffeBack: UIButton!
    @IBOutlet var frogBack: UIButton!
    @IBOutlet var dogBack: UIButton!
    @IBOutlet var catBack: UIButton!
    @IBOutlet var bearBack: UIButton!
    
    
    @IBAction func tigerFunc(_ sender: Any) {
        tigerPress = !tigerPress
        
        
        if tigerPress {
            tigerBack.backgroundColor = UIColor.green
            
            dogBack.backgroundColor = UIColor.blue
            rabbitBack.backgroundColor = UIColor.blue
            giraffeBack.backgroundColor = UIColor.blue
            gorillaBack.backgroundColor = UIColor.blue
            catBack.backgroundColor = UIColor.blue
            bearBack.backgroundColor = UIColor.blue
            frogBack.backgroundColor = UIColor.blue
            lionBack.backgroundColor = UIColor.blue
        }
        else {
            tigerBack.backgroundColor = UIColor.white
            
            dogBack.backgroundColor = UIColor.red
            rabbitBack.backgroundColor = UIColor.red
            giraffeBack.backgroundColor = UIColor.red
            gorillaBack.backgroundColor = UIColor.red
            catBack.backgroundColor = UIColor.red
            bearBack.backgroundColor = UIColor.red
            frogBack.backgroundColor = UIColor.red
            lionBack.backgroundColor = UIColor.red
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
