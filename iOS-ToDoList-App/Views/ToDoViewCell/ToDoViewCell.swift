//
//  ToDoViewCell.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import UIKit

final class ToDoViewCell: UICollectionViewCell {

    struct Constants {
        static let insetValue = 20
        static let offsetValue = 20
    }

    static let reuseIdentifier = "ToDoViewCell"

    private let checkBoxButton = UIButton()
    private let editButton = UIButton()
    private let trashButton = UIButton()
    private let buttonConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
    let toDoTitle = UILabel()
    let toDoDescription = UILabel()
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
        toDoViewCellModel.onEditButtonTap?(toDoTitle.text, toDoDescription.text, index)
    }

    @objc func didTapCheckBoxButton() {
        if checkBoxButton.tintColor == .red {
            checkBoxButton.tintColor = UIColor(named: "forestGreen")
        } else {
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
            make.bottom.left.equalToSuperview().inset(Constants.insetValue)
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
            make.bottom.equalToSuperview().inset(Constants.insetValue)
        }
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
    }

    func setupTrashButton() {
        contentView.addSubview(trashButton)
        let trashImage = UIImage(systemName: "trash.square", withConfiguration: buttonConfig)
        trashButton.setImage(trashImage, for: .normal)
        trashButton.tintColor = .gray

        trashButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.insetValue)
            make.bottom.equalToSuperview().inset(Constants.insetValue)
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
            make.top.equalToSuperview().offset(Constants.offsetValue)
        }
    }

    func setupToDoDescription() {
        contentView.addSubview(toDoDescription)
        toDoDescription.numberOfLines = 0
        toDoDescription.lineBreakMode = .byWordWrapping
        toDoDescription.font = toDoDescription.font.withSize(16)
        toDoDescription.textColor = .black

        toDoDescription.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(toDoTitle.snp.bottom).offset(Constants.offsetValue)
            make.left.equalToSuperview().offset(30)
        }
    }
}

