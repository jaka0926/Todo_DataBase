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
    let dateConfig = UIButton()
    let dateValue = UILabel()
    let tagConfig = UIButton()
    let tagValue = UILabel()
    let priorityConfig = UIButton()
    let priorityValue = UILabel()
    let imageConfig = UIButton()

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
        //let data = MainTable(title: titleLabel.text!, textContent: contentLabel.text ?? "", deadLine: deadlineDatePicker.date)
        
        //Realm에 data를 추가하기
        try! realm.write {
            //realm.add(data)
        }
//        TodoListViewController().tableView.reloadData()
        
        dismiss(animated: true)
    }
    
    override func configureHierarchy() {
        view.addSubview(textView)
        textView.addSubview(titleLabel)
        textView.addSubview(contentLabel)
        view.addSubview(dateConfig)
        view.addSubview(dateValue)
        view.addSubview(tagConfig)
        view.addSubview(tagValue)
        view.addSubview(priorityConfig)
        view.addSubview(priorityValue)
        view.addSubview(imageConfig)
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
        dateConfig.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(textView)
            make.height.equalTo(50)
        }
        dateValue.snp.makeConstraints { make in
            make.center.equalTo(dateConfig)
            make.left.equalTo(dateConfig).offset(50)
        }
        tagConfig.snp.makeConstraints { make in
            make.top.equalTo(dateConfig.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(textView)
            make.height.equalTo(50)
        }
        tagValue.snp.makeConstraints { make in
            make.center.equalTo(tagConfig)
            make.left.equalTo(tagConfig).offset(50)
        }
        priorityConfig.snp.makeConstraints { make in
            make.top.equalTo(tagConfig.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(textView)
            make.height.equalTo(50)
        }
        priorityValue.snp.makeConstraints { make in
            make.center.equalTo(priorityConfig)
            make.left.equalTo(priorityConfig).offset(50)
        }
        imageConfig.snp.makeConstraints { make in
            make.top.equalTo(priorityConfig.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(textView)
            make.height.equalTo(50)
        }
    }
    override func configureUI() {
        view.backgroundColor = .darkGray
        textView.backgroundColor = .gray
        textView.layer.cornerRadius = 10
        
        titleLabel.placeholder = "제목"
        titleLabel.textColor = .white
        contentLabel.placeholder = "메모"
        contentLabel.textColor = .white
        
        dateConfig.configuration = .configButton("마감일")
        dateConfig.backgroundColor = .gray
        dateConfig.layer.cornerRadius = 10
        dateConfig.addTarget(self, action: #selector(dateConfigButtonClicked), for: .touchUpInside)
            dateValue.font = .systemFont(ofSize: 14)
            dateValue.textAlignment = .center
        
        tagConfig.configuration = .configButton("태그")
        tagConfig.backgroundColor = .gray
        tagConfig.layer.cornerRadius = 10
        tagConfig.addTarget(self, action: #selector(tagConfigButtonClicked), for: .touchUpInside)
            tagValue.font = .systemFont(ofSize: 14)
            tagValue.textAlignment = .center
        
        priorityConfig.configuration = .configButton("우선순위")
        priorityConfig.backgroundColor = .gray
        priorityConfig.layer.cornerRadius = 10
        priorityConfig.addTarget(self, action: #selector(priorityConfigButtonClicked), for: .touchUpInside)
            priorityValue.font = .systemFont(ofSize: 14)
            priorityValue.textAlignment = .center
        
        imageConfig.configuration = .configButton("이미지 추가")
        imageConfig.backgroundColor = .gray
        imageConfig.layer.cornerRadius = 10
        
    }
    @objc func dateConfigButtonClicked() {
        let vc = DatePickerViewController()
        vc.title = dateConfig.configuration?.title
        vc.dateInfo = { value in
            print(value)
            self.dateValue.text = value
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func tagConfigButtonClicked() {
        let vc = TagViewController()
        vc.title = tagConfig.configuration?.title
        vc.tagInfo = { value in
            print(value)
            self.tagValue.text = value
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func priorityConfigButtonClicked() {
        let vc = PriorityViewController()
        vc.title = priorityConfig.configuration?.title
        vc.priorityInfo = { value in
            var textValue = ""
            switch value {
            case 0: textValue = "낮음"
            case 1: textValue = "보통"
            case 2: textValue = "높음"
            default: print("Error")
            }
            self.priorityValue.text = textValue
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func imageConfigButtonClicked() {
//        let vc =
//        vc.title = priorityConfig.configuration?.title
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}
