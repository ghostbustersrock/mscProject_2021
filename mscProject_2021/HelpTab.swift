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
    
    @IBOutlet var videoYoutube: WKWebView!
    @IBOutlet var textToSpeak: UILabel!
    
    // Synthesizer object
    let synthesizer = AVSpeechSynthesizer()
    // Utterance object
    var utterance = AVSpeechUtterance(string: "")
    
    @IBOutlet var playButtons: [UIButton]!
    
    @IBAction func playButton1(_ sender: Any) {
        let usefulFuncs = UsefulFunctions()
        usefulFuncs.playTextToSpeak(utterance: &utterance, synthesizer: synthesizer, buttonPressed: playButtons[0], tts: textToSpeak.text!)
    }
    
    func playVideo(videoURL: String) {
        
        if let videoURL:URL = URL(string: "https://www.youtube.com/embed/\(videoURL)") {
            let request:URLRequest = URLRequest(url: videoURL)
            videoYoutube.load(request)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo(videoURL: "G0zJGDokyWQ")
        
    }
}
