//
//  ContentView.swift
//  FlickrApp
//
//  Created by Xavier Strothers on 10/25/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = FlickrListViewModel()
    @State var searchQuery = ""
    
    
    var body: some View {
        NavigationView{
            VStack {
                List {
                    ForEach(self.viewModel.imageFeed, id: \.self) {
                        imageItem in
                        ZStack (alignment: .bottom) {
                                AsyncImage(url: URL(string: imageItem.media.imageLink), content: {
                                    image in
                                    image.resizable()
                                        .scaledToFill()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxHeight: 600)
                                }, placeholder:  {
                                    ProgressView()
                                })
                            
                            if #available(iOS 16.0, *) {
                                Text(imageItem.title)
                                    .padding()
                                    .bold()
                                    .foregroundColor(.white)
                                    
                            } else {
                            }
                            NavigationLink(destination: DetailView( item: imageItem), label: {})
                        }.fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .searchable(text: $searchQuery)
            .navigationTitle("CVS Flickr Search ")
            .onChange(of: searchQuery) { value in
                Task.init(operation: {
                    if !value.isEmpty {
                        viewModel.getFeedList(searchText: value)
                    }
                    else {
                        viewModel.clearFeedList()
                    }
                })
                
            }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
