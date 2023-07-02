//
//  APIError.swift
//  RadiusAgent
//
//  Created by Jacob Funches on 7/1/23.
//

import Foundation

enum APIError: Error, Equatable {
    case invalidRequest
    case invalidData
    case invalidResponse
    case invalidHttpStatus(Int)
    case decodingError
    case dispatchError
    case unknown
}
