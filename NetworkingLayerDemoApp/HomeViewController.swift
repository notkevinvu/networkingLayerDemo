//
//  ViewController.swift
//  NetworkingLayerDemoApp
//
//  Created by Kevin Vu on 3/24/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
}

// MARK: - View setup methods
extension HomeViewController {
    private func configureView() {
        view.backgroundColor = .red
    }
}

// MARK: - Network stuff
extension HomeViewController {
    private func requestStuff() {
        ServiceLayer.request(router: Router.getProductInfo) { (result: Result<[String: [CollectionItem]], Error>) in
            
            switch result {
            case .success(let dict):
                print(dict)
            case .failure(let error):
                print(error)
            }
        }
    }
}
