//
//  MoviesSearchController.swift
//  SearchMovies
//
//  Created by Jeffrey Umandap on 11/7/24.
//

import UIKit

class MoviesSearchController: UIViewController {
    private var presenter: SearchPresenter?
    var apiKey: String?
    
    var searchResults: [Movie] = []
    
    @IBOutlet weak var noDataView: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func searchTapped(_ sender: Any) {
        guard let searchText = searchField.text, !searchText.isEmpty else {
            searchField.placeholder = "Input movie name here.."
            return
        }
        searchField.resignFirstResponder()
        presenter?.viewModel.search(request: SearchRequest(apikey: apiKey ?? "", s: searchText))
    }
    
    func setup(presenter: SearchPresenter) {
        self.presenter = presenter
        self.presenter?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let cell = UINib.init(nibName: "MoviesCell", bundle: nil)
        collectionView.register(cell, forCellWithReuseIdentifier: "MoviesCell")
        setup()
    }
    
    
    private func setup() {
        let service = ApiService(baseUrl: "https://omdbapi.com/")
        let repository = SearchRepository(service: service)
        let viewModel = SearchViewModel(repository: repository)
        let presenter = SearchPresenter(viewModel: viewModel)
        setup(presenter: presenter)
    }
}

// MARK: - Protocol
extension MoviesSearchController: SearchPresenterProtocol {
    func showErrorOnApi(error: String) {
        showError(error: error, isDismissAction: true)
    }
    
    func showSearchResults(results: SearchResults) {
        guard let movies = results.results, !movies.isEmpty else {
            resultsLabel.text = "No movies available"
            searchResults = []
            collectionView.reloadData()
            noDataView.isHidden = false
            return
        }
        noDataView.isHidden = true
        resultsLabel.text = "Total results: \(results.totalResults ?? "") movies"
        searchResults = movies
        collectionView.reloadData()
    }
}


// MARK: - DataSource, Delegate & Layout
extension MoviesSearchController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
        let movie = searchResults[indexPath.row]
        cell.movie = movie
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.bounds.height / 5
        let cellWidth = collectionView.bounds.width / 2.1
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
