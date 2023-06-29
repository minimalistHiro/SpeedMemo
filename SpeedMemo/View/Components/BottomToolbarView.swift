//
//  ToolbarView.swift
//  SpeedMemo
//
//  Created by 金子広樹 on 2023/04/28.
//

import SwiftUI

struct BottomToolbarView: View {
    @ObservedObject var viewModel = ContentViewModel.shared
    @State private var isShowCopyMessage: Bool = false          // 「コピーしました」メッセージ表示の有無
    var isShowButtons: Bool {
        if focus.wrappedValue || viewModel.text.count == 0 {
            return false
        } else {
            return true
        }
    }                                                           // ボトムバーボタンの表示有無
    var focus: FocusState<Bool>.Binding
    
    var body: some View {
        HStack {
            // ゴミ箱ボタン
            Button {
                viewModel.inputs = .tappedDeleteButton
                viewModel.apply()
            } label: {
                Image(systemName: "trash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: toolbarButtonsSize)
                    .foregroundColor(able)
                    .offset(y: isShowButtons ? 0 : UIScreen.main.bounds.height / 2 )
                    .animation(Animation.default, value: isShowButtons)
//                    .foregroundColor(focus.wrappedValue || viewModel.text.count == 0 ? disable : able)
            }
            .disabled(!isShowButtons)
            
            Spacer()
            
            // コピーメッセージ
            Capsule()
                .frame(width: copyMessageFrameSize)
                .foregroundColor(able)
                .overlay {
                    Text("コピーしました")
                        .foregroundColor(disable)
                        .bold()
                }
                .offset(y: isShowCopyMessage ? 0 : UIScreen.main.bounds.height / 2 )
                .animation(Animation.default, value: isShowCopyMessage)
            
            Spacer()
            
            // コピーボタン
            Button {
                UIPasteboard.general.string = viewModel.text
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                isShowCopyMessage = true
                vanishMessage()
            } label: {
                Image(systemName: "doc.on.doc")
                    .resizable()
                    .scaledToFit()
                    .frame(width: toolbarButtonsSize)
                    .foregroundColor(able)
                    .offset(y: isShowButtons ? 0 : UIScreen.main.bounds.height / 2 )
                    .animation(Animation.default, value: isShowButtons)
//                    .foregroundColor(focus.wrappedValue || viewModel.text.count == 0 ? disable : able)
            }
            .disabled(!isShowButtons)
//            .disabled(focus.wrappedValue || viewModel.text.count == 0)
        }
    }
    
    // メッセージを自動で閉じる処理
    private func vanishMessage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isShowCopyMessage = false
        }
    }
}
