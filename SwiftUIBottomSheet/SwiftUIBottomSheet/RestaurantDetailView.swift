//
//  RestaurantDetailView.swift
//  SwiftUIBottomSheet
//
//  Created by Wei Lun Hsu on 2022/2/15.
//

import SwiftUI

enum DragState {
    
    case inactive
    
    case pressing
    
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        
        switch self {
        case .pressing, .dragging:
            return true
        case .inactive:
            return false
        }
    }
}

struct RestaurantDetailView: View {
    
    /// 偵測手勢狀態
    @GestureState private var dragState: DragState = .inactive
    
    /// 偵測位置偏移量
    @State private var positionOffSet: CGFloat = 0
    
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
            .offset(y: $0.size.height / 2 + dragState.translation.height)
            .animation(.interpolatingSpring(stiffness: 200, damping: 25), value: 10)
            .edgesIgnoringSafeArea(.all)
            
            // MARK: - 目前已經可以透過 HandleBar() 來滑動式圖
            // 之後要解決手勢衝突的問題(透過滑動內容來控制視圖全開)
            .gesture(DragGesture()
                /// Update `dragState`
                .updating($dragState, body: { value, state, transaction in
                    state = .dragging(translation: value.translation)
                })
            )
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
