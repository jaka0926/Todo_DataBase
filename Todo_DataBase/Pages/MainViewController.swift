//
//  MainViewController.swift
//  Todo_DataBase
//
//  Created by Jaka on 2024-07-02.
//

import UIKit
import SnapKit
import RealmSwift

class MainViewController: BaseViewController {

    let addListItemButton = UIButton()
    let addListButton = UIButton()
    let titleLabel = {
        let view = UILabel()
        view.text = "전체"
        view.font = .boldSystemFont(ofSize: 30)
        view.textColor = .darkGray
        return view
    }()
    lazy var collView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width/2, height: width/4)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.collectionView?.isScrollEnabled = false
        return layout
    }
    var list: [[Any]] = []
    let realm = try! Realm()
    let vc = TodoListViewController()
    
    func addNewCell(_ title: String, _ icon: String, _ iconColor: UIColor) {
        let item = [title, icon, iconColor] as [Any]
        list.append(item)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Main", #function)
        
        collView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        vc.list = realm.objects(MainTable.self)
        
    }
    
    override func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(collView)
        view.addSubview(addListItemButton)
        view.addSubview(addListButton)
    }
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        collView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        addListItemButton.snp.makeConstraints { make in
            make.left.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        addListButton.snp.makeConstraints { make in
            make.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    override func configureUI() {
        collView.backgroundColor = .clear
        collView.delegate = self
        collView.dataSource = self
        collView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
        
        addNewCell("오늘", "sun.max.fill", .systemBlue)
        addNewCell("예정", "calendar", .systemRed)
        addNewCell("전체", "tray.fill", .systemGray)
        addNewCell("깃발 표시", "flag.fill", .systemOrange)
        addNewCell("완료됨", "checkmark", .systemGreen)
        
        addListItemButton.setTitleColor(.systemBlue, for: .normal)
        addListItemButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        addListItemButton.setTitle("새로운 할 일", for: .normal)
        addListItemButton.addTarget(self, action: #selector(addListItemButtonClicked), for: .touchUpInside)
        
        addListButton.setTitleColor(.systemBlue, for: .normal)
        addListButton.tintColor = .systemBlue
        addListButton.setTitle("목록 추가", for: .normal)
    }
    @objc func addListItemButtonClicked() {
        let vc = AddNewViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, for: indexPath) as! MainCollectionViewCell
        
        let titleData = list[indexPath.row][0]
        let iconData = list[indexPath.row][1]
        let iconColor = list[indexPath.row][2]
        cell.configureUI(titleData as! String, iconData as! String, iconColor: iconColor as! UIColor, vc.list.count)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
