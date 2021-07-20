//
//  HelpTab.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 28/05/21.
//

import UIKit
import WebKit
import AVFoundation

class HelpTab: UIViewController {
    
    @IBOutlet var provaTestoSpeech: UILabel!
    
    // Synth object
        let synthesizer = AVSpeechSynthesizer()
        // Utterance object
        var utterance = AVSpeechUtterance(string: "")
    
    @IBOutlet var playButtons: [UIButton]!
    
    @IBAction func playButton1(_ sender: Any) {
        if (synthesizer.isSpeaking) {
            playButtons[0].setImage(UIImage(named: "tts_stop"), for: .normal)
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        }
        else if (!synthesizer.isSpeaking) {
            playButtons[0].setImage(UIImage(named: "tts_start"), for: .normal)
            // Getting text to read from the UITextView (textView).
            utterance = AVSpeechUtterance(string: provaTestoSpeech.text!)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            utterance.rate = 0.5
            synthesizer.speak(utterance)
        }
    }
    
    @IBOutlet var videoYoutube: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo(videoURL: "G0zJGDokyWQ")
        
    }
    
    func playVideo(videoURL: String) {
        
        if let videoURL:URL = URL(string: "https://www.youtube.com/embed/\(videoURL)") {
            let request:URLRequest = URLRequest(url: videoURL)
            videoYoutube.load(request)
        }
    }
}
