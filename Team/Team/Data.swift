//
//  Data.swift
//  Team
//
//  Created by Christopher Webb-Orenstein on 12/9/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

class FileData {
    let store = DataStore.sharedInstance
    var members = [TeamMember]()
    func readData() {
        if let filepath = Bundle.main.path(forResource: "team", ofType: "json") {
            do {
                let contents = try NSData(contentsOfFile: filepath, options: .mappedIfSafe)
                
                guard let jsonData = contents as? Data else { return }
                
                let result = try JSONSerialization.jsonObject(with: jsonData, options:[]) as? AnyObject
                let dictData = result as? [[String:Any]]
                dictData?.forEach { returnData in
                    let finalData = returnData as! [String:String]
                    guard let firstname = finalData["firstName"] else { return }
                    guard let avatar = finalData["avatar"] else { return }
                    guard let lastName = finalData["lastName"] else { return }
                    guard let id = finalData["id"] else { return }
                    guard let title = finalData["title"] else { return }
                    guard let bio = finalData["bio"] else { return }
                    let teamMate = TeamMember(avatar: avatar, bio: bio, firstName: firstname, id: id, lastName: lastName, title: title)
                    members.append(teamMate)
                }
            } catch {
                    // contents could not be loaded
            }
            store.teamMembers = members
        }
    }
    
    func checkStore() {
        print(self.store.teamMembers)
    }
}
