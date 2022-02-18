//
//  ToDoAddViewController.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import UIKit

class ToDoAddViewController: UIViewController {

    private let titleTextField = UITextField()
    private let descriptionTextView = UITextView()
    private let addButtonToCollectionView = UIButton()
    let toDoAddViewModel = ToDoAddViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupTitleTextField()
        setupDescriptionTextField()
        setupAddButtonToCollectionView()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        titleTextField.text = ""
        descriptionTextView.text = ""
    }
}

private extension ToDoAddViewController {

    func setupNavigationBar() {
        navigationItem.title = "Add Task"
        navigationController?.navigationBar.tintColor = UIColor(named: "tigerOrange")
    }

    func setupTitleTextField() {
        view.addSubview(titleTextField)

        titleTextField.delegate = self
        titleTextField.placeholder = "Title"
        titleTextField.borderStyle = .roundedRect
        titleTextField.returnKeyType = .continue
        titleTextField.backgroundColor = UIColor(named: "dairyCream")

        titleTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.right.left.equalToSuperview().inset(50)
            make.top.equalToSuperview().offset(100)
        }
    }

    func setupDescriptionTextField() {
        view.addSubview(descriptionTextView)

        descriptionTextView.delegate = self
        descriptionTextView.layer.cornerRadius = 3
        descriptionTextView.returnKeyType = .done
        descriptionTextView.backgroundColor = UIColor(named: "dairyCream")

        descriptionTextView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.right.left.equalToSuperview().inset(50)
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
        }
    }

    func setupAddButtonToCollectionView() {
        view.addSubview(addButtonToCollectionView)

        addButtonToCollectionView.layer.cornerRadius = 3
        addButtonToCollectionView.setTitleColor(.black, for: .normal)
        addButtonToCollectionView.setTitleColor(.gray, for: .highlighted)
        addButtonToCollectionView.setTitle("Add", for: .normal)
        addButtonToCollectionView.backgroundColor = UIColor(named: "dairyCream")

        addButtonToCollectionView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.right.left.equalToSuperview().inset(100)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
            make.top.equalTo(descriptionTextView.snp.bottom).offset(50)
        }

        addButtonToCollectionView.addTarget(self, action: #selector(didTapAddToCollectionViewButton), for: .touchUpInside)
    }
}

extension ToDoAddViewController: UITextFieldDelegate {
    @objc func didTapAddToCollectionViewButton() {
        guard let title = titleTextField.text else {
            return
        }
        guard let description = descriptionTextView.text else {
            return
        }

        toDoAddViewModel.addIfNotEmpty(title: title, description: description)
        toDoAddViewModel.onFinish?()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""

        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updateText = currentText.replacingCharacters(in: stringRange, with: string)
        return updateText.count <= 24
    }
}

extension ToDoAddViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars <= 128
    }
}

