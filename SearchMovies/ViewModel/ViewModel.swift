//
//  ViewModel.swift
//  SearchMovies
//
//  Created by Jeffrey Umandap on 11/6/24.
//

import Foundation
import RxRelay
import RxSwift

class SearchViewModel {
    private let repository: SearchRepository
    private let disposeBag: DisposeBag
    
    var data: BehaviorRelay<Resource<SearchResults>>
    
    public init(repository: SearchRepository) {
        self.repository = repository
        
        self.data = .init(value: .none)
        self.disposeBag = DisposeBag()
    }
    
    func search(request: SearchRequest) {
        data.accept(.loading)
        repository.searchMovie(request: request).subscribe(onSuccess: { [weak self] response in
            if response.response?.lowercased() == "false" && response.error != "Movie not found!" {
                self?.data.accept(.error(errorCode: "API KEY INVALID"))
            } else {
                self?.data.accept(.success(data: response))
            }
        }, onFailure: { [weak self] error in
            self?.data.accept(.error(errorCode: error.localizedDescription))
        }).disposed(by: disposeBag)
    }
}
    
// MARK: - Resource enum
public enum Resource<T> {
    case none, loading, success(data: T), error(errorCode: String)
}
