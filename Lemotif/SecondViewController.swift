//
//  SecondViewController.swift
//  Lemotif
//
//  Created by Irene Lee on 5/7/20.
//  Copyright © 2020 Irene Lee. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //var motifDataList: [MotifData] = []
    override func viewDidLoad() {
        print("viewDidLoad Called")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //TableManager.motifDataList = createArray()

        //TableManager.motifDataList = userDefault.value(forKey: "motifDataList") as? [MotifData] ?? createArray()
      
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func createArray()->[MotifData] {
        var templist: [MotifData] = []
        let item1 = MotifData(image1:UIImage(named: "watercolors")!,image2:UIImage(named: "glass")!,image3:UIImage(named: "tile")!, date: "8-1", emotions: ["happy","fun","tired"], topics:["day", "friends","family"])
        templist.append(item1)
        return templist
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("videDidAppear")
        super.viewDidAppear(animated)
        if(TableManager.isNewSave){
            print("updating the table: \(TableManager.motifDataList)")
            tableView.beginUpdates()
            if (TableManager.motifDataList.count > 1){
                tableView.insertRows(at: [IndexPath(row:0, section: 0)], with: .automatic)

            }
            TableManager.isNewSave = false
            TableManager.newInstanceReady = false

            tableView.endUpdates()

        }
                
        
        //self.tabBarController?.delegate = self
    }

}


extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableManager.motifDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //actually configure the cell
        let item = TableManager.motifDataList[TableManager.motifDataList.count - 1 - indexPath.row] // whatever item is at the row
        let cell = tableView.dequeueReusableCell(withIdentifier: "MotifCell") as! MotifCell
        cell.setMotif(motifData: item)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TableManager.selectedIndex = indexPath.row
        print("row: \(TableManager.selectedIndex)")

        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showEntry", sender: self)
    }
    
    
}
