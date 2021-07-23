//
//  HelpTab.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 28/05/21.
//

import UIKit
import WebKit
import AVFoundation // Library for the TTS to be used.

//MARK: Class for the first page of the help info tab bar section.
class HelpTab: UIViewController {
    
    //MARK: NOTE: all the information displayed is taken from mind.org.uk
    
    // Outlets to play the youtube video and have the TTS read the presented text.
    @IBOutlet var videoYoutube: WKWebView!
    @IBOutlet var textToSpeak: UILabel!
    
    // These two lines of code are used to allow the TTS to read the present text.
    // Synthesizer object
    let synthesizer = AVSpeechSynthesizer()
    // Utterance object
    var utterance = AVSpeechUtterance(string: "")
    
    @IBOutlet var playButtons: [UIButton]! //Outlet for the TTS play button.
    
    //Action to start the speaking of the text.
    @IBAction func playButton1(_ sender: Any) {
        let usefulFuncs = UsefulFunctions()
        usefulFuncs.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[0], tts: textToSpeak.text!)
    }
    
    //Function used to play the incorporated youtube video. Referenced below:
    /*
     Title: What is Mental Health?
     Channel: Mental Health at Work
     Date uploaded: July 1, 2016
     
     Mental Health at Work (2016) What is Mental Health? [online video] Available at: https://www.youtube.com/watch?v=G0zJGDokyWQ&t=2s [Accessed: June 14, 2021]
     */
    func playVideo(videoURL: String) {
        
        if let videoURL:URL = URL(string: "https://www.youtube.com/embed/\(videoURL)") {
            let request:URLRequest = URLRequest(url: videoURL)
            videoYoutube.load(request)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // As soon as this UI is launched call the function to present the youtube video so for it to be played if clicked.
        playVideo(videoURL: "G0zJGDokyWQ")
        
    }
}
