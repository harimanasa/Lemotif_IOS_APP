//
//  motifData.swift
//  Lemotif
//
//  Created by Irene Lee on 8/3/20.
//  Copyright © 2020 Irene Lee. All rights reserved.
//

import Foundation
import UIKit

class MotifData: NSObject, NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode(image1, forKey: "image1")
        coder.encode(image2, forKey: "image2")

        coder.encode(image3, forKey: "image3")
        coder.encode(image1, forKey: "image1")
        coder.encode(emotionList, forKey: "emotionList")
        coder.encode(topicList, forKey: "topicList")
        coder.encode(date, forKey: "date")

    }

    required init?(coder: NSCoder) {
        
        image1 = coder.decodeObject(forKey: "image1") as! UIImage
        image2 = coder.decodeObject(forKey: "image2") as! UIImage
        image3 = coder.decodeObject(forKey: "image3") as! UIImage
        emotionList = coder.decodeObject(forKey: "emotionList") as! [String]
        topicList = coder.decodeObject(forKey: "topicList") as! [String]
        date = coder.decodeObject(forKey: "date") as! String

    }
    
    
    
    var image1: UIImage
    var image2: UIImage
    var image3: UIImage
    var emotionList: [String] = []
    var topicList: [String] = []

    var date: String
    init(image1: UIImage, image2: UIImage, image3: UIImage, date: String, emotions: [String], topics: [String]){
        self.image1 = image1
        self.image2 = image2
        self.image3 = image3
        self.date = date
        self.emotionList = emotions
        self.topicList = topics
    }
    
    func initialize (image1: UIImage, image2: UIImage, image3: UIImage, date: String, emotions: [String], topics: [String]){
        self.image1 = image1
        self.image2 = image2
        self.image3 = image3
        self.date = date
        self.emotionList = emotions
        self.topicList = topics
    }

    
}
