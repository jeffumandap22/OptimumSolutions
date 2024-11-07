//
//  ViewController.swift
//  SearchMovies
//
//  Created by Jeffrey Umandap on 11/6/24.
//

import Foundation
import UIKit

extension ViewController: SearchPresenterProtocol {
    func showSearchResults(results: SearchResults) {
        print("Results: \(results)")
        let controller = MoviesSearchController()
        controller.searchResults = results.search ?? []
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

class ViewController: UIViewController {
    private var presenter: SearchPresenter?
    
    @IBOutlet weak var apiKeyField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func searchTapped(_ sender: Any) {
        search()
    }
    
    func setup(presenter: SearchPresenter) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let service = ApiService(baseUrl: "https://omdbapi.com/")
        let repository = SearchRepository(service: service)
        let viewModel = SearchViewModel(repository: repository)
        let presenter = SearchPresenter(viewModel: viewModel)
        setup(presenter: presenter)
        presenter.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func search() {
        presenter?.viewModel.search(request: SearchRequest(apikey: "8d6aa4ca", s: "Spiderman"))
    }
}
