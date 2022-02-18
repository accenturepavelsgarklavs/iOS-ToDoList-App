//
//  AppDelegate.swift
//  iOS-ToDoList-App
//
//  Created by pavels.garklavs on 17/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let addController = ToDoAddViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let toDoViewController = ToDoViewController()
        let navigationController = UINavigationController(rootViewController: toDoViewController)
        let editController = ToDoEditViewController()


        toDoViewController.toDoViewModel.onOpen = { [weak self] titleText, descriptionText, index in
            guard self != nil else {
                return
            }
            guard let index = index else { return }
            editController.editTitleTextField.text = titleText
            editController.editDescriptionTextView.text = descriptionText
            editController.index = index
            navigationController.pushViewController(editController, animated: true)
            toDoViewController.updateCollectionView()
        }

        toDoViewController.toDoViewModel.onAddTap = { [weak self] in
            guard let self = self else {
                return
            }
            let addController = self.makeViewControllerForAdd(controller: toDoViewController)
            navigationController.pushViewController(addController, animated: true)
        }

        editController.toDoEditViewModel.onFinish = { [weak self] in
            guard self != nil else {
                return
            }
            toDoViewController.updateCollectionView()
            toDoViewController.navigationController?.popToRootViewController(animated: true)
        }

        window?.rootViewController = navigationController

        return true
    }

    func makeViewControllerForAdd(controller: ToDoViewController) -> UIViewController {
        addController.toDoAddViewModel.onFinish = { [weak self] in
            guard self != nil else {
                return
            }
            controller.updateCollectionView()
            controller.navigationController?.popToRootViewController(animated: true)
        }
        return addController
    }
}

