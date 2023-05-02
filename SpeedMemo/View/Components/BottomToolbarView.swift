//
//  ToolbarView.swift
//  SpeedMemo
//
//  Created by 金子広樹 on 2023/04/28.
//

import SwiftUI

struct BottomToolbarView: View {
    @EnvironmentObject private var viewModel: ContentViewModel
    
    var body: some View {
        HStack {
            // ゴミ箱ボタン
            Button {
                if viewModel.text.count > 0 {
                    viewModel.alertEntity = viewModel.addDeleteAlertEntity()
                    viewModel.isShowAlert = true
                }
            } label: {
                Image(systemName: "trash")
                    .resizable()
                    .asButton()
                    .foregroundColor(viewModel.isCheckEnableBottomToolbar() ? Color("Disable") : Color("Able"))
            }
            .disabled(viewModel.isCheckEnableBottomToolbar())
            
            Spacer()
            
            // コピーメッセージ
            Capsule()
                .frame(width: 150)
                .foregroundColor(Color("Able"))
                .overlay {
                    Text("コピーしました")
                        .foregroundColor(Color("Disable"))
                        .bold()
                }
                .offset(y: viewModel.copyMessage ? 0 : UIScreen.main.bounds.height / 2 )
                .animation(Animation.default, value: viewModel.copyMessage)
            
            Spacer()
            
            // コピーボタン
            Button {
                UIPasteboard.general.string = viewModel.text
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                viewModel.copyMessage = true
                viewModel.vanishMessage()
            } label: {
                Image(systemName: "doc.on.doc")
                    .resizable()
                    .asButton()
                    .foregroundColor(viewModel.isCheckEnableBottomToolbar() ? Color("Disable") : Color("Able"))
            }
            .disabled(viewModel.isCheckEnableBottomToolbar())
        }
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomToolbarView()
            .environmentObject(ContentViewModel())
    }
}
