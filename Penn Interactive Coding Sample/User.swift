//
//  User.swift
//  Penn Interactive Coding Sample
//
//  Created by Mark Adler on 12/17/19.
//  Copyright © 2019 Mark Adler. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    var userID = ""
    var name  = "display_name"
    var badgeCountGold = 0
    var badgeCountSilver = 0
    var badgeCountBronze = 0
    var avatarURL = ""
    var avatar : UIImage?
    
    class func getUsersFromStackOverflow() -> [User]? {
        guard let stackExchangeURL = URL(string:"https://api.stackexchange.com/2.2/users?site=stackoverflow") else { return nil }
        
        guard let jsonDict = downloadJSONAsDictionaries(url: stackExchangeURL) else { return nil }
        
        // Users are as subdictionaries stored nested in array in the items dictionary
        if let userDictsArray = jsonDict["items"] as?
            Array<Dictionary<String, Any>> {
            var Users = [User]()
            
            // Each item in the array is a dictionary we can use to initialize the user objects
            for dict in userDictsArray {
                Users.append(User(jsonDict: dict))
            }
            
            return Users
            
        }
        return nil
    }
    
    
    init (jsonDict:Dictionary<String, Any>) {
        
        avatarURL = jsonDict["profile_image"] as! String
        name = jsonDict["display_name"] as! String
        userID = String(jsonDict["user_id"] as! Int)
        
        let badgeCountsDictionary = jsonDict["badge_counts"] as! Dictionary<String,Int>
        badgeCountGold = badgeCountsDictionary["gold"] ?? 0
        badgeCountSilver = badgeCountsDictionary["silver"] ?? 0
        badgeCountBronze = badgeCountsDictionary["bronze"] ?? 0
        
        // Try to see if we have already downloaded this avatar
        if self.loadAvatarImageFromDocuments() {
            // Successfully loaded
        }
        
        
    }
    
    func downloadAvatarImageFromWeb() -> Bool {
        guard  avatarURL != "" else { return false }
        guard let url = URL(string: avatarURL)  else { return false }
        
        do {
            
            let imageData = try Data(contentsOf: url )
            avatar = UIImage(data: imageData) // Successfully downloaded
            
            saveAvatarImage() // Now save for offline storage
            
            return true
        } catch {
            print("Unable to convert image data for avatar.")
        }
        return false
    }
    
    
    
    func saveAvatarImage() -> Bool {
        // Save the image to the documents folder
        // Returns true if successful
        guard let avatar = avatar else { return false }
        
        // Saving the image to the documents folder
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = self.userID + ".jpg" // File will be saved according to its unique userID which comes from Stack Overflow API
        
        let fileURL = documentsURL.appendingPathComponent(fileName)
        // get your UIImage jpeg data representation and check if the destination file url already exists
        if let data = avatar.jpegData(compressionQuality:  1.0),
          !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try data.write(to: fileURL)
                print("Avatar image saved")
                return true
                
            } catch {
                print("Error saving image:", error)
                return false
            }
        }
        return false
    }
    
    func loadAvatarImageFromDocuments() -> Bool {
        
        // Load the image and Return true if successful
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = self.userID + ".jpg" // File will be saved according to its unique userID which comes from Stack Overflow API
        
        let fileURL = documentsURL.appendingPathComponent(fileName)
        do {
            let dataFromFile = try Data(contentsOf: fileURL)
            if let imageFromData = UIImage(data: dataFromFile) {
                // Successfully got the image
                print("Successfully loaded avatar from file")
                self.avatar = imageFromData
                return true
            }
        } catch {
            print("Could not load from file")
            return false
        }
            
        return false
        
    }
    
    
    
}


