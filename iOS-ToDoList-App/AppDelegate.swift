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
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let toDoViewController = ToDoViewController()
        let navigationController = UINavigationController(rootViewController: toDoViewController)
        toDoViewController.toDoViewModel.onOpen = { [weak self] titleText in
            let editController = ToDoEditViewController()
            navigationController.pushViewController(editController, animated: true)
        }

        toDoViewController.toDoViewModel.onAddTap = { [weak self] in
            guard let self = self else {
                return
            }
            let addController = self.makeViewController(controller: toDoViewController)
            navigationController.pushViewController(addController, animated: true)
        }

        window?.rootViewController = navigationController

        return true
    }

    func makeViewController(controller: ToDoViewController) -> UIViewController {
        let addController = ToDoAddViewController()
        addController.toDoAddViewModel.onFinish = { [weak self] in
            controller.updateCollectionView()
            controller.navigationController?.popToRootViewController(animated: true)
        }
        return addController
    }
}

