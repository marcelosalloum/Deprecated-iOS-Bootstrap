//
//  WelcomeCoordinator.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 05/02/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//

import UIKit

protocol WelcomeViewControllerDelegate: class {
    func userDidClickLogin()
    func userDidClickSignUp()
}

class WelcomeCoordinator: Coordinator {
    private let presenter: UINavigationController
    private weak var welcomeViewController: WelcomeViewController?
    private var loginCoordinator: LoginCoordinator?
    private var signUpCoordinator: SignUpCoordinator?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    override func start() {
        // View Controller:
        guard let welcomeViewController = WelcomeViewController.fromStoryboard("Auth") else { return }
        welcomeViewController.coordinator = self

        // Present View Controller:
        presenter.pushViewController(welcomeViewController, animated: true)
        setDeallocallable(with: welcomeViewController)
        self.welcomeViewController = welcomeViewController
    }
}

extension WelcomeCoordinator: WelcomeViewControllerDelegate {
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
