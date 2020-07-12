//
//  FirstViewController.swift
//  Lemotif
//
//  Created by Irene Lee on 5/7/20.
//  Copyright © 2020 Irene Lee. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var textView1: UITextView!
    
    @IBOutlet weak var textView2: UITextView!
    
    @IBOutlet weak var textView3: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let promptText: String? = "Write a little about something that happened today and how you felt."
//        textView3.placeholder = promptText
//        textView2.placeholder = promptText
//        textView1.placeholder = promptText
        
        let listTextviews: Array<UITextView?> = Array(arrayLiteral: textView1,textView2, textView3)
        for currTV in listTextviews {
            currTV?.placeholder = promptText
            currTV?.layer.borderWidth = 1
            currTV?.layer.borderColor = UIColor.black.cgColor
        }
        
        
    }
    /*
    @IBAction func saveString(_ sender: Any) {
//        JsonHandler.inputString = [textView1.text!, textView2.text!,textView3.text!]
//        print(JsonHandler.inputString)
    }
    */
    
    @IBAction func makeCall(_ sender: Any) {
        
        
        
        JsonHandler.inputString = [textView1.text!, textView2.text!,textView3.text!]
        for i in 0...2 {
            if (JsonHandler.inputString[i] == ""){
                JsonHandler.inputString[i] = " ";
            }
        }
        print(JsonHandler.inputString)
    }

    @IBAction func unwindToMain(_sender : UIStoryboardSegue){
        JsonHandler.callSuccess = false;
        ImageHandler.callReady = false;
        ImageHandler.motifImageList = [];
        ImageHandler.motifString = [];
        textView1.text = "";
        textView2.text = "";
        textView3.text = "";

    }

}

