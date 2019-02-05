//
//  SignUpViewController.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 05/02/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//

import UIKit

class SignUpViewController: CoordinatedViewController {

    weak var coordinator: SignUpViewControllerDelegate?

    @IBAction func forgotPasswordClicked(_ sender: UIButton) {
        coordinator?.userDidClickForgotPassword()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillAppear(animated)
    }
}
