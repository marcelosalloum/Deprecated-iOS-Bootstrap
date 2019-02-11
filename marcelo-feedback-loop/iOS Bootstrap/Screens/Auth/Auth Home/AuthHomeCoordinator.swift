//
//  AuthHomeCoordinator.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 05/02/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//

import UIKit
import EZCoreData

protocol AuthHomeViewControllerDelegate: class {
    func userDidClickLogin()
    func userDidClickSignUp()
    func userDidClickArticleList()
    func userDidClickCollection()
}

class AuthHomeCoordinator: Coordinator {
    private let presenter: UINavigationController
    private weak var authHomeViewController: AuthHomeViewController?
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
        guard let authHomeViewController = AuthHomeViewController.fromStoryboard(.auth) else { return }
        authHomeViewController.coordinator = self

        // Present View Controller:
        presenter.pushViewController(authHomeViewController, animated: true)
        setDeallocallable(with: authHomeViewController)
        self.authHomeViewController = authHomeViewController
    }
}

extension AuthHomeCoordinator: AuthHomeViewControllerDelegate {
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
