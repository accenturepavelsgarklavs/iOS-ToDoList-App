//
//  ToDoViewController.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import UIKit
import SnapKit

final class ToDoViewController: UIViewController {

    private var toDoCollectionView: UICollectionView?
    private let layout = UICollectionViewFlowLayout()
    let toDoViewModel = ToDoViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupNavigationBar()
        setupCollection()
    }

    func updateCollectionView() {
        toDoCollectionView?.reloadData()
    }
}

private extension ToDoViewController {
    func setupCollection() {
        guard let toDoCollectionView = toDoCollectionView else {
            return
        }
        toDoCollectionView.register(ToDoViewCell.self, forCellWithReuseIdentifier: ToDoViewCell.cellId)
        toDoCollectionView.dataSource = self
        toDoCollectionView.delegate = self
        view.addSubview(toDoCollectionView)

        toDoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(30)
            make.bottom.equalToSuperview()
            make.right.left.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

private extension ToDoViewController {
    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }

    @objc func addTapped() {
        toDoViewModel.onAddTap?()
    }

    func setupNavigationBar() {
        navigationItem.title = "To-Do List"
        let addButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTapped))
        addButton.tintColor = UIColor(named: "tigerOrange")
        navigationItem.rightBarButtonItem = addButton
    }

    func setupLayout() {
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 220, height: 300)
        toDoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
}

extension ToDoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToDoViewCell.cellId, for: indexPath) as? ToDoViewCell else {
            return .init()
        }

        cell.index = indexPath.row

        let modelValue = toDoViewModel.taskManager.getValue(index: indexPath.row)
        cell.toDoTitle.text = modelValue.title
        cell.toDoDescription.text = modelValue.description
        cell.toDoViewCellModel.onEditButtonTap = toDoViewModel.onOpen

        cell.toDoViewCellModel.onTrashButtonTap = { [weak self] in
            guard let self = self else {
                return
            }
            self.toDoViewModel.taskManager.removeValue(index: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
            self.updateCollectionView()
        }
        return cell
    }
}

extension ToDoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = toDoViewModel.taskManager.model.count

        // Making sure does not throw an error OutOfBoundsException because of deletion last cell
        if count == -1 {
            return 0
        }

        return count
    }
}
