//
//  URLSessionHTTPClient.swift
//  RadiusAgent
//
//  Created by Jacob Funches on 7/1/23.
//

import Foundation

class URLSessionHTTPClient: HTTPClient {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func dispatch(request: URLRequest) async throws -> URLContent {
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        if !(200...299).contains(httpResponse.statusCode) {
            throw APIError.invalidHttpStatus(httpResponse.statusCode)
        }
        
        return URLContent(data: data, response: response)
    }
}
