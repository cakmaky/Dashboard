//
//  DataFetcher.swift
//  DashboardYalcinCakmak
//
//  Created by YC on 8/8/16.
//  Copyright © 2016 University of California at Santa Cruz. All rights reserved.
//

import Foundation

class DataFetcher {
    
    let url: String
    var appTitles: [String]?
    private var currentTitlePosition = 0
    var currentTitle: String {
        if appTitles == nil || appTitles!.count == 0 {
            return "no Data"
        }
        return appTitles![currentTitlePosition]
    }
    var nextTitle: String {
        if appTitles == nil || appTitles!.count == 0 {
            return "no Data"
        }
        currentTitlePosition += 1
        
        if currentTitlePosition > appTitles!.count - 1 {
            currentTitlePosition = 0
        }
        return appTitles![currentTitlePosition]
    }
    
    init(url : String){
        self.url = url
        
        if let fetcherURL = NSURL(string: url){
            let sharedSession = NSURLSession.sharedSession()
            let dataTask: NSURLSessionDataTask = sharedSession.dataTaskWithURL(fetcherURL, completionHandler:responseHandler)
            dataTask.resume()
        } else {
            reportFailure("Could not create NSURL")
        }
    }
    
    func reportFailure(message: String) {
        
        print(message)
    }
    func handleReceiveData(data:NSData){
        
        convertDataTOJSON(data)
        //print(String(data: data, encoding:4))
    }
    func responseHandler(data: NSData?, response:NSURLResponse?, error:NSError?){
        if let receivedError = error {
            reportFailure(receivedError.description)
        } else if let receivedData = data {
            handleReceiveData(receivedData)
        }
        
    }
    func convertDataTOJSON(receivedData: NSData) {
        
        var jsonObject: AnyObject?
        
        do {
            try jsonObject = NSJSONSerialization.JSONObjectWithData(receivedData, options: NSJSONReadingOptions.AllowFragments)
            
        } catch {
            reportFailure("Error: NSJSONSerialization couldn't convert receivedData.")
            return
            }
        if let dataDict = jsonObject as? NSDictionary {
                if let entries = dataDict["feed"]?["entry"] as? [NSDictionary] {
                    var titles = [String]()
                    for(index, entry) in entries.enumerate() {
                        if let title = entry["title"]?["label"] as? String {
                            titles.append(title)
                        } else {
                            reportFailure("Could not get title for item \(index + 1) ")
                        }
                    }
                    print(titles)
                    appTitles = titles
                    
                } else {
                    reportFailure("Entries array could not be found")
            }
        } else {
            reportFailure("Error: converted JSON data is not an NSDictionary")
            
        }
        
    }
    
}



















