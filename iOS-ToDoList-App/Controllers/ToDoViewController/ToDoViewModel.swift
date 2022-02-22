//
//  ToDoViewModel.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import Foundation

final class ToDoViewModel {
    let taskManager = TaskManager.shared

    var onOpen: ((String?, String?, Int?) -> Void)?
    var onAddTap: (() -> Void)?
}
