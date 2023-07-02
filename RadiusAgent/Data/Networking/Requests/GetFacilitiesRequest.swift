//
//  GetFacilitiesRequest.swift
//  RadiusAgent
//
//  Created by Jacob Funches on 7/1/23.
//

import Foundation

struct GetFacilitiesRequest: Request {
    typealias ResponseType = GetFacilitiesResponse
    
    let method: HTTPMethod = .get
    let path: String = "/ad-assignment/db"
    var headers: [HTTPHeader]?
    var queries: [String : String]?
    var body: [String: Any]?
}
