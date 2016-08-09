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
        print(String(data: data, encoding:4))
    }
    func responseHandler(data: NSData?, response:NSURLResponse?, error:NSError?){
        if let receivedError = error {
            reportFailure(receivedError.description)
        } else if let receivedData = data {
            handleReceiveData(receivedData)
        }
        
    }
}