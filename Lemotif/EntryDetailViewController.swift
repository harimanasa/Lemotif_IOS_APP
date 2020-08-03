//
//  EntryDetail.swift
//  Lemotif
//
//  Created by Irene Lee on 8/3/20.
//  Copyright © 2020 Irene Lee. All rights reserved.
//

import Foundation
import UIKit

class EntryDetailViewController: UIViewController {
    
    @IBOutlet weak var topic1: UILabel!
    
    @IBOutlet weak var emotion1: UILabel!
    @IBOutlet weak var topic2: UILabel!
    @IBOutlet weak var emotion2: UILabel!
    @IBOutlet weak var topic3: UILabel!
    @IBOutlet weak var emotion3: UILabel!

    @IBOutlet weak var motifImage1: UIImageView!
      
    
      @IBOutlet weak var motifImage2: UIImageView!
      
      @IBOutlet weak var motifImage3: UIImageView!
    
    @IBOutlet weak var naviBar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewdidappear in entry detail")
        if (TableManager.selectedIndex != -1){
            var  currMotif = TableManager.motifDataList[TableManager.motifDataList.count - 1 - TableManager.selectedIndex]
            var currTopics = currMotif.topicList
            var currEmotions = currMotif.emotionList
            topic1.text = currTopics[0]
            topic2.text = currTopics[1]
            topic3.text = currTopics[2]
            emotion1.text = currEmotions[0]
            emotion2.text = currEmotions[1]
            emotion3.text = currEmotions[2]
            motifImage1.image = currMotif.image1
            motifImage2.image = currMotif.image2
            motifImage3.image = currMotif.image3
            naviBar.title = currMotif.date


        }
       
        
        
    }
 
      
}
