//
//  TodoListViewController.swift
//  Todo_DataBase
//
//  Created by Jaka on 2024-07-02.
//

import UIKit
import SnapKit
import RealmSwift

class TodoListViewController: BaseViewController {

    let titleView = {
        let view = UILabel()
        view.text = "전체"
        view.font = .boldSystemFont(ofSize: 30)
        view.textColor = .systemBlue
        return view
    }()
    
    let tableView = UITableView()
    var list: Results<MainTable>!
    let realm = try! Realm()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(#function)
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        
    }
    
    @objc func leftBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    override func configureHierarchy() {
        view.addSubview(titleView)
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        titleView.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func configureUI() {
        view.backgroundColor = .black
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.id)
        tableView.rowHeight = 100
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.id, for: indexPath) as! TodoListTableViewCell
        
        let data = list[indexPath.row]
        cell.titleLabel.text = data.title
        cell.contentLabel.text = data.textContent
        cell.subLabel.text = data.deadLine
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        
        try! realm.write {
            realm.delete(data)
        }
        tableView.reloadData()
    }
}
