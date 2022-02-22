//
//  ToDoVieweCellModel.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import Foundation

final class ToDoViewCellModel {
    var onEditButtonTap: ((String?, String?, Int?) -> Void)?
    var onTrashButtonTap: (() -> Void)?
}
