//
//  SearchViewModel.swift
//  MarvelComicsApp
//
//  Created by Michał Dunajski on 26/05/2022.
//

import Foundation

protocol SearchComicsViewModel: AnyObject {
    var comics: [Comics] { set get }
    var onFetchComicsSucceed: (() -> Void)? { set get }
    var onFetchComicsFailure: (() -> Void)? { set get }
    func fetchComics(title: String)
    func getWriterLabel(comics: Comics) -> String
    func getThumbnailURL(comics: Comics) -> String
    func getDescriptionLabel(comics: Comics) -> String
}

final class SearchViewModel: SearchComicsViewModel {

    // MARK: - Properties

    private let networkService: NetworkService
    var comics: [Comics] = []
    var onFetchComicsSucceed: (() -> Void)?
    var onFetchComicsFailure: (() -> Void)?

    // MARK: - Init

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    // MARK: - Methods
    
    func fetchComics(title: String) {
        let request = SearchRequest(title: title)
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let comics):
                if comics == [] {
                    self?.onFetchComicsFailure?()
                } else {
                    self?.comics = comics
                    self?.onFetchComicsSucceed?()
                }
            case .failure(let error):
                self?.onFetchComicsFailure?()
                print(error)
            }
        }
    }

    func getWriterLabel(comics: Comics) -> String {
        var writer = "written by"
        var manyWriters = false
        guard (comics.creators.available) != 0 else {
            writer.append(" unknown writer")
            return writer
        }
        for person in comics.creators.persons! {
            if person.role == "writer" {
                writer.append("\(manyWriters ? ", " : " ")\(person.name)")
                manyWriters = true
            }
        }
        if writer == "written by" {
            writer.append(" unknown writer")
        }
        return writer
    }

    func getThumbnailURL(comics: Comics) -> String {
        var url = comics.thumbnail.url
        let index = url.index(url.startIndex, offsetBy: 4)
        url.insert("s", at: index)
        url.append("/portrait_xlarge.\(comics.thumbnail.type)")
        return url
    }

    func getDescriptionLabel(comics: Comics) -> String {
        let noDescriptionTitle = "No description available"

        guard let description = comics.description else {
            return noDescriptionTitle
        }

        if description.count < 10 {
            return noDescriptionTitle
        } else {
            return description
        }
    }
}
