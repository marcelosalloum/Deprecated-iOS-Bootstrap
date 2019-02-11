//
//  Coordinator.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 30/01/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//

import UIKit
import EZCoreData

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    var ezCoreData: EZCoreData
    let rootViewController: UINavigationController
    var articleTableCoordinator: ArticleTableCoordinator?
    var authHomeCoordinator: AuthHomeCoordinator?
    var questionsCollectionCoordinator: QuestionsCollectionCoordinator?

    fileprivate func setupArticleListScreen() {
        // Setups ArticleTableCoordinator
        let articleTableCoordinator = ArticleTableCoordinator(presenter: rootViewController, ezCoreData: ezCoreData)
        articleTableCoordinator.start()
        articleTableCoordinator.stop = {
            self.articleTableCoordinator = nil
        }
        self.articleTableCoordinator = articleTableCoordinator
    }

    fileprivate func setupAuthHomeCoordinator() {
        // Setups ArticleTableCoordinator
        let authHomeCoordinator = AuthHomeCoordinator(presenter: rootViewController, ezCoreData: ezCoreData)
        authHomeCoordinator.start()
        authHomeCoordinator.stop = {
            self.authHomeCoordinator = nil
        }
        self.authHomeCoordinator = authHomeCoordinator
    }

    init(window: UIWindow) {
        // Init Values
        self.window = window
        rootViewController = UINavigationController()
        ezCoreData = EZCoreData()

        // Offline Handling
        APIHelper.setupReachability()

        super.init()
        // Init Core Data
        ezCoreData.setupPersistence(Constants.databaseName) // Initialize Core Data

        // Configures RootVC
        rootViewController.navigationBar.prefersLargeTitles = true

        let isUserLogged = false
        if !isUserLogged {
            setupAuthHomeCoordinator()
        } else {
//            setupAuthHomeCoordinator()
            let questionsCollectionCoordinator = QuestionsCollectionCoordinator(presenter: rootViewController)
            questionsCollectionCoordinator.start()
            questionsCollectionCoordinator.stop = {
                self.questionsCollectionCoordinator = nil
            }
            self.questionsCollectionCoordinator = questionsCollectionCoordinator
        }
    }

    override func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
