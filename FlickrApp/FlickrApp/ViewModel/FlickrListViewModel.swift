//
//  FlickrListViewModel.swift
//  FlickrApp
//
//  Created by Xavier Strothers on 10/25/22.
//

import Foundation
import Combine

class FlickrListViewModel: ObservableObject {
    
    let network: NetworkType
    var subs = Set<AnyCancellable>()
    @Published var imageFeed: [ImageFeed] = []
    
    init(network: NetworkType = NetworkManager()) {
        self.network = network
    }
    
    func getFeedList(searchText : String ) {
        let url = NetworkRequests.feed(searchText).url
        
        self.network.getModel(url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { (feed: FlickrFeed) in
                print(feed)
                self.imageFeed = feed.items
            }.store(in: &self.subs)
        
    }
    func clearFeedList() {
        self.imageFeed = []
    }
    
    
    
}
