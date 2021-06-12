//
//  HomeView.swift
//  FoodDeliveryDispatchGroupDemo
//
//  Created by Nalin Porwal on 11/06/21.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            headerView
            if viewModel.isLoading {
                topPicks
                popularCuisines
                allRestaurant
            } else {
                ProgressView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    /// `Home Header View`
    var headerView: some View {
        VStack {
            HStack(alignment: .top) {
                Rectangle()
                    .cornerRadius(7)
                    .foregroundColor(.orange)
                    .frame(width: 15, height: 70)
                Spacer()
                VStack(alignment: .leading) {
                    Text("We're here to help. Our restaurant and essential delivery services are open from:")
                        .bold()
                        .font(.title3)
                        .lineLimit(nil)
                    Text("8:00 AM to 10:30 PM")
                        .font(.subheadline)
                }
                Spacer(minLength: 10)
            }
        }
    }
    
    var topPicks: some View {
        VStack {
            HStack {
                Image(systemName: "hand.thumbsup")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                Text("Top Picks For You")
                    .bold()
                    .font(.title2)
                Spacer()
            }.padding(.leading, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.topPicks, id: \.self) { food in
                        ZStack {
                            VStack {
                                DonloadableImage.init(imgURL: food.image)
                                    .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
                                    .clipped()
                                Text("\(food.name)")
                                    .lineLimit(2)
                                    .font(.footnote)
                            }
                            
                            Text("50% Off")
                                .bold()
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(.leading, 3)
                                .padding(.trailing, 3)
                                .background(Color.orange)
                                .offset(x: 0, y: 20)
                                
                        }.frame(width: 70, height: 100, alignment: .center)
                            .padding(3)
                    }
                    .padding(.leading, 10)
                    Spacer()
                }
            }
        }
    }
    
    var popularCuisines: some View {
        VStack {
            HStack {
                Text("Popular Cuisines Around You ")
                    .bold()
                    .font(.title2)
                Spacer()
            }.padding(.leading, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.cuisines, id: \.self) { cuisines in
                        VStack{
                            DonloadableImage(imgURL: cuisines.image )
                                .frame(width: 80, height: 80)
                                .cornerRadius(40)
                                .clipped()
                                .shadow(color: .black, radius: 3, x: 0.0, y: 0.0)
                                .padding(6)
                            
                            Text("\(cuisines.name)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.bottom,5)
                        }
                        
                    }
                }
            }
        }
    }
    
    
    var allRestaurant: some View {
        VStack(alignment: .leading){
            HStack {
            VStack(alignment: .leading){
                Text("All Restaurants Near By You ")
                    .bold()
                    .font(.title2)
                Text("Discover unique tastes near you ")
                    .font(.subheadline)
            }
                Spacer()
            }.padding(.leading, 10)
            .frame(width:UIScreen.main.bounds.width)
            VStack {
                ForEach(viewModel.restaurant, id: \.self) { food in
                    HStack {
                        DonloadableImage(imgURL: food.image)
                            .frame(width: 90, height: 110)
                            .cornerRadius(5)
                            .clipped()
                            .padding(6)
                        VStack(alignment: .leading){
                            Text("\(food.name)")
                                .font(.title3)
                                .bold()
                            Text("\(food.discription)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("\(food.address)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            HStack{
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text("\(Int.random(in: 3..<5)) . \(Int.random(in: 20..<45)) mins. $\(Int.random(in: 100..<350)) for two")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }.padding(.leading,4)
                        Spacer()
                    }
                    
                }
            }.padding(4)
        }
    }
}


/*
 cuisines
 
 [
 {
  "name": "Pizza",
   "image": "http://thelollipop.in/image/cache/catalog/farm%20house-550x650.jpg",
 },
 {
  "name": "Sandwich",
   "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrzgfWxl3fyGOBMUxb24LTOfQxJEhqFBwbhMl9BHJg4YPvCTroVNM8lAGogIby3hTOmXA&usqp=CAU",
 },
 {
  "name": "Dosa",
   "image": "https://media.istockphoto.com/photos/cheese-masala-dosa-recipe-with-sambar-and-chutney-selective-focus-picture-id1156888714",
 },
 {
  "name": "chiness",
   "image": "https://www.wellandgood.com/wp-content/uploads/2020/12/chow-mein-cup-full-of-kale-feature.jpg",
 },
 {
  "name": "Indian",
   "image": "https://vnn-imgs-f.vgcloud.vn/2019/11/26/10/indian-food-is-terrible-tweet-sparks-hot-debate-about-racism.jpg",
 }
 ]
 */
//
/*
 allRestaurant
 [
 {
 "name": "Bhelwala.com",
 "discription": "Chaat, Beverages",
 "address": "Sarafa, Sarafa",
 "image": "https://res.cloudinary.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_508,h_320,c_fill/wsh9vql9ivnxmdmjtchk"
 },
 {
 "name": "Shri Athithi Restaurant",
 "discription": "Fast Food, Beverages",
 "address": "Kalani Nagar, Kalani Nagar",
 "image": "https://res.cloudinary.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_508,h_320,c_fill/ccr18xc39kvqk2ktaa07"
 },
 {
 "name": "Cup Bashii",
 "discription": "Beverages, Snacks,Fast Food, Beverages",
 "address": "Sudama Nagar, Sudama Nagar",
 "image": "https://res.cloudinary.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_508,h_320,c_fill/pdt7pdqmpizqbwpfq6sh"
 },
 {
 "name": "Madni Non Veg Restaurant",
 "discription": "North Indian, Combo, Mughlai, Lucknowi",
 "address": "Chandan Nagar, Sudama Nagar",
 "image": "https://res.cloudinary.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_508,h_320,c_fill/my8hb5rzaoolujq3wa8q"
 },
 {
 "name": "Midflight Garden Restaurant & Cafe",
 "discription": "Indian, Chinese, Tandoor",
 "address": "Kalani Nagar, Kalani Nagar",
 "image": "https://res.cloudinary.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_508,h_320,c_fill/h7exeyzmaqgptw1mavru"
 },
 {
 "name": "Chanchal Namkeen, Bhel & Chaats",
 "discription": "Bakery, Fast Food, Chaat, Beverages",
 "address": "Gangwal Bustand, Sarafa",
 "image": "https://res.cloudinary.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_508,h_320,c_fill/pwtcprsb1mrqfqkker0c"
 }
 ]
 */
/*
 topPicks
 [
 {
  "name": "Usal Poha",
  "image": "https://res.cloudinary.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_508,h_320,c_fill/an04puiprh5g0bd2hdkq"
 },
 {
  "name": "Soya Chaap",
  "image": "https://res.cloudinary.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_508,h_320,c_fill/f6kqpmaoy0h3ijeuqccp"
 },
 {
  "name": "Manchuriyan",
  "image": "https://res.cloudinary.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_508,h_320,c_fill/wmo1ymshjubygwxuv517"
 },
 {
  "name": "Paratha",
  "image": "https://res.cloudinary.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_508,h_320,c_fill/oecyzqehfysmfzczqeov"
 },
 {
  "name": "Pav Bhaji",
  "image": "https://res.cloudinary.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_508,h_320,c_fill/kyilspirp3xhiyh5e8lj"
 }
 ]
 */

