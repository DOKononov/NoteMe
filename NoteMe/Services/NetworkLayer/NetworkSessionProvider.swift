//
//  NetworkSessionProvider.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 19.03.24.
//

import Foundation

enum NetworkLayerError: String, LocalizedError {
    case decoderError = "Could not decode responce mosel"
    
    var errorDescription: String? { self.rawValue }
}

final class NetworkSessionProvider {
    
    func send<Request: NetworkRequest>(
        request: Request,
        completion: @escaping (Request.ResponseModel?) -> Void
    ) {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        
        URLSession.shared.dataTask(
            with: urlRequest
        ) { responseData, response, error in
            if let error {
                error.log()
                completion(nil)
            } else if let responseData,
                      let responceModel = try? JSONDecoder().decode(
                        Request.ResponseModel.self,
                        from: responseData) {
                completion(responceModel)
            } else {
                NetworkLayerError.decoderError.log()
                completion(nil)
            }
        }.resume()
    }
    
}
