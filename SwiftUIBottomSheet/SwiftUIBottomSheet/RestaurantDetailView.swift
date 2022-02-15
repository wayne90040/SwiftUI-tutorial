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
    
    enum ViewState {
        
        case full
        
        case half
    }
    
    /// 偵測手勢狀態
    @GestureState private var dragState: DragState = .inactive
    
    /// 偵測位置偏移量
    @State private var positionOffSet: CGFloat = 0
    
    /// default 展開一半
    @State private var viewState: ViewState = .half
    
    @State private var scrollOffset: CGFloat = 0.0
    
    @Binding var isShow: Bool
    
    let restaurant: Restaurant
    
    var body: some View {
        
        /// Use `GeometryReader` to Get Device info
        GeometryReader { reader in
            
            VStack {
                HandleBar()
                
                ScrollView(.vertical) {
                    
                    /// 儲存滾動的偏移量
                    GeometryReader { reader in
                        Color.clear.preference(key: ScrollOffset.self,
                                               value: reader.frame(in: .named("scroll")).minY)
                    }.frame(height: 0)
                    
                    VStack {
                        TitleBar()
                        
                        HeaderView(restaurant: restaurant)
                        
                        DetailInfoView(icon: "map", info: restaurant.location)
                            .padding(.top)
                        
                        DetailInfoView(icon: "phone", info: restaurant.phone)
                            .padding(.top)
                        
                        DetailInfoView(info: restaurant.description)
                            .padding(.top)
                            /// fix unable to show all text
                            .padding(.bottom, 100)
                    }
                    .offset(y: -scrollOffset)
                    .animation(nil)
                }
                /// `DetailView` is `half`, disable `ScrollView`
                .disabled(viewState == .half)
                .background(Color.white)
                .cornerRadius(10, antialiased: true)
                .coordinateSpace(name: "scroll")
            }
            .offset(y: reader.size.height / 2 + dragState.translation.height + positionOffSet)
            .animation(.interpolatingSpring(stiffness: 200, damping: 25), value: 10)
            .edgesIgnoringSafeArea(.all)
            /// Handle `Full`screen to `Half`
            .onPreferenceChange(ScrollOffset.self) { value in
                if viewState == .full {
                    scrollOffset = value > 0 ? value : 0
                    
                    if scrollOffset > 120 {
                        positionOffSet = 0
                        viewState = .half
                        scrollOffset = 0
                    }
                }
            }
            /// Handle `Drag`
            .gesture(DragGesture()
                /// Update `dragState`
                .updating($dragState, body: { value, state, transaction in
                    state = .dragging(translation: value.translation)
                })
                .onEnded({ value in
                    
                    if viewState == .half {
                        
                        /// 向上滾動，超過特定位置(佔滿 3/4)則變 `Full`
                        if value.translation.height < -reader.size.height * 0.25 {
                            viewState = .full
                            positionOffSet = -reader.size.height/2 + 50
                        }
                        
                        if value.translation.height > reader.size.height * 0.3 {
                            /// Hide Detail View
                            isShow = false
                            
                        }
                    }
                })
            )
        }
    }
}


struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(isShow: .constant(true), restaurant: restaurants[0])
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


/// https://stackoverflow.com/questions/62588015/get-the-current-scroll-position-of-a-swiftui-scrollview
struct ScrollOffset: PreferenceKey {
    
    typealias Value = CGFloat
    
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
