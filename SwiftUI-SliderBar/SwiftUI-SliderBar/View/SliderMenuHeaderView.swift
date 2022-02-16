//
//  SliderMenuHeaderView.swift
//  SwiftUI-SliderBar
//
//  Created by Wei Lun Hsu on 2022/2/16.
//

import SwiftUI

struct SliderMenuHeaderView: View {
    
    @Binding var isShowSlider: Bool
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            Button {
                withAnimation(.spring()) {
                    isShowSlider.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
                    .padding()
            }

            VStack(alignment: .leading) {
                
                Image("header")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
                    .padding(.bottom, 16)
                
                Text("HSU WEI LUN")
                    .font(.system(size: 24, weight: .semibold))
                
                Text("@wayne90040")
                    .font(.system(size: 14))
                    .padding(.bottom, 14)
                
                HStack(spacing: 12) {
                    
                    HStack(spacing: 4) {
                        Text("1,254").bold()
                        Text("Following")
                    }
                    HStack(spacing: 4) {
                        Text("607").bold()
                        Text("Followers")
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct SliderMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderMenuHeaderView(isShowSlider: .constant(true))
    }
}
