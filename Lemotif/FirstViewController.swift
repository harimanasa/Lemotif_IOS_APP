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
        
        let listTextviews: Array<UITextView?> = Array(arrayLiteral: textView1,textView2, textView3)
        for currTV in listTextviews {
            currTV?.placeholder = promptText
            currTV?.layer.borderWidth = 1
            currTV?.layer.borderColor = UIColor.black.cgColor
        }
        DispatchQueue.main.async {
            self.retrieve()
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
           view.addGestureRecognizer(tap)
        
        
     
        
    }
        
    
    
    
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
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

    
    func retrieve() {
        guard let decoded  = UserDefaults.standard.object(forKey: "motifDataList") else {
            print("decoded is nil")
            return
        }
        guard let data = NSKeyedUnarchiver.unarchiveObject(with: (decoded as! NSObject) as! Data)  else {
            print("data is nil")
            return
        }
        if (data as! [MotifData]).count < 1 {
            return
        }
        TableManager.motifDataList = data as! [MotifData]
        
        UserDefaults.standard.synchronize()


    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.retrieve()

        }
    }

    
    
}

