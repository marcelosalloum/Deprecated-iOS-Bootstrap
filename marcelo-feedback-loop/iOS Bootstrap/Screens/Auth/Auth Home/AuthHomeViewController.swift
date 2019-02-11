//
//  AuthHomeViewController.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 05/02/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//

import UIKit

class AuthHomeViewController: CoordinatedViewController {

    weak var coordinator: AuthHomeViewControllerDelegate?

    @IBAction func loginButtonClicked(_ sender: UIButton) {
        self.coordinator?.userDidClickLogin()
    }

    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        self.coordinator?.userDidClickSignUp()
    }

    @IBAction func articleListButtonClicked(_ sender: Any) {
        self.coordinator?.userDidClickArticleList()
    }

    @IBAction func collectionButtonClicked(_ sender: DesignableButton) {
        self.coordinator?.userDidClickCollection()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillAppear(animated)
    }
}
