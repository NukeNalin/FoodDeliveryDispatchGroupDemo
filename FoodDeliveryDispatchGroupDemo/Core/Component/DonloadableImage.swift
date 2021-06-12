//
//  DonloadableImage.swift
//  FoodDeliveryDispatchGroupDemo
//
//  Created by Nalin Porwal on 11/06/21.
//

import SwiftUI

struct DonloadableImage: View {
    
    @StateObject var viewModel: ImageViewModel
    
    init(imgURL: String) {
        _viewModel = .init(wrappedValue: ImageViewModel(imgURL))
    }

    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if viewModel.isloading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(.black)
            }
        }
    }
}

struct DonloadableImage_Previews: PreviewProvider {
    static var previews: some View {
        DonloadableImage(imgURL: "")
    }
}

class ImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isloading: Bool = true
    
    
    init(_ url: String) {
       let tempURL = URL(string: url)!
        URLSession.shared.dataTask(with: tempURL) { data, response, error in
            if error == nil && data != nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                    self.isloading = false
                }
            }
        }.resume()
    }
}
