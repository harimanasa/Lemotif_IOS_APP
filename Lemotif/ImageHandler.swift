//
//  ImageHandler.swift
//  Lemotif
//
//  Created by Irene Lee on 6/28/20.
//  Copyright © 2020 Irene Lee. All rights reserved.
//

import Foundation
import UIKit

class ImageHandler {
     static var motifImageList: [UIImage] = Array()
     static var motifString: [String] = Array()
     static var callReady = false
     static var inputString :String = ""
     
     
     
    static func toImage(inputString: String) -> UIImage? {
         var todecode = inputString
         if inputString.contains(","){
             let base64 = inputString.components(separatedBy: ",")
             todecode = base64[1]
         }
        print("\n\n trying to convert the string to png -- inside toImage function")
        let decodedData = Data(base64Encoded: todecode, options: [])
         if decodedData != nil{
             print("success!! returning u=UIImage")
             return UIImage(data: decodedData!)
         } else {
             print("failure....")
             return nil
         }
                    
     }

}
