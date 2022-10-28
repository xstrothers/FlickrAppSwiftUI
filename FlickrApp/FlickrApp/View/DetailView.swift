//
//  DetailView.swift
//  FlickrApp
//
//  Created by Xavier Strothers on 10/27/22.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let item: ImageFeed
    let imageSize: CGFloat = 300
    var isLandscape: Bool {
        verticalSizeClass == .compact
    }
    var body: some View {
        if !isLandscape {
            ScrollView {
                VStack {
                    AsyncImage(url: URL(string: item.media.imageLink), content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: imageSize)
                    }, placeholder: {
                        ProgressView()
                    })
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.title)
                        .font(.largeTitle)
                        .padding()
                    HStack {
                        Text("Author :")
                            .font(.headline)
                        Text(item.author)
                            .font(.headline)
                    }
                    .padding()
                    HStack {
                        Text("Dimensions :")
                            .font(.headline)
                    }
                    .padding()
                    HStack {
                        Text("Posted By :")
                            .font(.headline)
                        HTMLTextView(html: item.description)
                            .font(.headline)
                    }
                    .padding()
                    HStack {
                        Text("Published On :")
                            .font(.footnote)
                        Text(item.published)
                            .font(.footnote)
                    }
                    .padding()
                }
            }
        } else {
            HStack {
                AsyncImage(url: URL(string: item.media.imageLink), content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: imageSize)
                }, placeholder: {
                    ProgressView()
                })
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(item.title)
                            .font(.largeTitle)
                            .bold()
                        HStack {
                            Text("Author :")
                                .font(.headline)
                            Text(item.author)
                                .font(.headline)
                        }
                        HStack {
                            Text("Dimensions :")
                                .font(.headline)
                        }
                        HStack {
                            Text("Published On :")
                            Text(item.published)
                        }
                        HStack {
                            Text("Posted By :")
                                .font(.headline)
                            HTMLTextView(html: item.description)
                        }
                        .frame(height: 35)
                    }
                }
            }
        }
    }
}

struct HTMLTextView: UIViewRepresentable {
   let html: String

   func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
        let label = UILabel()
        DispatchQueue.main.async {
            let data = Data(self.html.utf8)
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                label.attributedText = attributedString
            }
        }
        
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {}
}
