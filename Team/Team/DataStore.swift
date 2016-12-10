//
//  DataStore.swift
//  Team
//
//  Created by Christopher Webb-Orenstein on 12/9/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class DataStore {
    static let sharedInstance = DataStore()
    var teamMembers = [TeamMember]()
}
