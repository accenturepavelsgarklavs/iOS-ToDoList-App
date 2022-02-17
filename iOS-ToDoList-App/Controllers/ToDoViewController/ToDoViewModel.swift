//
//  ToDoViewModel.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import Foundation

class ToDoViewModel {

    let taskManager = TaskManager.shared

    var onOpen: ((String?) -> Void)?
    var onAddTap: (() -> Void)?
}
