//
//  Repository.swift
//  SearchMovies
//
//  Created by Jeffrey Umandap on 11/6/24.
//

import Foundation
import RxMoya
import RxSwift
import Alamofire
import Moya

public class BaseRepository {
    public let service: ApiService
    
    public init(service: ApiService) {
        self.service = service
    }
}

public class SearchRepository: BaseRepository {
    func searchMovie(request: SearchRequest) -> Single<SearchResults> {
        return service.rx
            .request(.searchMovie(request: request))
            .map(SearchResults.self)
            .asObservable()
            .asSingle()
    }
}
