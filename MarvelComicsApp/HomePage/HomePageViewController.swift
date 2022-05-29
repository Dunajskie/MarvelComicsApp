//
//  HomePageViewController.swift
//  MarvelComicsApp
//
//  Created by Michał Dunajski on 23/05/2022.
//

import UIKit

class HomePageViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: ComicsViewModel

    let contentView = HomePageView()

    // MARK: - Init

    init(viewModel: ComicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupContentView()
        viewModel.fetchComics()
    }

    func setupController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Marvel Comics"
        viewModel.onFetchComicsSucceed = {
            DispatchQueue.main.async {
                self.contentView.tableView.reloadData()
            }
        }
        viewModel.onFetchComicsFailure = {
            DispatchQueue.main.async {
                self.contentView.tableView.backgroundView = self.contentView.errorView
            }
        }
    }

    func setupContentView() {
        contentView.tableView.backgroundView = contentView.loadingView
        contentView.tableView.register(ComicsCell.self, forCellReuseIdentifier: "ComicsCell")
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.comics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ComicsCell.cellId, for: indexPath) as? ComicsCell else {
            return UITableViewCell()
        }
        cell.comicsThumbnail.loadImageUsingCache(withUrl: viewModel.getThumbnailURL(comics: viewModel.comics[indexPath.row]))
        cell.titleLabel.text = viewModel.comics[indexPath.row].title
        cell.writersLabel.text = viewModel.getWriterLabel(comics: viewModel.comics[indexPath.row])
        cell.descriptionLabel.text = viewModel.getDescriptionLabel(comics: viewModel.comics[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0;
    }
}
