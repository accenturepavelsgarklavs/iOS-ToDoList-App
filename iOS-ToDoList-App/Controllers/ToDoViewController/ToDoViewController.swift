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
    let toDoViewModel = ToDoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupCollection()
    }

    func updateCollectionView() {
        toDoCollectionView?.reloadData()
    }
}

private extension ToDoViewController {
    @objc func addTapped() {
        toDoViewModel.onAddTap?()
    }

    func setupCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 220, height: 300)
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        toDoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        if let toDoCollectionView = toDoCollectionView {
            toDoCollectionView.translatesAutoresizingMaskIntoConstraints = false
            toDoCollectionView.register(ToDoViewCell.self, forCellWithReuseIdentifier: ToDoViewCell.reuseIdentifier)
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

    func setupNavigationBar() {
        navigationItem.title = "To-Do List"
        let addButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTapped))
        addButton.tintColor = UIColor(named: "tigerOrange")
        navigationItem.rightBarButtonItem = addButton
    }
}

extension ToDoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToDoViewCell.reuseIdentifier, for: indexPath) as? ToDoViewCell else {
            return .init()
        }

        cell.index = indexPath.row

        let modelValue = toDoViewModel.taskManager.getValue(index: indexPath.row)
        cell.toDoTitle.text = modelValue?.title
        cell.toDoDescription.text = modelValue?.description
        cell.toDoViewCellModel.onEditButtonTap = toDoViewModel.onOpen

        cell.toDoViewCellModel.onTrashButtonTap = { [weak self] in
            guard let self = self else {
                return
            }
            self.toDoViewModel.taskManager.removeValue(index: indexPath.row)
            collectionView.reloadData()
        }
        return cell
    }
}

extension ToDoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = toDoViewModel.taskManager.model.count
        return count
    }
}

//extension ToDoViewController: UICollectionViewDelegateFlowLayout {
//
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return .init(width: 220, height: 300)
//    }
//}
