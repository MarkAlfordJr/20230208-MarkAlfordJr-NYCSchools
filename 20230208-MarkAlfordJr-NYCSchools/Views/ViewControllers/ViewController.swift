//
//  ViewController.swift
//  20230208-MarkAlfordJr-NYCSchools
//
//  Created by Mark Alford on 2/8/23.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - TableView UI
    var tableArray: SchoolResponseModelArray = []
    let tableView: UITableView = {
        let table = UITableView()
        table.register(SchoolResponseTableViewCell.self, forCellReuseIdentifier: SchoolResponseTableViewCell.identifier)
        return table
    }()
    
    //MARK: - Setup and API call
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Schools"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        let endpoint = SchoolAPI.getschools
        NetworkManager.request(endpoint: endpoint) { [weak self] (result: Result<SchoolResponseModelArray, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.tableArray = response
                    self?.tableView.reloadData()
                    // testing the JSON
                    print(response[4].schoolName)
                    print(response[4].dbn)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

//MARK: - Tableview Protocol Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolResponseTableViewCell.identifier, for: indexPath) as? SchoolResponseTableViewCell else {
            fatalError("tableviewCell not working")
        }
        // fill the custom cell UI values with JSON data
        let cellArray = tableArray[indexPath.row]
        cell.configureCell(dbn: cellArray.dbn, school: cellArray.schoolName, phone: cellArray.phoneNumber, neighborhood: cellArray.neighborhood, address: cellArray.location)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK: - Navigation
    // allows EACH cell to navigate to the scoreVC with its own unique scoreData loaded
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellArray = tableArray[indexPath.row]
        let scoreVC = SATScoreViewController(dbnName: cellArray.dbn, school: cellArray.schoolName)
        navigationController?.pushViewController(scoreVC, animated: true)
    }
}

