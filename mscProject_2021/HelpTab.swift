//
//  HelpTab.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 28/05/21.
//

import UIKit
import WebKit

class HelpTab: UIViewController {
    
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
