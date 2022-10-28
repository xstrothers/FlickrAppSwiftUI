//
//  NetworkManager.swift
//  FlickrApp
//
//  Created by Xavier Strothers on 10/25/22.
//

import Foundation
import Combine

class NetworkManager: NetworkType {
    
    let session: URLSession
    let decoder = JSONDecoder()
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getModel<T>(url: URL?) -> AnyPublisher<T, NetworkError> where T : Decodable {
        
        guard let url = url else {
            return Fail(error: NetworkError.badRequest).eraseToAnyPublisher()
        }
        
        return self.session.dataTaskPublisher(for: url)
            .tryMap { map in
                if let httpResponse = map.response as? HTTPURLResponse,
                   !(200..<300).contains(httpResponse.statusCode) {
                    throw NetworkError.badStatusCode(httpResponse.statusCode)
                }
                
                return map.data
            }.decode(type: T.self, decoder: self.decoder)
            .mapError { error in
                return NetworkError.general(error)
            }.eraseToAnyPublisher()
        
    }
    
    
    func getRawData(url: URL?) -> AnyPublisher<Data, NetworkError> {
        
        guard let url = url else {
            return Fail(error: NetworkError.badRequest).eraseToAnyPublisher()
        }
        
        return self.session.dataTaskPublisher(for: url)
            .tryMap { map in
                if let httpResponse = map.response as? HTTPURLResponse,
                   !(200..<300).contains(httpResponse.statusCode) {
                    throw NetworkError.badStatusCode(httpResponse.statusCode)
                }
                
                return map.data
            }.mapError { error in
                return NetworkError.general(error)
            }.eraseToAnyPublisher()
        
    }
    
}
