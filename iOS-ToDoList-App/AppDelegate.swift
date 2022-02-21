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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let toDoViewController = ToDoViewController()
        let navigationController = UINavigationController(rootViewController: toDoViewController)
        let editController = ToDoEditViewController()

        onOpenAddControllerView(mainController: toDoViewController, navController: navigationController)

        onOpenEditControllerView(mainController: toDoViewController, editController: editController, navController: navigationController)
        onEditControllerViewSave(mainController: toDoViewController, editController: editController)

        window?.rootViewController = navigationController

        return true
    }

}

private extension AppDelegate {
    func makeViewControllerForAdd(controller: ToDoViewController) -> UIViewController {
        let addController = ToDoAddViewController()
        addController.toDoAddViewModel.onFinish = { [weak self] in
            guard self == self else { return }
            controller.updateCollectionView()
            controller.navigationController?.popToRootViewController(animated: true)
        }
        return addController
    }

    func onOpenEditControllerView(
            mainController: ToDoViewController,
            editController: ToDoEditViewController,
            navController: UINavigationController
    ) {
        mainController.toDoViewModel.onOpen = { [weak self] titleText, descriptionText, index in
            guard self == self, let index = index, let titleText = titleText, let descriptionText = descriptionText else { return }
            editController.configure(title: titleText, description: descriptionText, index: index)
            navController.pushViewController(editController, animated: true)
            mainController.updateCollectionView()
        }
    }

    func onOpenAddControllerView(
            mainController: ToDoViewController,
            navController: UINavigationController
    ) {
        mainController.toDoViewModel.onAddTap = { [weak self] in
            guard let self = self else { return }
            let addController = self.makeViewControllerForAdd(controller: mainController)
            navController.pushViewController(addController, animated: true)
        }
    }

    func onEditControllerViewSave(mainController: ToDoViewController, editController: ToDoEditViewController) {
        editController.toDoEditViewModel.onFinish = { [weak self] in
            guard self == self else { return }
            mainController.updateCollectionView()
            mainController.navigationController?.popToRootViewController(animated: true)
        }
    }
}

