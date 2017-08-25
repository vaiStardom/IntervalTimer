//
//  ViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class TimersViewController: UIViewController {

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    let datasource = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9", "Item 10", "Item 11", "Item 12", "Item 13", "Item 14", "Item 15"]
    
}
//MARK: - Actions
extension TimersViewController{
    func addTimer(){
        //performSegue(withIdentifier: "TimersToEditTimer", sender: nil)
        performSegue(withIdentifier: "TimersToTimer", sender: nil)
    }
}

//MARK: - Life-Cycle
extension TimersViewController{
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TimersTableViewCell", bundle: nil), forCellReuseIdentifier: "TimersCell")
        configureNavBar()
    }
}
