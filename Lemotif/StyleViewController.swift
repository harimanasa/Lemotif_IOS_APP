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
    
    var detailOptions: [[String]] = [
        ["Grid size as percentage of motif size", "Line angle intervals", "Line Widths"],
        ["Number of Circles","Min circle radius as percentage of motif size","Max circle radius as percentage of motif size"],
        ["Icon size as percentage of motif size", "Icon size variability","Icon fill Density"],
        ["Angle rotation", "Grid size", "Line widths"],
        ["Amount of bend in string", "Number of strings", "String widths"],
        ["Variation in color intensity", "",""]
    ]
    
    
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

    
    @IBOutlet weak var previewImage: UIImageView!
    
    
    var selectedStyle: String = ""
    
    var imageOptions: [String] = ["Carpet","Circle","Glass", "Tile", "String","WaterColor"]
    
    
//    @IBAction func newSelection(_ sender: Any) {
//        var row = stylePicker.selectedRow(inComponent: 0)
//        optionSelector(style: row)
//        print(row)
//
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect data:
        self.stylePicker.delegate = self
        self.stylePicker.dataSource = self
        
        // Input the data into the array
        stylePickerData = ["Carpet","Circle","Glass", "Tile", "String","Watercolor"]
        
        optionLabels = Array(arrayLiteral: optionLabel1, optionLabel2, optionLabel3)
        optionSliders = Array(arrayLiteral: optionSlider1, optionSlider2,optionSlider3)
        
        stylePicker.selectRow(0, inComponent: 0, animated: false)
        
        previewImage.image = UIImage(named: imageOptions[0])
        optionSelector(style: 0)
        
        for index in 0...2{
            optionSliders[index]!.isContinuous = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
        
    
    //function that changes the options based on the selected style
    func optionSelector(style: Int){
        if (style == 5){
            optionSlider2.isEnabled = false;
            optionSlider3.isEnabled = false;
        } else if (optionSlider2.isEnabled == false) {
            optionSlider2.isEnabled = true;
            optionSlider3.isEnabled = true;
        }
        previewImage.image = UIImage(named: imageOptions[style])
        for index in 0...2 {
            optionLabels[index]?.text = detailOptions[style][index]
        }
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
            optionSelector(style: row)
        previewImage.image = UIImage(named:imageOptions[row])
    }

    @IBAction func makeCall(_ sender: Any) {
         JsonHandler.jsonCall_1()
                while !JsonHandler.callSuccess { }
            //jsonDataCheck()
                JsonHandler.jsonCall_decode()
    }
    
    
}
