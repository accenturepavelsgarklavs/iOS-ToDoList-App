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
    private let toDoAddViewController = ToDoAddViewController()
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
            make.trailing.leading.equalToSuperview()
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
        layout.itemSize = CGSize(width: view.bounds.size.width - 50, height: 250)
        toDoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
}

extension ToDoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToDoViewCell.cellId, for: indexPath) as? ToDoViewCell else {
            return .init()
        }
        cell.toDoTitle.text = toDoViewModel.taskManager.getTitle(index: indexPath.row)
        cell.toDoDescription.text = toDoViewModel.taskManager.getDescription(index: indexPath.row)
        cell.toDoViewCellModel.onEditButtonTap = toDoViewModel.onOpen

        cell.toDoViewCellModel.onTrashButtonTap = { [weak self] in
            guard let self = self else {
                return
            }
            self.toDoViewModel.taskManager.title.remove(at: indexPath.row)
            self.toDoViewModel.taskManager.description.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
        }
        return cell
    }
}

extension ToDoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        toDoViewModel.taskManager.title.count
    }
}
