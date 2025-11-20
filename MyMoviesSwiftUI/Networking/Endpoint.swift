//
//  Endpoint.swift
//  MyMoviesSwiftUI
//
//  Created by Lutfi Qasim on 18/11/2025.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

public protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
    
    func makeRequest() throws -> URLRequest
}
public extension Endpoint {
    
    var baseURL: URL {
        URL(string: APIConfig.shared?.tmdbBaseURL ?? "")!
    }
    
    var method: HTTPMethod { .get }
    
    var headers: [String: String]? { nil }
    
    var queryItems: [URLQueryItem]? { nil }
    
    var body: Data? { nil }
    
    func makeRequest() throws -> URLRequest {
        var components = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        )
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}
