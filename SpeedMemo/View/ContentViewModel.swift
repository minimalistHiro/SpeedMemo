//
//  ContentViewModel.swift
//  SpeedMemo
//
//  Created by 金子広樹 on 2023/04/28.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    static var shared: ContentViewModel = ContentViewModel()
    
    @Published var textData: [TextData] = Array(TextData.findAll())
    @Published var alertEntity: AlertEntity?
    @Published var inputs: Inputs = .none                   // ボタン押下実行処理
    @Published var text: String = ""                        // 入力テキスト
    @Published var isShowAlert: Bool = false                // アラート表示有無
    
    enum Inputs {
        case none
        case tappedDeleteButton
    }
    
    // ボタン押下時実行処理
    func apply() {
        switch inputs {
        case .none:
            break
        case .tappedDeleteButton:
            addAlertEntity()
            isShowAlert = true
        }
    }
    
    // アラートの作成
    func addAlertEntity() {
        switch inputs {
        case .none:
            break
        case .tappedDeleteButton:
            alertEntity = AlertEntity(title: "",
                                      message: "全て削除しますか？",
                                      actionText: "削除",
                                      cancelText: "キャンセル",
                                      button: .double)
        }
    }
    
    // アラートの実行処理
    func alertAction() {
        switch inputs {
        case .none:
            break
        case .tappedDeleteButton:
            text = ""
            TextData.delete()
            create()
        }
    }
    
    // Boolをチェック
    func isCheckBool(_ value: Bool) -> Bool {
        if value {
            return true
        } else {
            return false
        }
    }
    
    // 新規データの作成
    func create() {
        let model = TextData()
        TextData.add(model)
    }
    
    // データの取得
    func read() {
        // modelからviewModelにテキストデータを追加
        if let result = textData.last?.text {
            text = result
        }
    }
    
    // データを更新
    func update() {
        // viewModelからmodelにテキストデータを更新
        TextData.update(text)
    }
}
