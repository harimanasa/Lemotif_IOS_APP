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
        ["Grid size ", "Line angle intervals", "Line Widths"],
        ["Number of Circles","Min circle radius ","Max circle radius"],
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
    var selectedIndex = 0
    
    var imageOptions: [String] = ["carpet","circle","glass", "tile", "string","watercolors"]
    var watercolorOp: [String: Any] = ["algorithm" : "watercolors", "intensity_sd" : 0.2];
    //var watercolorOp: [String: Any] = ["algorithm" : "watercolors"]
    var carpetOp  :[String: Any] = ["algorithm" : "carpet", "tile_ratio" : 0.1, "line_width": 1, "rotations" : 4]
    var tileOp : [String: Any] = ["algorithm" : "tile", "line_width_tile" : 1, "step_size" : 10, "dir_prob" : 0.5]
    var glassOp: [String: Any]  = ["algorithm" : "glass", "icon_ratio" : 0.1, "size_flux" : 0.33, "passes" : 5]
    var stringOp : [String: Any] = ["algorithm" : "string", "offset_sd" : 0.2,  "n_line" : 150, "line_width_string" : 5]
    var circleOp : [String: Any] = ["algorithm" : "circle", "min_rad_factor" : 0.01, "max_rad_factor" : 0.09,
                    "n_circles" : 100]
    var opList : [Dictionary<String, Any>] = []
    
    func getArgs() {
        switch selectedIndex{
        case 0:
            carpetArgs()
            break;
        case 1:
            circleArgs()
            break;
        case 2:
            glassArgs()
            break;
        case 3:
            tileArgs()
            break;
        case 4:
            stringArgs()
            break;
        default :
            watercolorArgs()
            break;
        }
    }
    
    func watercolorArgs() {
        watercolorOp["intensity_sd"]! =  Float (optionSlider1.value);
        JsonHandler.args = watercolorOp
    }
    func carpetArgs() {
        carpetOp["tile_ratio"] = optionSlider1.value
        carpetOp["line_width"] = Int(optionSlider2.value * 9)+1 ;
        carpetOp["rotations"] = Int(optionSlider3.value * 5) + 1;
        JsonHandler.args = carpetOp;

    }
    
    func tileArgs() {
        tileOp["line_width_tile"] = Int(optionSlider3.value * 9) + 1
        tileOp["step_size"] = Int(optionSlider2.value * 45) + 5
        tileOp["dir_prob"] = ((optionSlider1.value * 80) + 10)/100
        JsonHandler.args = tileOp
    }
    
    func glassArgs(){
        glassOp["icon_ratio"] = optionSlider1.value / 10 + 0.1
        glassOp["size_flux"] = optionSlider2.value / 10 + 0.33
        glassOp["passes"] = Int(optionSlider3.value * 5) + 1 + 5
//        glassOp["icon_ratio"] = 0.1
//        glassOp["size_flux"] = 0.33
//        glassOp["passes"] = 5
        JsonHandler.args = glassOp
        
    }
    
    func stringArgs() {
        stringOp["offset_sd"] = optionSlider1.value
        stringOp["n_line"] = Int(optionSlider2.value * 225) + 25
        stringOp["line_width_string"] = Int(optionSlider3.value) * 9 + 1
        JsonHandler.args = stringOp
    }
    
    func circleArgs() {
        var circleOp : [String: Any] = ["algorithm" : "circle", "min_rad_factor" : 0.01, "max_rad_factor" : 0.09,
                               "n_circles" : 100]
        circleOp["n_circles"] = Int(optionSlider1.value * 140) + 10;
        circleOp["min_rad_factor"] = optionSlider2.value / 10
        circleOp["max_rad_factor"] = optionSlider3.value / 10
        JsonHandler.args = circleOp
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirstViewController.isLast = false
        FirstViewController.timeToShow = false
        // Do any additional setup after loading the view, typically from a nib.
        var list =  [carpetOp, circleOp, tileOp, glassOp, stringOp,watercolorOp]
        opList = list
        // Connect data:
        self.stylePicker.delegate = self
        self.stylePicker.dataSource = self
        
        // Input the data into the array
        stylePickerData = ["carpet","circle","glass", "tile", "string","watercolors"]
        
        optionLabels = Array(arrayLiteral: optionLabel1, optionLabel2, optionLabel3)
        optionSliders = Array(arrayLiteral: optionSlider1, optionSlider2,optionSlider3)
        
        stylePicker.selectRow(0, inComponent: 0, animated: false)
        
        previewImage.image = UIImage(named: imageOptions[0])
        optionSelector(style: 0)
        
        for index in 0...2{
            optionSliders[index]!.isContinuous = false
        }
        
        JsonHandler.args = carpetOp;
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
            selectedIndex = row
            JsonHandler.args = opList[row];
            optionSelector(style: row)
        previewImage.image = UIImage(named:imageOptions[row])
    }

    @IBAction func makeCall(_ sender: Any) {
        getArgs()
         JsonHandler.jsonCall_1()
                while !JsonHandler.callSuccess { }
        if (!JsonHandler.jsonCall_decode()) {
            print("failed...")
        }
    }
    
    
    
    
}
