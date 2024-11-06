//
//  Presenter.swift
//  SearchMovies
//
//  Created by Jeffrey Umandap on 11/6/24.
//

import Foundation
import RxRelay
import RxSwift
import UIKit

protocol SearchPresenterProtocol: AnyObject {
    func login()
    
}

typealias SearchPresenterDelegate = SearchPresenterProtocol & UIViewController

class SearchPresenter: NSObject {
    weak var delegate: SearchPresenterProtocol? {
        didSet {
            bindSearchResults()
        }
    }

    let viewModel: SearchViewModel
    let disposeBag: DisposeBag

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        self.disposeBag = DisposeBag()
    }

    public func search() {
        viewModel.search(request: SearchRequest(apikey: "8d6aa4ca", s: "Spiderman"))
    }
    
    fileprivate func bindSearchResults() {
        viewModel.data.subscribe(onNext: { resource in
            switch resource {
            case .none, .loading:
                break
            case .success(let data):
                print("search results: \(data)")
                
            case .error(let errorCode):
                print("errorCode: \(errorCode)")
            }
        })
        .disposed(by: disposeBag)
    }
}