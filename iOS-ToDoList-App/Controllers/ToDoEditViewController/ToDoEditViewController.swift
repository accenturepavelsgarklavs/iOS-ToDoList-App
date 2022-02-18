//
//  ToDoEditViewController.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import UIKit

class ToDoEditViewController: UIViewController {

    let editTitleTextField = UITextField()
    let editDescriptionTextView = UITextView()
    private let saveButton = UIButton()
    let toDoEditViewModel = ToDoEditViewModel()
    var index: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Task"
        view.backgroundColor = .white
        setupNavigationBar()
        setupEditTitle()
        setupEditDescription()
        setupSaveButtonToCollectionView()
    }
}

private extension ToDoEditViewController {
    func setupNavigationBar() {
        navigationItem.title = "Edit Task"
        navigationController?.navigationBar.tintColor = UIColor(named: "tigerOrange")
    }

    func setupEditTitle() {
        view.addSubview(editTitleTextField)

        editTitleTextField.delegate = self
        editTitleTextField.placeholder = "Title"
        editTitleTextField.borderStyle = .roundedRect
        editTitleTextField.returnKeyType = .continue
        editTitleTextField.backgroundColor = UIColor(named: "dairyCream")

        editTitleTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.right.left.equalToSuperview().inset(50)
            make.top.equalToSuperview().offset(100)
        }
    }

    func setupEditDescription() {
        view.addSubview(editDescriptionTextView)

        editDescriptionTextView.delegate = self
        editDescriptionTextView.layer.cornerRadius = 3
        editDescriptionTextView.returnKeyType = .done
        editDescriptionTextView.backgroundColor = UIColor(named: "dairyCream")

        editDescriptionTextView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.right.left.equalToSuperview().inset(50)
            make.top.equalTo(editTitleTextField.snp.bottom).offset(20)
        }
    }

    func setupSaveButtonToCollectionView() {
        view.addSubview(saveButton)

        saveButton.layer.cornerRadius = 3
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.setTitleColor(.gray, for: .highlighted)
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = UIColor(named: "dairyCream")

        saveButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.right.left.equalToSuperview().inset(100)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
            make.top.equalTo(editDescriptionTextView.snp.bottom).offset(50)
        }

        saveButton.addTarget(self, action: #selector(didTapSaveToCollectionViewButton), for: .touchUpInside)
    }
}

extension ToDoEditViewController: UITextFieldDelegate {
    @objc func didTapSaveToCollectionViewButton() {
        toDoEditViewModel.updateValue(index: index, value: .init(title: editTitleTextField.text, description: editDescriptionTextView.text))
        toDoEditViewModel.onFinish?()
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

extension ToDoEditViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars <= 128
    }
}
