//
//  Service.swift
//  SearchMovies
//
//  Created by Jeffrey Umandap on 11/6/24.
//

import Foundation
import Alamofire
import Moya
import UIKit


private var searchBaseUrl = ""

public class ApiService: BaseApiProvider<SearchService> {
    public override init(baseUrl url: String, plugins: [PluginType] = [],
                         serverTrustPolicies: [String: ServerTrustEvaluating] = [:]) {
        super.init(baseUrl: url, plugins: plugins, serverTrustPolicies: serverTrustPolicies)
        print("[Assembler] - assemble \(url)")
        searchBaseUrl = url
    }
}

open class BaseApiProvider<Target: TargetType>: MoyaProvider<Target> {
    public private(set) var authPlugin: PluginType!
    public private(set) var cachePolicyPlugin: ServerTrustEvaluating!

    public init(baseUrl url: String, plugins: [PluginType] = [],
                serverTrustPolicies: [String: ServerTrustEvaluating] = [:]) {
        
        var plugins: [PluginType] = []
        plugins.append(NetworkLoggerPlugin(configuration: .init(formatter: .init(), 
                                                                output: NetworkLoggerPlugin.Configuration.defaultOutput(target:items:),
                                                                logOptions: .verbose)))
        
        let serverTrust = ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: serverTrustPolicies)
        let manager = Alamofire.Session(serverTrustManager: serverTrust)

        super.init(session: manager, plugins: plugins)
    }
}

public enum SearchService {
    //MARK: - Login OTP
    case searchMovie(request: SearchRequest)
}

extension SearchService: TargetType {
    public var baseURL: URL {
        //return URL(string: "https://omdbapi.com/")!
        return URL(string: searchBaseUrl)!
    }
    
    public var path: String {
        switch self {
        case .searchMovie:
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .searchMovie:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .searchMovie(let request):
            return .requestParameters(parameters: request.asDictionary(), encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .searchMovie:
            return nil
        }
    }
    
    public var requiresAuth: Bool {
        switch self {
        case .searchMovie:
            return false
        }
    }
}

public struct SearchRequest: Codable {
    let apikey: String
    let s: String
}



extension Encodable {
    func asDictionary() -> [String: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return [:]
            }
            return dictionary
        } catch {
            return [:]
        }
    }
}
