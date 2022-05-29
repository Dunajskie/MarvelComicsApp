//
//  ComicsCell.swift
//  MarvelComicsApp
//
//  Created by Michał Dunajski on 23/05/2022.
//

import UIKit

final class ComicsCell: UITableViewCell {

    // MARK: - Properties

    static let cellId = "ComicsCell"

    // MARK: - Subviews

    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    let comicsThumbnail: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .gray
        view.layer.cornerRadius = CornerRadius.small
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let writersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupSubViews()
        setupConstraints()
        setupContainerView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setups

    func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .white
    }

    func setupSubViews() {
        contentView.addSubview(containerView)
        contentView.addSubview(comicsThumbnail)
        contentView.addSubview(titleLabel)
        contentView.addSubview(writersLabel)
        contentView.addSubview(descriptionLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.medium),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.tiny),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Margin.tiny),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.medium),

            comicsThumbnail.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            comicsThumbnail.topAnchor.constraint(equalTo: containerView.topAnchor),
            comicsThumbnail.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            comicsThumbnail.widthAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 2 / 3),

            titleLabel.leadingAnchor.constraint(equalTo: comicsThumbnail.trailingAnchor, constant: Margin.tiny),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Margin.tiny),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.tiny),

            writersLabel.leadingAnchor.constraint(equalTo: comicsThumbnail.trailingAnchor, constant: Margin.tiny),
            writersLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Margin.tiny),
            writersLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.micro),

            descriptionLabel.leadingAnchor.constraint(equalTo: comicsThumbnail.trailingAnchor, constant: Margin.tiny),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Margin.tiny),
            descriptionLabel.topAnchor.constraint(equalTo: writersLabel.bottomAnchor, constant: Margin.small),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -Margin.small),
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 14)
        ])
    }

    func setupContainerView() {
        containerView.layer.cornerRadius = CornerRadius.small
        containerView.layer.masksToBounds = false
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowRadius = Margin.micro
        containerView.layer.shadowOffset = CGSize(width: 0, height: Margin.micro)
        containerView.layer.shadowColor = UIColor.gray.cgColor
    }
}
