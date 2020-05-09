//
//  StyleViewController.swift
//  Lemotif
//
//  Created by Irene Lee on 5/7/20.
//  Copyright © 2020 Irene Lee. All rights reserved.
//

import Foundation
import UIKit

class StyleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var stylePicker: UIPickerView!
    var stylePickerData: [String] = [String]()
    
    //option prompts
    @IBOutlet weak var optionLabel1: UILabel!
    @IBOutlet weak var optionLabel3: UILabel!
    @IBOutlet weak var optionLabel2: UILabel!
    var optionLabels: Array<UILabel?> = []

    
    //option sliders
    @IBOutlet weak var optionSlider1: UISlider!
    
    @IBOutlet weak var optionSlider2: UISlider!
    
    @IBOutlet weak var optionSlider3: UISlider!
    var optionSliders: Array<UISlider?> = []

    
    var selectedStyle: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect data:
        self.stylePicker.delegate = self
        self.stylePicker.dataSource = self
        
        // Input the data into the array
        stylePickerData = ["Carpet","Circle","Glass", "Tile", "String","Watercolors"]
        
        optionLabels = Array(arrayLiteral: optionLabel1, optionLabel2, optionLabel3)
        optionSliders = Array(arrayLiteral: optionSlider1, optionSlider2,optionSlider3)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1 // number of session
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return stylePickerData.count // number of dropdown items
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return stylePickerData[row] // dropdown item
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedStyle = stylePickerData[row] // selected item
    }
    
}
