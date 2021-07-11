//
//  DatabaseEntries.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 09/06/21.
//

import Foundation
import UIKit
import RealmSwift

// To store sign-up information of registered user.
class User: Object {
    @objc dynamic var identifier:Int = 0
    @objc dynamic var profilePic:String? = nil
    @objc dynamic var username:String? = nil
    @objc dynamic var password:String? = nil
}


// To store results of the PHQ-9 test.
class PhqTestResults: Object {
    @objc dynamic var identifier:Int = 0 // To store user ID.
    var scoreResPHQ = List<Int>()
    var severityResPHQ = List<String>()
}


// To store results of the emotion analysis assessment.
//class EmotionAnalysisResults: Object {
//
//}
