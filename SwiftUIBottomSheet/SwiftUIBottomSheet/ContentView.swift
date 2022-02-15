//
//  ContentView.swift
//  SwiftUIBottomSheet
//
//  Created by Simon Ng on 1/9/2020.
//

import SwiftUI

struct ContentView: View {
    
    /// whether show `RestaurantDetailView`
    @State private var isShowDetail = false
    
    /// Store `Restaurant` which be tapped
    @State private var selectDetail: Restaurant?
    
    var body: some View {
        
        ZStack {
            
            // Restaurant List View
            NavigationView {
                List {
                    ForEach(restaurants) { restaurant in
                        BasicImageRow(restaurant: restaurant)
                            .onTapGesture {
                                isShowDetail = true
                                selectDetail = restaurant
                            }
                    }
                }
                .navigationBarTitle("Restaurants")
            }
            .offset(y: isShowDetail ? -100 : 0)
            .animation(.easeOut(duration: 0.2))
            
            // Show Detail View
            if isShowDetail {
                
                if let model = selectDetail {
                    
                    BlankView(backgroundColor: .black)
                        .opacity(0.5)
                        .onTapGesture {
                            isShowDetail = false
                        }
                    
                    RestaurantDetailView(isShow: $isShowDetail, restaurant: model)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// MARK: -
struct BasicImageRow: View {
    var restaurant: Restaurant
    
    var body: some View {
        HStack {
            Image(restaurant.image)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(5)
            Text(restaurant.name)
        }
    }
}


// MARK: -
struct BlankView: View {
    
    var backgroundColor: Color
    
    var body: some View {
        
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity,
               minHeight: 0, maxHeight: .infinity)
        .background(backgroundColor)
        .edgesIgnoringSafeArea(.all)
    }
}
