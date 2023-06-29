//
//  AlertModifier.swift
//  SpeedMemo
//
//  Created by 金子広樹 on 2023/06/10.
//

import SwiftUI

struct AlertModifier: ViewModifier {
    @ObservedObject var viewModel = ContentViewModel.shared
    
    func body(content: Content) -> some View {
        content
            .alert(viewModel.alertEntity?.title ?? "",
                   isPresented: $viewModel.isShowAlert,
                   presenting: viewModel.alertEntity) { entity in
                if viewModel.alertEntity?.button == .single {
                    Button(entity.actionText) {
                        viewModel.isShowAlert = false
                    }
                } else {
                    Button(entity.actionText, role: .destructive) {
                        viewModel.alertAction()
                    }
                    Button(entity.cancelText, role: .cancel) {
                        viewModel.isShowAlert = false
                    }
                }
            } message: { entity in
                Text(entity.message)
            }
    }
}
