//
//  FlickrFeed.swift
//  FlickrApp
//
//  Created by Xavier Strothers on 10/25/22.
//

import Foundation

struct FlickrFeed: Decodable, Hashable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [ImageFeed]
}

struct ImageFeed: Decodable, Hashable {
    let title: String
    let link: String
    let media: Media
    let description: String
    let published: String
    let author: String
    let tags: String
}

struct Media: Decodable, Hashable {
    let imageLink: String
    
    enum CodingKeys: String, CodingKey {
        case imageLink = "m"
    }
}
