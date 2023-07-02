//
//  APIService.swift
//  RadiusAgent
//
//  Created by Jacob Funches on 7/1/23.
//

import Foundation

class APIService {
    private let baseURL: String
    private let httpClient: HTTPClient
    private let decoder = JSONDecoder()
    
    init(baseURL: String = Constants.API.baseURL,
         httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.baseURL = baseURL
        self.httpClient = httpClient
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    private func decodeContent<Response: Decodable>(_ content: URLContent) -> Result<Response, APIError> {
        do {
            let decoded = try decoder.decode(Response.self, from: content.data)
            return .success(decoded)
        } catch is DecodingError {
            return .failure(.decodingError)
        } catch let error as APIError {
            return .failure(error)
        } catch {
            return .failure(.unknown)
        }
    }
    
    private func dispatchRequest<T: Request>(request: T) async -> Result<T.ResponseType, APIError> {
        guard let urlRequest = request.toURLRequest(baseURL: baseURL) else {
            return .failure(.invalidRequest)
        }
        
        do {
            let content = try await httpClient.dispatch(request: urlRequest)
            return decodeContent(content)
        } catch let error as APIError {
            return .failure(error)
        } catch {
            return .failure(.dispatchError)
        }
    }
    
    func getFacilities() async -> Result<GetFacilitiesResponse, APIError>{
        let request = GetFacilitiesRequest()
        return await dispatchRequest(request: request)
    }
}
