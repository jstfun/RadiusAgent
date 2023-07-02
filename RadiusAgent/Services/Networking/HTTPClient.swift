//
//  HTTPClient.swift
//  RadiusAgent
//
//  Created by Jacob Funches on 7/1/23.
//

import Foundation

class URLContent {
    let data: Data
    let response: URLResponse
    
    init(data: Data, response: URLResponse) {
        self.data = data
        self.response = response
    }
}

protocol HTTPClient {
    func dispatch(request: URLRequest) async throws -> URLContent
}
