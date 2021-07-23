//
//  CausesMHtts.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 21/07/21.
//

import UIKit
import AVFoundation // Library for the TTS to be used.

//MARK: Class for the Causes of Mental Health section from the help info tab bar section.
class CausesMHtts: UIViewController {

    //MARK: NOTE: all the information displayed is taken from mind.org.uk
    
    //Collection of outlets respectively for, the buttons to start the TTS and the text for the TTS to read.
    @IBOutlet var playButtons: [UIButton]!
    @IBOutlet var textToSpeak: [UILabel]!
    
    // These two lines of code are used to allow the TTS to read the present text.
    // Synthesizer object
    let synthesizer = AVSpeechSynthesizer()
    // Utterance object
    var utterance = AVSpeechUtterance(string: "")
    
    //Createing an instance of the class containing important functions common to be used throughout the application.
    let usefulFuncs = UsefulFunctions()
    
    // To start the first TTS reader.
    @IBAction func playButton1(_ sender: Any) {
        usefulFuncs.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[0], tts: textToSpeak[0].text!)
    }
    
    // To start the second TTS reader.
    @IBAction func playButton2(_ sender: Any) {
        usefulFuncs.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[1], tts: textToSpeak[1].text!)
    }
    
    // To start the third TTS reader.
    @IBAction func playButton3(_ sender: Any) {
        usefulFuncs.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[2], tts: textToSpeak[2].text!)
    }
    
    // To start the fourth TTS reader.
    @IBAction func playButton4(_ sender: Any) {
        usefulFuncs.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[3], tts: textToSpeak[3].text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

//MARK: Class for the Self Care section of the help info tab bar section.
class SelfCare: UIViewController {
    
    //MARK: NOTE: all the information displayed is taken from mind.org.uk
    
    // These two lines of code are used to allow the TTS to read the present text.
    // Synthesizer object
    let synthesizer = AVSpeechSynthesizer()
    // Utterance object
    var utterance = AVSpeechUtterance(string: "")
    
    let usefulFunctions = UsefulFunctions()
    
    @IBOutlet var buttonPressed: UIButton!
    @IBOutlet var ttsText: UILabel!
    
    var complete_text:String?
    
    // To start the TTS reader.
    @IBAction func buttonPressed1(_ sender: Any) {
        usefulFunctions.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: buttonPressed, tts: complete_text!)
    }
    
    //Action to open a website when its button is clicked.
    @IBAction func linkt_to_site(_ sender: Any) {
        usefulFunctions.openSite(siteName: "https://www.mind.org.uk/information-support/types-of-mental-health-problems/mental-health-problems-introduction/self-care/")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        complete_text = "\(ttsText.text!) self-care on mind.org.uk"
    }
}


//MARK: Class for the Treatmetn Options section of the help info tab bar section.
class Treatments: UIViewController {
    
    //MARK: NOTE: all the information displayed is taken from mind.org.uk
    
    // These two lines of code are used to allow the TTS to read the present text.
    // Synthesizer object
    let synthesizer = AVSpeechSynthesizer()
    // Utterance object
    var utterance = AVSpeechUtterance(string: "")
    
    let usefulFunctions = UsefulFunctions()
    
    @IBOutlet var playButtons: [UIButton]!
    @IBOutlet var textToSpeak: [UILabel]!
    
    // To start the first TTS reader.
    @IBAction func buttonPressed1(_ sender: Any) {
        usefulFunctions.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[0], tts: textToSpeak[0].text!)
    }
    
    // To start the second TTS reader.
    @IBAction func buttonPressed2(_ sender: Any) {
        usefulFunctions.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[1], tts: textToSpeak[1].text!)
    }
    
    // To start the third TTS reader.
    @IBAction func buttonPressed3(_ sender: Any) {
        usefulFunctions.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[2], tts: textToSpeak[2].text!)
    }
    
    // To start the fourth TTS reader.
    @IBAction func buttonPressed4(_ sender: Any) {
        usefulFunctions.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[3], tts: textToSpeak[3].text!)
    }
    
    // To open the mind.org.uk website when its button is clicked.
    @IBAction func treatment_link(_ sender: Any) {
        usefulFunctions.openSite(siteName: "https://www.mind.org.uk/information-support/types-of-mental-health-problems/mental-health-problems-introduction/treatment-options/")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Put any launch code here.
    }
}
