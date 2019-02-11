//
//  WelcomeCoordinator.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 11/02/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//

import UIKit
import EZCoreData

protocol WelcomeViewControllerDelegate: class {
    func userDidSelectStoryboard(_ storyboardName: StoryboardName)
}

class WelcomeCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var ezCoreData: EZCoreData

    private weak var welcomeViewController: WelcomeViewController?

    private var authHomeCoordinator: AuthHomeCoordinator?
    private var articleTableCoordinator: ArticleTableCoordinator?
    private var questionsCollectionCoordinator: QuestionsCollectionCoordinator?

    init(presenter: UINavigationController, ezCoreData: EZCoreData) {
        self.presenter  = presenter
        self.ezCoreData = ezCoreData
    }

    override func start() {
        // View Model
        let viewModel = WelcomeViewModel()

        // View Controller:
        guard let welcomeViewController   = WelcomeViewController.fromStoryboard(.welcome) else { return }
        welcomeViewController.viewModel   = viewModel
        welcomeViewController.coordinator = self

        // Present View Controller:
        presenter.pushViewController(welcomeViewController, animated: true)
        setDeallocallable(with: welcomeViewController)
        self.welcomeViewController = welcomeViewController
    }
}

extension WelcomeCoordinator: WelcomeViewControllerDelegate {
    func userDidSelectStoryboard(_ storyboardName: StoryboardName) {
        switch storyboardName {
        case .news:
            setupArticleListScreen()
        case .auth:
            setupAuthHomeCoordinator()
        case .collection:
            setupQuestionsCollectionScreen()
        default:
            break
        }

    }

    fileprivate func setupQuestionsCollectionScreen() {
        // Setups QuestionsCollectionCoordinator
        let questionsCollectionCoordinator = QuestionsCollectionCoordinator(presenter: presenter)
        questionsCollectionCoordinator.start()
        questionsCollectionCoordinator.stop = {
            self.questionsCollectionCoordinator = nil
        }
        self.questionsCollectionCoordinator = questionsCollectionCoordinator
    }

    fileprivate func setupArticleListScreen() {
        // Setups ArticleTableCoordinator
        let articleTableCoordinator = ArticleTableCoordinator(presenter: presenter, ezCoreData: ezCoreData)
        articleTableCoordinator.start()
        articleTableCoordinator.stop = {
            self.articleTableCoordinator = nil
        }
        self.articleTableCoordinator = articleTableCoordinator
    }

    fileprivate func setupAuthHomeCoordinator() {
        // Setups ArticleTableCoordinator
        let authHomeCoordinator = AuthHomeCoordinator(presenter: presenter, ezCoreData: ezCoreData)
        authHomeCoordinator.start()
        authHomeCoordinator.stop = {
            self.authHomeCoordinator = nil
        }
        self.authHomeCoordinator = authHomeCoordinator
    }
}
