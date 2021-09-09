//
//  ViewController.swift
//  avitoTestApp
//
//  Created by Ash on 07.09.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet var tableView: UITableView!
    let network = NetworkService.shared
    private var employees: [Employee] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCardTableViewCell.nib(), forCellReuseIdentifier: UserCardTableViewCell.identifire)
       
           }
         
    func getData(){
        network.getData { complition in
            
            switch complition {
            case .success(let company):
                self.employees = company.employees
                self.tableView.reloadData()
            case .failure(_):
                DispatchQueue.main.async {
                    self.alertAction()
                }
                print("NO INET")
            }
        }
    }
    
    //MARK: - tableVIew
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCardTableViewCell.identifire, for: indexPath) as? UserCardTableViewCell else {return UITableViewCell()}
        let employee = employees[indexPath.row]
        cell.configCell(with: employee)
        return cell
    }
    

}

//MARK:- AlertController

extension ViewController{
    func alertAction(){
        let alert = UIAlertController(title: "Что-то пошло не так...", message: "Кажтеся проблемы с соединениме. \n Попробуем еще раз?", preferredStyle: .alert)
        let reloadAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.getData()
             
        }
        let cancelAction = UIAlertAction(title: "Выход", style: .destructive, handler: nil)
        alert.addAction(reloadAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}
