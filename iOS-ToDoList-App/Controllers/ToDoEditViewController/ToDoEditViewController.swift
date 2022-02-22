//
//  ToDoEditViewController.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import UIKit

final class ToDoEditViewController: BaseViewController {
    let toDoEditViewModel = ToDoEditViewModel()

    override func viewDidLoad() {
        setupController()
        setNavigationTitle(title: "Edit Task")
        setupSaveButton()
    }

    private func setupSaveButton() {
        setButtonTitle(title: "Save")
        completionButton.addTarget(self, action: #selector(didTapCompletionToCollectionViewButton), for: .touchUpInside)
    }

    @objc func didTapCompletionToCollectionViewButton() {
        toDoEditViewModel.updateValue(index: index, value: .init(title: titleTextField.text, description: descriptionTextView.text))
        toDoEditViewModel.onFinish?()
    }

    func configure(title: String, description: String, index: Int) {
        titleTextField.text = title
        descriptionTextView.text = description
        self.index = index
    }
}
