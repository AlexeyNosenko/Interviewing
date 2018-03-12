//
//  CoreDataTableViewController.swift
//  Interviewing
//
//  Created by Алексей on 15.01.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import CoreData

class ManTableViewController: UITableViewController {

    var mans: [Man]!
    var manDBCoreData = ManDBCoreData()
    
    func show(id: Int, firstname: String, lastname: String){
        let alert = UIAlertController(title: "Add man", message: "Enter man:", preferredStyle: .alert)
        
        print("Current id \(id)")
        alert.addTextField { (tf) in
            tf.placeholder = "Enter firstname"
            tf.text = firstname
        }
        alert.addTextField { (tf) in
            tf.placeholder = "Enter lastname"
            tf.text = lastname
        }
        
        let actionAdd = UIAlertAction.init(title: "Ok", style: .default) {[weak self] (_) in
            if (id == 0){
                self?.manDBCoreData.save(firstname: alert.textFields![0].text!, lastname: alert.textFields![1].text!)
            } else {
                self?.manDBCoreData.update(id: id, firstname: firstname, lastname: lastname)
            }
            self?.updateUI()
        }
        
        let actionCancel = UIAlertAction.init(title: "Cancel", style: .cancel)
        alert.addAction(actionAdd)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: Any) {
        show(id: 0, firstname: "", lastname: "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //saveMans(firstname: "foo", lastname: "bar12")
        print("Count load - \(mans.count)")
    }
    
    func updateUI(){
        mans = manDBCoreData.getAll()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mans.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let manCell = cell as? ManTableViewCell{
            let man = mans[indexPath.row]
            manCell.setCell(man: man)
        }
        print("Count table view - \(mans.count)")
        
        return cell
    }
}
