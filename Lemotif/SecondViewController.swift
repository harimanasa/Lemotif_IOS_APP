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
        super.viewDidLoad()
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
        super.viewDidAppear(animated)
        tableView.reloadData()
        
        
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
        cell.setMotif(motifData: item as! MotifData)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TableManager.selectedIndex = indexPath.row

        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showEntry", sender: self)
    }
    
    
}
