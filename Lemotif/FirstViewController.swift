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
    
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var firstEntry: UIStackView!
    @IBOutlet weak var secondEntry: UIStackView!
    @IBOutlet weak var lastEntry: UIStackView!
    
    static var isLast = false
    var currTap : CGFloat = 0
    static var timeToShow = false
    

    
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
        
        //Dismisses keyboard when the view is touched.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        let tap2 = UITapGestureRecognizer(target: self, action: "isLastEntry")


        self.view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        

     
        
    }

    
    
   @objc func isLastEntry() {
    }
        
    @objc func keyboardWillShow(notification: NSNotification) {
        while(!FirstViewController.timeToShow) {}

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if  FirstViewController.isLast && self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {

        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        FirstViewController.timeToShow = false

    }
    

  
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        FirstViewController.isLast = false

        view.endEditing(true)
    }
    
    @IBAction func makeCall(_ sender: Any) {
        textView3.endEditing(true)
        self.view.endEditing(true)
        
        
        JsonHandler.inputString = [textView1.text!, textView2.text!,textView3.text!]
        for i in 0...2 {
            if (JsonHandler.inputString[i] == ""){
                JsonHandler.inputString[i] = " ";
            }
        }
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
            return
        }
        guard let data = NSKeyedUnarchiver.unarchiveObject(with: (decoded as! NSObject) as! Data)  else {
            return
        }
        if (data as! [MotifData]).count < 1 {
            return
        }
        TableManager.motifDataList = data as! [MotifData]
        
        UserDefaults.standard.synchronize()


    }
    override func viewDidAppear(_ animated: Bool) {
        self.textView3.endEditing(true)
        DispatchQueue.main.async {
            self.retrieve()

        }
    }

    
    
    
}


extension FirstViewController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }



}
