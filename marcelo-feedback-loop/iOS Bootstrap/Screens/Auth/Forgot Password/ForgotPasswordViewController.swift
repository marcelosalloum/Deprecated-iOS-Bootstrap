//
//  ForgotPasswordViewController.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 05/02/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: CoordinatedViewController {

    weak var coordinator: ForgotPasswordViewControllerDelegate?

    @IBAction func forgotPasswordClicked(_ sender: UIButton) {
        coordinator?.userDidClickForgotPassword()
    }
}
