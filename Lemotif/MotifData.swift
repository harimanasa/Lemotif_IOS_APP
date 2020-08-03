//
//  motifData.swift
//  Lemotif
//
//  Created by Irene Lee on 8/3/20.
//  Copyright © 2020 Irene Lee. All rights reserved.
//

import Foundation
import UIKit

class MotifData: NSObject{
    
    var image1: UIImage
    var image2: UIImage
    var image3: UIImage
    var emotionList: [String] = []
    var topicList: [String] = []

    let date: String
    init(image1: UIImage, image2: UIImage, image3: UIImage, date: String, emotions: [String], topics: [String]){
        self.image1 = image1
        self.image2 = image2
        self.image3 = image3
        self.date = date
        self.emotionList = emotions
        self.topicList = topics
    }
    
}
