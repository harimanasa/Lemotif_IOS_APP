//
//  JsonHandler.swift
//  Lemotif
//
//  Created by Irene Lee on 6/28/20.
//  Copyright © 2020 Irene Lee. All rights reserved.
//

import Foundation
import UIKit

class JsonHandler {
    static var motifImageList: [UIImage] = Array()
    
    static var inputString :[String?] = ["","",""]
     static var receivedData: Data?
     static var receivedDataString : String?
     static var callSuccess = false
    static var topicList : [String] = [""]
    static var emotionList : [String] = [""]
    static var style = "watercolors";
    static var args = ["intensity_sd" : 0.8];
    
    static func jsonCall_decode(){
           print("inside jsonCall_decode")
           var motifDictionary = convertToDictionary(text: receivedDataString!)
           
           
           //second Dictionary -- refined
           var motifDictionary_2 = ["topics": [""], "emotions" : [""]]
           //var motifImageList: [UIImage] = Array()
           
           
           //Create a temp array with topic list
           var tempNSArray : NSArray = motifDictionary?["topics"] as! NSArray
           var itemArray: [String] = Array()
           for i in 0...2 {
               do {
                   var temp = try (tempNSArray[i] as! NSArray)[0]
                   itemArray.append((temp as! NSString) as String)
               } catch {
                   print("error in converting NSArray to string")
               }

           }
            topicList = itemArray
           motifDictionary_2["topics"] = itemArray
           
           //Create a temp aray with emoton list
           tempNSArray = motifDictionary?["emotions"] as! NSArray
           itemArray = Array()
           for i in 0...2 {
               do {
                   var temp = try (tempNSArray[i] as! NSArray)[0]
                   itemArray.append((temp as! NSString) as String)
               } catch {
                   print("error in converting NSArray to string")
               }
           }
           motifDictionary_2["emotions"] = itemArray
        emotionList = itemArray

//           text1.text = motifDictionary_2["topics"]![0] + "   " + motifDictionary_2["emotions"]![0]
//           text2.text = motifDictionary_2["topics"]![1] + "   " + motifDictionary_2["emotions"]![1]
//           text3.text = motifDictionary_2["topics"]![2] + "   " + motifDictionary_2["emotions"]![2]

           for motifval in motifDictionary?["motifs"] as! Array<String> {
               ImageHandler.motifString.append(motifval)
//               let newImage = toImage(inputString: motifval)
//               if newImage != nil {
//                   motifImageList.append(newImage!)
//                   ImageHandler.motifImageList.append(newImage!)
//                    print("success! -- added to the list")
//               } else {
//                  print("error with decodedData")
//              }
           }
           ImageHandler.callReady = true
    
       }
    
    static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    


    
    
    static func jsonCall_1(){
        
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid

        let parameters :[String: Any] = ["key": "49s0Jo67L08sabgCph7lw", "text": JsonHandler.inputString, "args" : JsonHandler.args]
        //TODO: possibly add "algorithms" = style; and "args" = {width: 0.7, height: 0.4} or something like this.
        
        

        //create the url with URL
        let url = URL(string: "http://lemotif.cloudcv.org/api/v0.0/create")! //change the url

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                    guard error == nil else {
                        print("error1")
                        return
                    }
                    guard let data = data else {
                        print("error2")
                        return
                    }
                    do {

                        //create json object from data
                         var jsonData = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions()) as NSData
                        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
                        print("json string = \(jsonString)")
                        
                        //handle json
                                               
                        
                        if let json = try JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: Any] {
                            self.receivedData = data
                            if var httpresponse = response as? HTTPURLResponse{
                                print(httpresponse.statusCode)
                            }
                            if let dataString = String(data: data, encoding: .utf8) {
                                //print("Response data string:\n \(dataString)")
                                self.receivedDataString = dataString
                                //self.jsonCall_decode()
                                self.callSuccess = true
                            }
                            
                        }
                        
                    } catch let error {
                        print(error.localizedDescription)
                    }
                })
                task.resume()
    }

    
    @IBAction func makeCall(_ sender: Any) {
        JsonHandler.callSuccess = false;
        ImageHandler.callReady = false;
    }
    
}
