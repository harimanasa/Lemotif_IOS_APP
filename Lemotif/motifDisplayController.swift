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

    @IBAction func saveMotif(_ sender: Any) {
    }
    
    
    @IBOutlet weak var motifImage1: UIImageView!
    
  
    @IBOutlet weak var motifImage2: UIImageView!
    
    @IBOutlet weak var motifImage3: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        motifImage1.image = UIImage(named: "SampleMotif1")
        motifImage2.image = UIImage(named: "SampleMotif2")
        motifImage3.image = UIImage(named: "SampleMotif3")

    }


}
