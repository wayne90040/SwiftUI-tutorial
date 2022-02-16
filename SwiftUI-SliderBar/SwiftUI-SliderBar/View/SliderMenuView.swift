//
//  SliderMenuView.swift
//  SwiftUI-SliderBar
//
//  Created by Wei Lun Hsu on 2022/2/16.
//

import SwiftUI

struct SliderMenuView: View {
    
    @Binding var isShowSlider: Bool
    
    var body: some View {
        
        ZStack {
            LinearGradient(
                gradient: Gradient(
                    colors: [.blue, .purple]),
                startPoint: .top,
                endPoint: .bottom
            ).ignoresSafeArea()
                
            VStack {
                /// Header
                SliderMenuHeaderView(isShowSlider: $isShowSlider)
                    .foregroundColor(.white)
                    .frame(height: 240)
                
                /// Cell Items
                ForEach(SliderMenuViewModel.allCases, id: \.self) { option in
                    
                    NavigationLink {
                        Text(option.title)
                    } label: {
                        SliderMenuOptionView(viewModel: option)
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
            }.navigationBarHidden(true)
        }
    }
}

struct SliderMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SliderMenuView(isShowSlider: .constant(true))
    }
}
