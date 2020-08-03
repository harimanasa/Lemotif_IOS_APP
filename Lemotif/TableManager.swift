//
//  TableManager.swift
//  Lemotif
//
//  Created by Irene Lee on 8/3/20.
//  Copyright © 2020 Irene Lee. All rights reserved.
//

import Foundation
import UIKit
class TableManager: NSObject, NSCoding{
    func encode(with coder: NSCoder) {
        coder.encode(TableManager.motifDataList, forKey: "motifDataList")
    }
    
    required init?(coder: NSCoder) {
        let tempList = coder.decodeObject(forKey: "motifDataList") as? [MotifData]
        if tempList != nil {
            TableManager.motifDataList = tempList!
        }
    }

    
    
    static var motifDataList: [MotifData] = []
    static var isNewSave: Bool = false
    static var newInstanceReady: Bool = false
    static var selectedIndex = -1
    static func addNewItem(toSave :MotifData){
        if (motifDataList.count >= 1 &&   motifDataList[motifDataList.count - 1].date == (toSave.date)) {
           // print("update")
            motifDataList[motifDataList.count - 1] = toSave
            //print("\(motifDataList[motifDataList.count - 1].emotionList)")
        } else {
           // print("add")
            motifDataList.append(toSave)
        }
        
        isNewSave = true
        newInstanceReady = true
    }
    
    
}
