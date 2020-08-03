//
//  MotifCell.swift
//  Lemotif
//
//  Created by Irene Lee on 8/3/20.
//  Copyright © 2020 Irene Lee. All rights reserved.
//

import UIKit
class MotifCell: UITableViewCell {
    @IBOutlet weak var motifDate: UILabel!
    @IBOutlet weak var motifImage1: UIImageView!
    @IBOutlet weak var motifImage2: UIImageView!
    
    @IBOutlet weak var motifImage3: UIImageView!
    
    func setMotif(motifData: MotifData) {
        motifDate.text = motifData.date
        motifImage1.image = motifData.image1
        motifImage2.image = motifData.image2
        motifImage3.image = motifData.image3

    }
    
    
}
