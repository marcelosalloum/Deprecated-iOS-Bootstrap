//
//  WelcomeCoordinator.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 05/02/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//

import UIKit
import EZCoreData

protocol WelcomeViewControllerDelegate: class {
    func userDidClickLogin()
    func userDidClickSignUp()
    func userDidClickArticleList()
    func userDidClickCollection()
}

class WelcomeCoordinator: Coordinator {
    private let presenter: UINavigationController
    private weak var welcomeViewController: WelcomeViewController?
    private var loginCoordinator: LoginCoordinator?
    private var signUpCoordinator: SignUpCoordinator?
    private var articleTableCoordinator: ArticleTableCoordinator?
    private var questionsCollectionCoordinator: QuestionsCollectionCoordinator?
    private var ezCoreData: EZCoreData!

    init(presenter: UINavigationController, ezCoreData: EZCoreData) {
        self.presenter = presenter
        self.ezCoreData = ezCoreData
    }

    override func start() {
        // View Controller:
        guard let welcomeViewController = WelcomeViewController.fromStoryboard(.auth) else { return }
        welcomeViewController.coordinator = self

        // Present View Controller:
        presenter.pushViewController(welcomeViewController, animated: true)
        setDeallocallable(with: welcomeViewController)
        self.welcomeViewController = welcomeViewController
    }
}

extension WelcomeCoordinator: WelcomeViewControllerDelegate {
    func userDidClickArticleList() {
        let newCoordinator = ArticleTableCoordinator(presenter: presenter, ezCoreData: ezCoreData)
        newCoordinator.start()
        newCoordinator.stop = {
            self.articleTableCoordinator = nil
        }
        self.articleTableCoordinator = newCoordinator
    }

    func userDidClickCollection() {
        let newCoordinator = QuestionsCollectionCoordinator(presenter: presenter)
        newCoordinator.start()
        newCoordinator.stop = {
            self.questionsCollectionCoordinator = nil
        }
        self.questionsCollectionCoordinator = newCoordinator
    }

    func userDidClickLogin() {
        let loginCoordinator = LoginCoordinator(presenter: presenter)
        loginCoordinator.start()
        loginCoordinator.stop = {
            self.loginCoordinator = nil
        }
        self.loginCoordinator = loginCoordinator
    }

    func userDidClickSignUp() {
        let signUpCoordinator = SignUpCoordinator(presenter: presenter)
        signUpCoordinator.start()
        signUpCoordinator.stop = {
            self.signUpCoordinator = nil
        }
        self.signUpCoordinator = signUpCoordinator
    }
}
