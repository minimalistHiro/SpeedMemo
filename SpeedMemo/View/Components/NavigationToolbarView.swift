//
//  NavigationToolbarView.swift
//  SpeedMemo
//
//  Created by 金子広樹 on 2023/04/30.
//

import SwiftUI

struct NavigationToolbarView: View {
    @ObservedObject var viewModel = ContentViewModel.shared
    var focus: FocusState<Bool>.Binding
    
    var body: some View {
        // 完了ボタン
        Button {
            focus.wrappedValue = false
        } label: {
            Image(systemName: "checkmark")
                .resizable()
                .scaledToFit()
                .frame(width: toolbarButtonsSize)
                .foregroundColor(focus.wrappedValue || viewModel.text.count == 0 ? able : disable)
        }
        .disabled(!focus.wrappedValue)
    }
}
