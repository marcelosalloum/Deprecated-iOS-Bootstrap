//
//  WelcomeViewController.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 05/02/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//

import UIKit

class WelcomeViewController: CoordinatedViewController {

    weak var coordinator: WelcomeViewControllerDelegate?

    @IBAction func loginButtonClicked(_ sender: UIButton) {
        self.coordinator?.userDidClickLogin()
    }

    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        self.coordinator?.userDidClickSignUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillAppear(animated)
    }
}
