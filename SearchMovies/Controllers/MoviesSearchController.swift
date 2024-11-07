//
//  MoviesSearchController.swift
//  SearchMovies
//
//  Created by Jeffrey Umandap on 11/7/24.
//

import UIKit

class MoviesSearchController: UIViewController {
    var searchResults: [Movie] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let cell = UINib.init(nibName: "MoviesCell", bundle: nil)
        collectionView.register(cell, forCellWithReuseIdentifier: "MoviesCell")
    }
}

extension MoviesSearchController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
        
        let movie = searchResults[indexPath.row]
        cell.movie = movie
        cell.view.backgroundColor = .blue
        cell.movieImage.backgroundColor = .gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, 
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight = collectionView.bounds.height / 8
        let cellWidth = collectionView.bounds.width / 2.1
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
