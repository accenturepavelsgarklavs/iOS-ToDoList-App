//
//  ToDoViewCell.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import UIKit

final class ToDoViewCell: UICollectionViewCell {

    static let cellId = "ToDoViewCell"

    let toDoTitle = UILabel()
    let toDoDescription = UILabel()
    private let checkBoxButton = UIButton()
    private let editButton = UIButton()
    private let trashButton = UIButton()
    private let buttonConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
    var index: Int?

    let toDoViewCellModel = ToDoViewCellModel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupCell()
    }

    private func setupCell() {
        contentView.backgroundColor = UIColor(red: 252 / 255.0, green: 226 / 255.0, blue: 196 / 255.0, alpha: 1.0)
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor(named: "dairyCream")
        contentView.layer.cornerRadius = 20

        setupCheckBox()
        setupEditButton()
        setupTrashButton()
        setupToDoTitle()
        setupToDoDescription()
    }
}

private extension ToDoViewCell {
    @objc func didTapEditButton() {
        guard let index = index else {
            return
        }
        toDoViewCellModel.onEditButtonTap?(toDoTitle.text, toDoDescription.text, index)
    }

    @objc func didTapCheckBoxButton() {
        if checkBoxButton.tintColor == .red {
            checkBoxButton.tintColor = UIColor(named: "forestGreen")
        } else if checkBoxButton.tintColor == UIColor(named: "forestGreen") {
            checkBoxButton.tintColor = .red
        }
    }

    @objc func didTapTrashButton() {
        toDoViewCellModel.onTrashButtonTap?()
    }

    func setupCheckBox() {
        contentView.addSubview(checkBoxButton)
        let checkedMarkImage = UIImage(systemName: "checkmark.square", withConfiguration: buttonConfig)
        checkBoxButton.setImage(checkedMarkImage, for: .normal)
        checkBoxButton.tintColor = .red

        checkBoxButton.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview().inset(20)
        }
        checkBoxButton.addTarget(self, action: #selector(didTapCheckBoxButton), for: .touchUpInside)
    }

    func setupEditButton() {
        contentView.addSubview(editButton)
        let editImage = UIImage(systemName: "square.and.pencil", withConfiguration: buttonConfig)
        editButton.setImage(editImage, for: .normal)
        editButton.tintColor = .gray

        editButton.snp.makeConstraints { make in
            make.leading.equalTo(checkBoxButton.snp.trailing)
            make.bottom.equalToSuperview().inset(20)
        }
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
    }

    func setupTrashButton() {
        contentView.addSubview(trashButton)
        let trashImage = UIImage(systemName: "trash.square", withConfiguration: buttonConfig)
        trashButton.setImage(trashImage, for: .normal)
        trashButton.tintColor = .gray

        trashButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
        trashButton.addTarget(self, action: #selector(didTapTrashButton), for: .touchUpInside)
    }

    func setupToDoTitle() {
        contentView.addSubview(toDoTitle)
        toDoTitle.numberOfLines = 0
        toDoTitle.textAlignment = .center
        toDoTitle.font = toDoTitle.font.withSize(18)
        toDoTitle.textColor = .black

        toDoTitle.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalToSuperview().offset(20)
        }
    }

    func setupToDoDescription() {
        contentView.addSubview(toDoDescription)
        toDoDescription.numberOfLines = 0
        toDoDescription.font = toDoDescription.font.withSize(16)
        toDoDescription.textColor = .black

        toDoDescription.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(toDoTitle.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
        }
    }
}

