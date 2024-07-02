//
//  AddNewViewController.swift
//  Todo_DataBase
//
//  Created by Jaka on 2024-07-02.
//

import UIKit
import SnapKit
import RealmSwift

class AddNewViewController: BaseViewController {
    
    let textView = UIView()
    let titleLabel = UITextField()
    let contentLabel = UITextField()
    let deadLineLabel = UILabel()
    let deadlineDatePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "새로운 할 일"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let leftBarButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.leftBarButtonItem = leftBarButton
        
        configureRightBarButton(false)
        titleLabel.addTarget(self, action: #selector(activateSaveButton), for: .editingChanged)
    }
    @objc func activateSaveButton() {
        
        if titleLabel.text != "" {
            configureRightBarButton(true)
        }
        else {
            configureRightBarButton(false)
        }
    }
    func configureRightBarButton(_ isEnabled: Bool) {
        let rightBarButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(rightBarButtonClicked))
        rightBarButton.isEnabled = isEnabled
        navigationItem.rightBarButtonItem = rightBarButton
    }
    @objc func leftBarButtonClicked() {
        dismiss(animated: true)
    }
    @objc func rightBarButtonClicked() {
        
        //Create 1. Realm 위치 찾기
        let realm = try! Realm()
        
        guard let title = titleLabel.text, !title.isEmpty else {
            print("제목을 입력해주셔야 합니다")
            return
        }
        
        //Record/Row 생성
        let data = MainTable(title: titleLabel.text!, textContent: contentLabel.text ?? "", deadLine: deadlineDatePicker.date)
        
        //Realm에 data를 추가하기
        try! realm.write {
            realm.add(data)
        }
//        TodoListViewController().tableView.reloadData()
        
        dismiss(animated: true)
    }
    
    override func configureHierarchy() {
        view.addSubview(textView)
        textView.addSubview(titleLabel)
        textView.addSubview(contentLabel)
        view.addSubview(deadlineDatePicker)
        view.addSubview(deadLineLabel)
    }
    override func configureLayout() {
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(200)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(10)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        deadLineLabel.snp.makeConstraints { make in
            make.left.equalTo(deadlineDatePicker).offset(20)
            make.verticalEdges.equalTo(deadlineDatePicker)
        }
        deadlineDatePicker.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(textView)
            make.height.equalTo(50)
        }
    }
    override func configureUI() {
        view.backgroundColor = .darkGray
        textView.backgroundColor = .gray
        textView.layer.cornerRadius = 10
        
        titleLabel.placeholder = "제목"
        contentLabel.placeholder = "메모"
        
        deadLineLabel.text = "마감일"
        deadlineDatePicker.backgroundColor = .gray
        deadlineDatePicker.layer.cornerRadius = 10
        deadlineDatePicker.clipsToBounds = true
        deadlineDatePicker.tintColor = .white
    }
}
