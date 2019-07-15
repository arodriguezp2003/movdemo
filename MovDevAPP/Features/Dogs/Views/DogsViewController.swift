//
//  DogsViewController.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.


import UIKit

fileprivate let CELL = "_cell"
protocol DogsDisplayLogic: class {
    func getDogList( _ list: [DogEntity])
    func errorData( _ message: String)
}

class DogsViewController: UIViewController, DogsDisplayLogic{
   
    var presenter: DogsPresentationLogic?
    var list: [DogEntity] = []
    
    
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    // MARK: Object lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupTableView()
        presenter?.getDogList()
    }
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL)
    }
    private func setup() {
        view.addSubview(tableView)
        view!.addContraintsWithFormat(format: "H:|[v0]|", views: self.tableView)
        view!.addContraintsWithFormat(format: "V:|[v0]|", views: self.tableView)
        navigationItem.title = "Categories"
    }
   
    func getDogList(_ list: [DogEntity]) {
        DispatchQueue.main.async {
            self.list = list
            self.tableView.reloadData()
        }
    }
    
    func errorData(_ message: String) {
        let vc = AlertRetryFactory().getAlertRetryViewController(title: "Ups :(", subtitle: message)
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    
}
extension DogsViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL)
        cell?.accessoryType = .disclosureIndicator
        
        let obj = self.list[indexPath.item]
        cell?.textLabel?.text = obj.name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj = self.list[indexPath.item]
        let vc = DetailDogFactory().getDetailDogViewController(obj.name)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension DogsViewController: AlertRetryDelegate {
    func retry() {
         presenter?.getDogList()
    }
}
