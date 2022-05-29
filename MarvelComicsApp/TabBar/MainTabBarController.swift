//
//  MainTabBarController.swift
//  MarvelComicsApp
//
//  Created by Michał Dunajski on 23/05/2022.
//

import UIKit
class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let homePageViewModel: ComicsViewModel = HomePageViewModel(
            networkService: DefaultNetworkService()
        )
        let tabOne = HomePageViewController(viewModel: homePageViewModel)
        let tabOneBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        tabOne.tabBarItem = tabOneBarItem

        let searchViewModel: SearchComicsViewModel = SearchViewModel(
            networkService: DefaultNetworkService()
        )
        let tabTwo = SearchViewController(viewModel: searchViewModel)
        let tabTwoBarItem2 = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        tabTwo.tabBarItem = tabTwoBarItem2

        self.viewControllers = [
            UINavigationController(rootViewController: tabOne),
            UINavigationController(rootViewController: tabTwo)
        ]
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .red
    }
}
