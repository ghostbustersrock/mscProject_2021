//
//  CausesMHtts.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 21/07/21.
//

import UIKit
import AVFoundation

class CausesMHtts: UIViewController {

    @IBOutlet var playButtons: [UIButton]!
    @IBOutlet var textToSpeak: [UILabel]!
    
    // Synthesizer object
    let synthesizer = AVSpeechSynthesizer()
    // Utterance object
    var utterance = AVSpeechUtterance(string: "")
    
    let usefulFuncs = UsefulFunctions()
    
    @IBAction func playButton1(_ sender: Any) {
        usefulFuncs.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[0], tts: textToSpeak[0].text!)
    }
    
    @IBAction func playButton2(_ sender: Any) {
        usefulFuncs.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[1], tts: textToSpeak[1].text!)
    }
    
    @IBAction func playButton3(_ sender: Any) {
        usefulFuncs.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[2], tts: textToSpeak[2].text!)
    }
    
    @IBAction func playButton4(_ sender: Any) {
        usefulFuncs.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[3], tts: textToSpeak[3].text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


class SelfCare: UIViewController {
    
    // Synthesizer object
    let synthesizer = AVSpeechSynthesizer()
    // Utterance object
    var utterance = AVSpeechUtterance(string: "")
    
    let usefulFunctions = UsefulFunctions()
    
    @IBOutlet var buttonPressed: UIButton!
    @IBOutlet var ttsText: UILabel!
    
    var complete_text:String?
    
    @IBAction func buttonPressed1(_ sender: Any) {
        usefulFunctions.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: buttonPressed, tts: complete_text!)
    }
    
    @IBAction func linkt_to_site(_ sender: Any) {
        usefulFunctions.openSite(siteName: "https://www.mind.org.uk/information-support/types-of-mental-health-problems/mental-health-problems-introduction/self-care/")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        complete_text = "\(ttsText.text!) self-care on mind.org.uk"
    }
}


class Treatments: UIViewController {
    
    // Synthesizer object
    let synthesizer = AVSpeechSynthesizer()
    // Utterance object
    var utterance = AVSpeechUtterance(string: "")
    
    let usefulFunctions = UsefulFunctions()
    
    @IBOutlet var playButtons: [UIButton]!
    @IBOutlet var textToSpeak: [UILabel]!
    
    @IBAction func buttonPressed1(_ sender: Any) {
        usefulFunctions.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[0], tts: textToSpeak[0].text!)
    }
    
    @IBAction func buttonPressed2(_ sender: Any) {
        usefulFunctions.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[1], tts: textToSpeak[1].text!)
    }
    
    @IBAction func buttonPressed3(_ sender: Any) {
        usefulFunctions.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[2], tts: textToSpeak[2].text!)
    }
    
    @IBAction func buttonPressed4(_ sender: Any) {
        usefulFunctions.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[3], tts: textToSpeak[3].text!)
    }
    
    @IBAction func treatment_link(_ sender: Any) {
        usefulFunctions.openSite(siteName: "https://www.mind.org.uk/information-support/types-of-mental-health-problems/mental-health-problems-introduction/treatment-options/")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Put any launch code here.
    }
}
