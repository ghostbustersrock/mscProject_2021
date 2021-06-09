//
//  DatabaseEntries.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 09/06/21.
//

import Foundation
import UIKit
import RealmSwift

class User: Object {
    @objc dynamic var identifier:Int = 0
    @objc dynamic var profilePic:String? = nil
    @objc dynamic var name:String? = nil
    @objc dynamic var username:String? = nil
    @objc dynamic var password:String? = nil
}
