//
//  ContentView.swift
//  SpeedMemo
//
//  Created by 金子広樹 on 2023/04/28.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var focus: Bool
    @ObservedObject var viewModel = ContentViewModel.shared
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(viewModel.text.count) / \(textMaxCount)")
                    .bold()
                    .font(.system(size: 20))
                TextEditor(text: $viewModel.text)
                    .lineSpacing(5)
                    .padding()
                    .focused($focus, equals: true)
                    .onAppear(perform: {
                        viewModel.read()
                        // テキストが何もなかった場合のみ、新規modelを作成してキーボードを出す。
                        if viewModel.text.count == 0 {
                            // テキストを格納するモデルが作成されていない場合、新規作成する。
                            if viewModel.textData.count == 0 {
                                viewModel.create()
                            }
                            focus = true
                        }
                    })
                    .onChange(of: viewModel.text, perform: { value in
                        // 最大文字数に達したら、それ以上書き込めないようにする。
                        if value.count > textMaxCount {
                            viewModel.text.removeLast(viewModel.text.count - textMaxCount)
                            viewModel.update()
                        } else {
                            viewModel.update()
                        }
                    })
                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            BottomToolbarView(focus: $focus)
                        }
                        ToolbarItem(placement: .keyboard) {
                            HStack {
                                // 何故か空白のボタンを入れないとチェックマークが表示されなくなるので仕方なく入れている。
                                Button { } label: { }
                                Spacer()
                                Button {
                                    focus = false
                                } label: {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: textToolbarButtonSize)
                                        .foregroundColor(able)
                                }
                            }
                        }
                    }
            }
            .asAlert()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
