//
//  UsefulFunctions.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 02/06/21.
//

import Foundation
import UIKit
import AVFoundation //Used to enable the text-to-speach in the playTextToSpeak() function.


//MARK: Class containing useful functions (i.e. to open websites) used in other classes.
class UsefulFunctions: UIViewController {
    
    // Function to display an alert pop-up with a title and message.
    func displayAlert(displayTitle: String, msg: String) {
        let defAction = UIAlertController(title: displayTitle, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel) {
            alertAction in
        }
        
        defAction.addAction(okAction)
        self.present(defAction, animated: true, completion: nil)
    }
    
    // Function used to open websites.
    func openSite(siteName: String) {
        UIApplication.shared.open(URL(string: siteName)! as URL, options: [:], completionHandler: nil)
    }
    
    // Function used to enable the text-to-speach reading of a text.
    func playTextToSpeak(utterance: inout AVSpeechUtterance, synthesizer: AVSpeechSynthesizer, buttonPressed: UIButton, tts: String) {
        //To stop the speaking.
        if (synthesizer.isSpeaking) {
            buttonPressed.setImage(UIImage(named: "tts_start"), for: .normal)
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        }
        //To start the speaking.
        else if (!synthesizer.isSpeaking) {
            buttonPressed.setImage(UIImage(named: "tts_stop"), for: .normal)
            // Getting text to read from the UITextView (textView).
            utterance = AVSpeechUtterance(string: tts)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            utterance.rate = 0.5
            synthesizer.speak(utterance)
        }
    }
    
}
