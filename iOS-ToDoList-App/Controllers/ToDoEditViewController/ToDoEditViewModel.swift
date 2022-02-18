//
//  ToDoEditViewModel.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import Foundation

class ToDoEditViewModel {

    var onFinish: (() -> Void)?
    var taskManager = TaskManager.shared

    func updateValue(index: Int, value: TaskManager.Model) {
        taskManager.updateValue(index: index, value: value)
    }
}
