//
//  RestaurantDetailView.swift
//  SwiftUIBottomSheet
//
//  Created by Wei Lun Hsu on 2022/2/15.
//

import SwiftUI

struct RestaurantDetailView: View {
    let restaurant: Restaurant
    
    var body: some View {
        
        /// Use `GeometryReader` to Get Device info
        GeometryReader {
            VStack {
                HandleBar()
                
                ScrollView(.vertical) {
                    TitleBar()
                    
                    HeaderView(restaurant: restaurant)
                    
                    DetailInfoView(icon: "map", info: restaurant.location)
                        .padding(.top)
                    
                    DetailInfoView(icon: "phone", info: restaurant.phone)
                        .padding(.top)
                    
                    DetailInfoView(info: restaurant.description)
                        .padding(.top)
                }
                .background(Color.white)
                .cornerRadius(10, antialiased: true)
            }
            /// GeometryReader
            .offset(y: $0.size.height / 2)
            .animation(.interpolatingSpring(stiffness: 200, damping: 25), value: 10)
            .edgesIgnoringSafeArea(.all)
        }
    }
}


struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(restaurant: restaurants[0])
           
    }
}


// MARK: -
struct HandleBar: View {
    var body: some View {
        Rectangle()
            .frame(width: 50, height: 5)
            /// init Color by `UIColor`
            .foregroundColor(Color(.systemGray5))
            .cornerRadius(10)
    }
}


// MARK: -
struct TitleBar: View {
    var body: some View {
        HStack {
            Text("Restaurant Details")
                .font(.headline)
                .foregroundColor(.primary)
            
            /// make `Text` Align left
            Spacer()
        }
        .padding()
    }
}


// MARK: -
struct HeaderView: View {
    
    let restaurant: Restaurant
    
    var body: some View {
        Image(restaurant.image)
            .resizable()
            .scaledToFill()
            .frame(height: 300)
            .clipped()
            .overlay(
                HStack {
                    VStack(alignment: .leading) {
                        
                        /// Make View Align bottom
                        Spacer()
                        
                        Text(restaurant.name)
                            .foregroundColor(.white)
                            .font(.system(.largeTitle, design: .rounded))
                            .bold()
                        
                        Text(restaurant.type)
                            .font(.system(.headline, design: .rounded))
                            .padding(5)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(5)
                    }.padding()
                    
                    /// make View Align left
                    Spacer()
                }
            )
    }
}


// MARK: -

/// Example have `icon` & `text`
/// `DetailInfoView(icon: "map", info: restaurant.location)`
struct DetailInfoView: View {
    
    let icon: String?
    let info: String
    
    init(icon: String? = nil, info: String) {
        self.icon = icon
        self.info = info
    }
    
    var body: some View {
        HStack {
            if let icon = icon {
                Image(systemName: icon)
                    .padding(.trailing, 10)
            }
            Text(info)
                .font(.system(.body, design: .rounded))
            Spacer()
        }.padding(.horizontal)
    }
}
