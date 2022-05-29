//
//  TableViewBackgroundView.swift
//  MarvelComicsApp
//
//  Created by Michał Dunajski on 23/05/2022.
//

import UIKit

class TableViewBackgroundView: UIView {

    // MARK: - Properties

    let image: UIImage
    let title: String

    // MARK: - Subviews

    let loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .red
        return view
    }()

    let iconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.tintColor = .gray
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: FontSize.semiLarge)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = Margin.medium
        return view
    }()

    //MARK: - Init

    required init(image: UIImage = UIImage(), title: String = "") {
        self.image = image
        self.title = title
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
        titleLabel.text = title
        iconView.image = image
        addSubview(stackView)
        stackView.addArrangedSubview(iconView)
        stackView.addArrangedSubview(titleLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            iconView.heightAnchor.constraint(equalToConstant: 80),
            iconView.widthAnchor.constraint(equalToConstant: 80),

            titleLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
