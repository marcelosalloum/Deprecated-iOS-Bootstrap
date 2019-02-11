//
//  WelcomeViewModel.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 11/02/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//

import UIKit

class WelcomeViewModel: NSObject {
    public let objects: [StoryboardName] = [.auth, .news, .collection]
}


extension WelcomeViewModel: ListViewModelProtocol {

}
