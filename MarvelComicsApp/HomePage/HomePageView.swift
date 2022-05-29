//
//  HomePageView.swift
//  MarvelComicsApp
//
//  Created by Michał Dunajski on 28/05/2022.
//

import UIKit

class HomePageView: UIView {

    // MARK: - Subviews

    let tableView: UITableView =  {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()

    let errorView = TableViewBackgroundView(
        image: Images.error,
        title: "Something went wrong"
    )

    let loadingView = LoadingView()

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        setupView()
        setupSubViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setups

    func setupView() {
        backgroundColor = .clear
    }

    func setupSubViews() {
        addSubview(tableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
