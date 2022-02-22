//
//  ToDoAddViewController.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import UIKit

final class ToDoAddViewController: BaseViewController {

    let toDoAddViewModel = ToDoAddViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setNavigationTitle(title: "Add Task")
        setupAddButton()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        titleTextField.text = ""
        descriptionTextView.text = ""
    }

    private func setupAddButton() {
        setButtonTitle(title: "Add")
        completionButton.addTarget(self, action: #selector(didTapAddToCollectionViewButton), for: .touchUpInside)
    }

    @objc func didTapAddToCollectionViewButton() {
        guard let title = titleTextField.text else { return }
        toDoAddViewModel.addIfNotEmpty(title: title, description: descriptionTextView.text)
        toDoAddViewModel.onFinish?()
    }
}

