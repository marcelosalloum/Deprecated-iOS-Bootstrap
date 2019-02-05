//
//  ForgotPasswordCoordinator.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 05/02/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//

import UIKit

protocol ForgotPasswordViewControllerDelegate: class {
    func userDidClickForgotPassword()
}

class ForgotPasswordCoordinator: Coordinator {
    private let presenter: UINavigationController
    private weak var forgotPasswordViewController: ForgotPasswordViewController?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    override func start() {
        // View Controller:
        guard let forgotPasswordViewController = ForgotPasswordViewController.fromStoryboard("Auth") else { return }
        forgotPasswordViewController.coordinator = self

        // Present View Controller:
        presenter.pushViewController(forgotPasswordViewController, animated: true)
        setDeallocallable(with: forgotPasswordViewController)
        self.forgotPasswordViewController = forgotPasswordViewController
    }
}

extension ForgotPasswordCoordinator: ForgotPasswordViewControllerDelegate {
    func userDidClickForgotPassword() {
        forgotPasswordViewController?.toastr("userDidClickForgotPassword")
    }
}
