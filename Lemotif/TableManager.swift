//
//  TableManager.swift
//  Lemotif
//
//  Created by Irene Lee on 8/3/20.
//  Copyright © 2020 Irene Lee. All rights reserved.
//

import Foundation
import UIKit
class TableManager: NSObject, NSCoding, Codable {
    func encode(with coder: NSCoder) {
        coder.encode(TableManager.motifDataList, forKey: "motifDataList")
    }
    
    required init?(coder: NSCoder) {
        let tempList = coder.decodeObject(forKey: "motifDataList") as? [MotifData]
        if tempList != nil {
            TableManager.motifDataList = tempList!
        }
    }

    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("saveData")
    
    static var motifDataList: [MotifData] = [MotifData(image1:UIImage(named: "SampleMotif1")!,image2:UIImage(named: "SampleMotif2")!,image3:UIImage(named: "SampleMotif3")!, date: "sample", emotions: ["happy","fun","tired"], topics:["day", "friends","family"])]
    static var isNewSave: Bool = false
    static var newInstanceReady: Bool = false
    static var selectedIndex = -1
    static var valUpdate = false
    
    static func addNewItem(toSave :MotifData){
        if (motifDataList.count >= 1 &&   motifDataList[motifDataList.count - 1].date == (toSave.date)) {
           print("update")
            valUpdate = true
            motifDataList[motifDataList.count - 1] = toSave
            print("\(motifDataList[motifDataList.count - 1].emotionList)")
        } else {
            valUpdate = false
            motifDataList.append(toSave)
        }

        
        isNewSave = true
        newInstanceReady = true
    }
    
    
}
