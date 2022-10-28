//
//  NetworkError.swift
//  FlickrApp
//
//  Created by Xavier Strothers on 10/25/22.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case badStatusCode(Int)
    case general(Error)
}

extension NetworkError: LocalizedError {
        
    public var errorDescription: String? {
        switch self {
        case .badRequest:
            return NSLocalizedString("Bad URLRequest, could not convert to a URLRequest", comment: "Bad URL")
        case .general(let err):
            return NSLocalizedString("Generalized Error, description: \(err.localizedDescription)", comment: "General Error")
        case .badStatusCode(let code):
            return NSLocalizedString("The network connection was improper. Received Status code \(code), Please try again later", comment: "Bad Status Code")
        }
    }
    
}
