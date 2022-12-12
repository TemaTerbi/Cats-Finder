//
//  ImageExtension.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 12.10.2022.
//

import Foundation
import SwiftUI

struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data ) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            Image(systemName: "pawprint.fill")
                .resizable()
                .scaledToFit()
                .onAppear {
                    fetchData()
                }
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            self.data = data
        }
        task.resume()
    }
}
