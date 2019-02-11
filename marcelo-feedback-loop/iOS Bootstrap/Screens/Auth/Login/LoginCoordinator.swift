//
//  LoginCoordinator.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 05/02/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    func userDidClickForgotPassword()
}

class LoginCoordinator: Coordinator {
    private let presenter: UINavigationController

    private weak var loginViewController: LoginViewController?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    override func start() {
        // View Controller:
        guard let loginViewController = LoginViewController.fromStoryboard(.auth) else { return }
        loginViewController.coordinator = self

        // Present View Controller:
        presenter.pushViewController(loginViewController, animated: true)
        setDeallocallable(with: loginViewController)
        self.loginViewController = loginViewController
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func userDidClickForgotPassword() {
        let forgotPasswordCoordinator = ForgotPasswordCoordinator(presenter: presenter)
        forgotPasswordCoordinator.start()
        forgotPasswordCoordinator.stop = {
            self.removeChildCoordinator(childCoordinator: forgotPasswordCoordinator)
        }
        self.addChildCoordinator(childCoordinator: forgotPasswordCoordinator)
    }
}
