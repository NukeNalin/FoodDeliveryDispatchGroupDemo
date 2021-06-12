//
//  FoodModel.swift
//  FoodDeliveryDispatchGroupDemo
//
//  Created by Nalin Porwal on 11/06/21.
//

import Foundation
import UIKit
struct Restaurant: Codable, Hashable{
    let name, discription, address, image: String
    let id = UUID()

}

struct TopPick: Codable, Hashable{
    let name, image: String
    let id = UUID()
}

struct Cuisines: Codable, Hashable{
    let name, image: String
    let id = UUID()
}
/*
 "name": "Bhelwala.com",
 "discription": "Chaat, Beverages",
 "address": "Sarafa, Sarafa",
 "image": "https://res.cloudinary.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_508,h_320,c_fill/wsh9vql9ivnxmdmjtchk"
 },
 */
