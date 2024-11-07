//
//  ViewController.swift
//  SearchMovies
//
//  Created by Jeffrey Umandap on 11/6/24.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var apiKeyField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func searchTapped(_ sender: Any) {
        presentMovieController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func presentMovieController() {
        let controller = MoviesSearchController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
