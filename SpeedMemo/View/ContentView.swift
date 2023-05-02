//
//  ContentView.swift
//  SpeedMemo
//
//  Created by 金子広樹 on 2023/04/28.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var focus: Bool
    @EnvironmentObject private var viewModel: ContentViewModel
    
    var body: some View {
        NavigationStack {
            Text("\(viewModel.text.count) / \(textMaxCount)")
                .bold()
                .font(.system(size: 20))
            TextEditor(text: $viewModel.text)
                .lineSpacing(5)
                .padding()
                .focused($focus, equals: true)
                .onAppear(perform: {
                    viewModel.readText()
                    focus = true
                })
                .onChange(of: viewModel.text, perform: { value in
                    // 最大文字数に達したら、それ以上書き込めないようにする
                    if value.count > textMaxCount {
                        viewModel.text.removeLast(viewModel.text.count - textMaxCount)
                        viewModel.updateText(text: viewModel.text)
                        viewModel.readText()
                    } else {
                        viewModel.updateText(text: viewModel.text)
                        viewModel.readText()
                    }
                })
                .onChange(of: focus, perform: { value in
                    viewModel.isFocus = viewModel.isCheckBool(value)
                })
                .onChange(of: viewModel.isFocus, perform: { value in
                    focus = viewModel.isCheckBool(value)
                })
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        BottomToolbarView()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationToolbarView()
                    }
                }
                .alert(viewModel.alertEntity?.title ?? "",
                       isPresented: $viewModel.isShowAlert,
                       presenting: viewModel.alertEntity) { entity in
                    Button(entity.actionText, role: .destructive) {
                        viewModel.text = ""
                    }
                    Button(entity.cancelText, role: .cancel) {
                        viewModel.isShowAlert = false
                    }
                } message: { entity in
                    Text(entity.message)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentViewModel())
    }
}
