//
//  NavigationToolbarView.swift
//  SpeedMemo
//
//  Created by 金子広樹 on 2023/04/30.
//

import SwiftUI

struct NavigationToolbarView: View {
    @EnvironmentObject private var viewModel: ContentViewModel
    
    var body: some View {
        // 完了ボタン
        Button {
            viewModel.isFocus = false
        } label: {
            Image(systemName: "checkmark")
                .resizable()
                .asButton()
                .foregroundColor(viewModel.isFocus ? Color("Able") : Color("Disable"))
        }
        .disabled(!viewModel.isFocus)
    }
}

struct NavigationToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationToolbarView()
            .environmentObject(ContentViewModel())
    }
}
