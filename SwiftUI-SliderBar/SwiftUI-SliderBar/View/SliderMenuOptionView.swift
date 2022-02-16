//
//  SliderMenuOptionView.swift
//  SwiftUI-SliderBar
//
//  Created by Wei Lun Hsu on 2022/2/16.
//

import SwiftUI

struct SliderMenuOptionView: View {
    
    let viewModel: SliderMenuViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: viewModel.imageName)
                .frame(width: 24, height: 24)
            
            Text(viewModel.title)
                .font(.system(size: 15, weight: .semibold))
            
            Spacer()
        }
        .padding()
    }
}

struct SliderMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SliderMenuOptionView(viewModel: .profile)
    }
}
