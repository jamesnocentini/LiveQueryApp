//
//  ViewController.swift
//  LiveQueryApp
//
//  Created by James Nocentini on 14/05/2015.
//  Copyright (c) 2015 Couchbase. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CBLUITableDelegate {
    
    var database: CBLDatabase!
    var dataSource: CBLUITableSource!
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.database = CBLManager.sharedInstance().databaseNamed("mydb", error: nil)
        
        self.dataSource = CBLUITableSource()
        self.dataSource.tableView = self.tableView
        self.dataSource.query = self.database.createAllDocumentsQuery().asLiveQuery()
        self.dataSource.labelProperty = "text"
        
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addItem(sender: UIView) {
        var document = self.database.createDocument()
        let properties = ["text": "Random text"];
        document.putProperties(properties, error: nil)
    }

}

