//
//  HomeViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 19/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private let headerViewController = HomeHeaderViewController()
    private let feedViewController = FeedViewController()

    private var headerView: UIView { return headerViewController.view }
    private var feedView: UIView { return feedViewController.view }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension HomeViewController {
    private func setupView() {
        view.backgroundColor = StyleSheet.Color.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        [headerViewController, feedViewController].forEach(add)
        [headerView, feedView].forEach(view.addSubview)
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 64),

            feedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            feedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
