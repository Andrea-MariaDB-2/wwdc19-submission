//
//  TableViewCell.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    public var hostedView: UIView? {
        didSet {
            remove(old: oldValue)
            embed(new: hostedView)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        hostedView = nil
    }

}


extension TableViewCell {

    private func embed(new hostedView: UIView?) {
        guard let view = hostedView else { return }
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func remove(old hostedView: UIView?) {
        guard let view = hostedView else { return }
        view.removeFromSuperview()
    }

    private func setupView() {
        backgroundColor = .clear
    }

}
