//
//  DatabaseEntries.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 09/06/21.
//

import Foundation
import UIKit
import RealmSwift

//MARK: Realm object class to store a user's sign-up information.
class User: Object {
    @objc dynamic var identifier:Int = 0 //User's unique ID.
    @objc dynamic var profilePic:String? = nil //User's profile pic.
    @objc dynamic var username:String? = nil //User's username.
    @objc dynamic var password:String? = nil // User's password.
}


//MARK: Realm object to store a user's PHQ-9 test results.
class PhqTestResults: Object {
    @objc dynamic var identifier:Int = 0 // User's unique ID.
    var scoreResPHQ = List<Int>() // List to save a user's new PHQ-9 score each time.
    var severityResPHQ = List<String>() // List to save a user's new PHQ-9 severity score each time.
}


//MARK: Realm object to store results of the emotion analysis assessment.
class EmotionAnalysisResults: Object {
    @objc dynamic var identifier:Int = 0 //User's unique ID.
    var emotionsDetected = List<String>() //List to store the unique emotions detected throughout each test's question.
    var emotionsPercentage = List<Double>() //List to store the percentage a unique emotion has been identified throughout the test.
    @objc dynamic var sentimentAverage:Double = 0 //To store the average sentiment score value from a test.
}
