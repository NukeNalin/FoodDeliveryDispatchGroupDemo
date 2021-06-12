//
//  HomeViewModel.swift
//  FoodDeliveryDispatchGroupDemo
//
//  Created by Nalin Porwal on 11/06/21.
//

import Foundation

class HomeViewModel: ObservableObject{
    
    @Published var isLoading: Bool = false
    var restaurant = [Restaurant]()
    var topPicks = [TopPick]()
    var cuisines = [Cuisines]()
    static var mainURL = "https://raw.githubusercontent.com/NukeNalin/foodData/main/"
    
    enum EndPoints: String{
        case restaurants = "restaurants.json"
        case topPicks = "topPicks.json"
        case cuisines = "cuisines.json"
        
        var url: String {
            return HomeViewModel.mainURL + self.rawValue
        }
    }
    
    init() {
        getHomeDataWithDispatchGroup()
    }
    
    private func getHomeDataWithDispatchGroup() {
        
        ///`Create Object Of DispatchGroup`
        
        let dispatchGroup = DispatchGroup()
  
        
        /// `TASK FIRST--------------------------------`
        // enter for first API
        dispatchGroup.enter()
        
        // Call first API
        getData(EndPoints.restaurants.url, [Restaurant].self) { data in
            self.restaurant = data

            // Once we get data then call Leave
            dispatchGroup.leave()
        }
        
        /// `TASK SECOND--------------------------------`
        // enter for Second  API
        dispatchGroup.enter()
        
        // Call first API
        getData(EndPoints.topPicks.url, [TopPick].self) { data in
            self.topPicks = data
            
            // Once we get data of second then call Leave
            dispatchGroup.leave()
        }
        
        /// `TASK THIRD--------------------------------`
        // enter for third  API
        dispatchGroup.enter()
        
        // Call third API
        getData(EndPoints.cuisines.url, [Cuisines].self) { data in
            self.cuisines = data
            
            // Once we get data of second then call Leave
            dispatchGroup.leave()
        }

        
        /// `Notify Main thread`
        dispatchGroup.notify(queue: .main) {
            self.isLoading = true
        }
    }
    
    
    
    private func getHomeDataWithCallBack() {
        /// API First
        getData(EndPoints.restaurants.url, [Restaurant].self)
           { restaurant in
            
            self.restaurant = restaurant
            
            /// API Second
            self.getData(EndPoints.topPicks.url, [TopPick].self)
              { topPicks in
                
                self.topPicks = topPicks
                
                /// API Third
                self.getData(EndPoints.cuisines.url, [Cuisines].self)
                 { cuisines in
                    
                    self.cuisines = cuisines
                    
                    self.isLoading = true
                }
            }
        }
    }
    
    
    private func getData<DataKind:Codable>(_ url: String,_ dataKind: DataKind.Type, _ completion: @escaping (_ data:DataKind)->Void) {
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                let convertedData = try! JSONDecoder().decode(dataKind, from: data!)
                completion(convertedData)
            }
        }.resume()
    }
}
