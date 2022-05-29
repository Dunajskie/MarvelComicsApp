//
//  SearchViewController.swift
//  MarvelComicsApp
//
//  Created by Michał Dunajski on 23/05/2022.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Properties

    let searchBar = UISearchBar()

    private let viewModel: SearchComicsViewModel

    let contentView = SearchView()

    // MARK: - Init

    init(viewModel: SearchComicsViewModel) {
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
    }

    func setupController() {
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.placeholder = "Search for a comic book"
        viewModel.onFetchComicsSucceed = {
            DispatchQueue.main.async {
                self.contentView.tableView.reloadData()
            }
        }
        viewModel.onFetchComicsFailure = {
            DispatchQueue.main.async {
                self.contentView.tableView.backgroundView = self.contentView.noComicsView
            }
        }
    }

    func setupContentView() {
        contentView.tableView.backgroundView = contentView.emptyView
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

    func clearTableView() {
        viewModel.comics = []
        DispatchQueue.main.async {
            self.contentView.tableView.reloadData()
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        if (contentView.tableView.backgroundView != nil) {
            contentView.tableView.backgroundView = nil
        }
        clearTableView()
        return true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        contentView.tableView.backgroundView = contentView.emptyView
        searchBar.showsCancelButton = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        viewModel.fetchComics(title: searchBar.text ?? "")
        contentView.tableView.backgroundView = contentView.loadingView
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
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
