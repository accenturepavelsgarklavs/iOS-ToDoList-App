//
//  ToDoEditViewController.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import UIKit

class ToDoEditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Task"
        view.backgroundColor = .white
        setupNavigationBar()
    }
}

private extension ToDoEditViewController {
    func setupNavigationBar() {
        navigationItem.title = "Edit Task"
        navigationController?.navigationBar.tintColor = UIColor(named: "tigerOrange")
    }
}

