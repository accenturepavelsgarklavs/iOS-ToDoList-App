//
//  ToDoAddViewModel.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import Foundation

class ToDoAddViewModel {

    let taskManager = TaskManager.shared

    var onAddToCollectionViewButtonTap: ((_ titleText: String?, _ descriptionText: String?) -> Void)?
    var onFinish: (() -> Void)?

    func addIfNotEmpty(title: String, description: String) {
        if !title.isEmpty && !description.isEmpty {
            addToNewCell(title: title, description: description)
        }
    }

    func addToNewCell(title: String, description: String) {

        if !title.isEmpty && !description.isEmpty {
            taskManager.addTitle(value: title)
            taskManager.addDescription(value: description)
        }
    }
}
