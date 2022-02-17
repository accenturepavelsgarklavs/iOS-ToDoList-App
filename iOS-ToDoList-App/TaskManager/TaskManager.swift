//
//  TaskManager.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import Foundation

class TaskManager {

    private init() {
    }

    static var shared = TaskManager()
    var title: [String] = []
    var description: [String] = []

    func addTitle(value: String) {
        title.append(value)
    }

    func getTitle(index: Int) -> String {
        guard title.count > index else {
            return ""
        }
        return title[index]
    }

    func addDescription(value: String) {
        description.append(value)
    }

    func getDescription(index: Int) -> String {
        guard description.count > index else {
            return ""
        }
        return description[index]
    }
}
