//
//  JSON.swift
//  Penn Interactive Coding Sample
//
//  Created by Mark Adler on 12/17/19.
//  Copyright © 2019 Mark Adler. All rights reserved.
//

import Foundation


func downloadJSONAsDictionaries(url:URL) -> Dictionary<String, Any>? {
    
    // Try to download the JSON file at the given URL and
    // return as a dictionary
    do {
        
        let downloadedJSON = try String(contentsOf: url, encoding: .utf8)
        
        print(downloadedJSON)
        
        let jsonData = try Data(contentsOf: url)
        // Successfully downloaded.
        
        do {
            let jsonResult = try
                JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
        
            if let jsonDict = jsonResult as? Dictionary<String, AnyObject> {
                // Success
                return jsonDict
            } else { return nil }
            

        } catch {
            print("JSON Decode Failed")
            return nil
        }

        
    } catch {
        
        print("Error downloading JSON file")
        return nil
    
        
        
    }
    
}


