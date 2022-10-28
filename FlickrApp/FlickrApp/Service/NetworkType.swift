//
//  NetworkType.swift
//  FlickrApp
//
//  Created by Xavier Strothers on 10/25/22.
//

import Foundation
import Combine

protocol NetworkType {
    func getModel<T: Decodable>(url: URL?) -> AnyPublisher<T, NetworkError>
    func getRawData(url: URL?) -> AnyPublisher<Data, NetworkError>
}
