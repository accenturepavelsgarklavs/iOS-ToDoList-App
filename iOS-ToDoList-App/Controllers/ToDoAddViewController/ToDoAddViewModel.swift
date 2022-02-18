//
//  ToDoAddViewModel.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import Foundation

class ToDoAddViewModel {

    let taskManager = TaskManager.shared
    var onFinish: (() -> Void)?

    func addIfNotEmpty(title: String, description: String) {
        if !title.isEmpty && !description.isEmpty {
            taskManager.addValue(value: .init(title: title, description: description))
        }
    }
}
