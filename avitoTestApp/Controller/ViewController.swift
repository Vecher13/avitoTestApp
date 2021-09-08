//
//  ViewController.swift
//  avitoTestApp
//
//  Created by Ash on 07.09.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet var tableView: UITableView!
    let network = Network.shared
    private var employees: [Employee] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCardTableViewCell.nib(), forCellReuseIdentifier: UserCardTableViewCell.identifire)
        network.getData { complition in
            self.employees = complition.employees
            self.tableView.reloadData()
        }
    }

    
    //MARK: - tableVIew
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCardTableViewCell.identifire, for: indexPath) as? UserCardTableViewCell else {return UITableViewCell()}
        let employee = employees[indexPath.row]
//        print(employee.name)
        cell.configCell(with: employee)
        return cell
    }
    

}

