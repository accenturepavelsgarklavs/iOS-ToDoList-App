//
//  TaskManager.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import Foundation

class TaskManager {

    struct Model: Codable {
        var title: String?
        var description: String?
    }

    private init() {
    }

    static var shared = TaskManager()
    var model: [Model] = []

    func updateValue(index: Int, value: Model) {
        model[index] = value
    }

    func getValue(index: Int) -> Model {
        guard model.count > index else {
            return .init(title: "", description: "")
        }
        return model[index]
    }

    func addValue(value: Model) {
        model.append(value)
    }

    func removeValue(index: Int) {
        model.remove(at: index)
    }
}
