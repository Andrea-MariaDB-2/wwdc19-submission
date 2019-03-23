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

    private let quackController = QuackController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        reload()
    }

    private func reload() {
        feedViewController.contentViewControllers = quackController.quacks.map { quack in
            let viewcontroller = FeedCellViewController()
            viewcontroller.quack = quack
            return viewcontroller
        }
    }

}

extension HomeViewController {

    private func setupView() {
        view.backgroundColor = StyleSheet.Color.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        headerViewController.delegate = self
        [headerViewController, feedViewController].forEach(add)
        [headerView, feedView].forEach(view.addSubview)
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 64),

            feedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            feedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func presentModally(_ viewController: UIViewController? = nil) {
        let modalViewController = ModalViewController()
        modalViewController.contentViewController = viewController
        modalViewController.modalPresentationStyle = .overCurrentContext
        modalViewController.modalTransitionStyle = .crossDissolve
        present(modalViewController, animated: true)
    }
}

extension HomeViewController: HomeHeaderViewControllerDelegate {
    func homeHeaderViewControllerDidSelectInfo(
        _ homeHeaderViewController: HomeHeaderViewController
    ) {
        presentModally(InfoViewController())
    }
    func homeHeaderViewControllerDidSelectQuack(
        _ homeHeaderViewController: HomeHeaderViewController
    ) {
        let quackFormViewController = QuackFormViewController()
        quackFormViewController.delegate = self
        presentModally(quackFormViewController)
    }
}

extension HomeViewController: QuackFormViewControllerDelegate {
    func quackFormViewController(
        _ quackFormViewController: QuackFormViewController,
        didQuacked quack: String?,
        as user: User?
    ) {
        presentedViewController?.dismiss(animated: true)
        guard let quack = quack, let user = user else { return }
        quackController.createQuack(with: quack, from: user) { [weak self] in
            self?.reload()
        }
    }
}

