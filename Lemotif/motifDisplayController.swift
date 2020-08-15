//
//  motifDisplayController.swift
//  Lemotif
//
//  Created by Irene Lee on 5/9/20.
//  Copyright © 2020 Irene Lee. All rights reserved.
//

import Foundation
import UIKit

class motifDisplayController: UIViewController {

    @IBOutlet weak var motifImage1: UIImageView!
    
  
    @IBOutlet weak var motifImage2: UIImageView!
    
    @IBOutlet weak var motifImage3: UIImageView!
    
    @IBOutlet weak var topic1: UILabel!
    @IBOutlet weak var emotion1: UILabel!
    @IBOutlet weak var topic2: UILabel!
    @IBOutlet weak var emotion2: UILabel!
    @IBOutlet weak var topic3: UILabel!
    @IBOutlet weak var emotion3: UILabel!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //motifImage1.image = UIImage(named: "SampleMotif1")
        //motifImage2.image = UIImage(named: "SampleMotif2")
        //motifImage3.image = UIImage(named: "SampleMotif3")
        TableManager.newInstanceReady = false
        
        var topicTexts = [self.topic1,self.topic2,self.topic3]
        var emotionTexts = [emotion1, self.emotion2, self.emotion3]
        
        
        while (!ImageHandler.callReady) {}
            
                   for i in 0...2 {
                    topicTexts[i]?.text = JsonHandler.topicList[i]
                    emotionTexts[i]?.text = JsonHandler.emotionList[i]
                    if (topicTexts[i]?.text == "topic unknown"){
                        topicTexts[i]?.text = ""
                    }
                       var temp = ImageHandler.toImage(inputString: ImageHandler.motifString[i])
                       ImageHandler.motifImageList.append(temp!)
                       
                   }

               do{
                   motifImage1.image = ImageHandler.motifImageList[0]
                   motifImage2.image = ImageHandler.motifImageList[1]
                   motifImage3.image = ImageHandler.motifImageList[2]
               } catch {
                   print("error")
               }
               
    }

//for rewinding. Do NOT DELETE
    @IBAction func makeCall(_ sender: Any) {
        
    }
    
    @IBAction func saveMotif(_ sender: Any) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd - MM - yyyy"
        let result = formatter.string(from: date)
        if (!TableManager.newInstanceReady) {
            var newSave = MotifData(image1: ImageHandler.motifImageList[0],image2: ImageHandler.motifImageList[1],image3: ImageHandler.motifImageList[2], date: result,emotions: JsonHandler.emotionList, topics: JsonHandler.topicList)
            TableManager.addNewItem(toSave: newSave)
        }
        DispatchQueue.main.async {
            self.save()
        }
    }
    
    func save() {
     var tempList = TableManager.motifDataList
     var tempList2 = (tempList as NSObject)
     let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: tempList, requiringSecureCoding: false)
    UserDefaults.standard.setValue(encodedData, forKey: "motifDataList")
    }

}
