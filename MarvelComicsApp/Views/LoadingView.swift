//
//  LoadingView.swift
//  MarvelComicsApp
//
//  Created by Michał Dunajski on 28/05/2022.
//

import UIKit

class LoadingView: UIView {

    // MARK: - Subviews

    let loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .gray
        return view
    }()

    //MARK: - Init

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setups

    func setupView() {
        loadingView.startAnimating()
        addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
