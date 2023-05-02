//
//  ContentViewModel.swift
//  SpeedMemo
//
//  Created by 金子広樹 on 2023/04/28.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    
    @Published var alertEntity: AlertEntity?
    @Published var text: String = ""                        // 入力テキスト
    @Published var isShowAlert: Bool = false                // アラート表示有無
    @Published var isFocus: Bool = false                    // テキストフォーカスの有無
    @Published var copyMessage: Bool = false                // 「コピーしました」メッセージ表示の有無
    
    // 削除アラートを作成
    func addDeleteAlertEntity() -> AlertEntity {
        let alertEntity = AlertEntity(title: "",
                                      message: "全て削除しますか？",
                                      actionText: "削除",
                                      cancelText: "キャンセル")
        return alertEntity
    }
    
    // Boolをチェック
    func isCheckBool(_ value: Bool) -> Bool {
        if value {
            return true
        } else {
            return false
        }
    }
    
    // BottomToolbarのボタンの有効性チェック
    func isCheckEnableBottomToolbar() -> Bool {
        if isFocus || text.count == 0 {
            return true
        } else {
            return false
        }
    }
    
    // メッセージを自動で閉じる処理
    func vanishMessage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.copyMessage = false
        }
    }

    // テキストを更新
    func updateText(text: String) {
        userDefaults.set(text, forKey: keyName)
    }
    
    // テキストを読み込む
    func readText() {
        text = userDefaults.string(forKey: keyName) ?? ""
    }
}
