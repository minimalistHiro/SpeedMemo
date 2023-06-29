//
//  Persistent.swift
//  SpeedMemo
//
//  Created by 金子広樹 on 2023/04/28.
//

import SwiftUI
import RealmSwift

// 各種設定
let userDefaults = UserDefaults.standard
let keyName: String = "textKey"                         // キーネーム
let textMaxCount: Int = 10000                           // テキスト最大文字数

// サイズ
let toolbarButtonsSize: CGFloat = 25                    // ツールバーのボタンサイズ
let textToolbarButtonSize: CGFloat = 25                 // テキストツールバーボタンサイズ
let copyMessageFrameSize: CGFloat = 150                 // コピーメッセージフレームサイズ

// 固定色
let able: Color = Color("Able")                         // 文字・ボタン色
let disable: Color = Color("Disable")                   // 背景色

class TextData: Object {
    @Persisted var text: String
}

struct AlertEntity {
    // アラートボタンの個数
    enum AlertButton {
        case single
        case double
    }
    let title: String
    let message: String
    let actionText: String
    let cancelText: String
    let button: AlertButton
}

extension TextData {
    private static var config = Realm.Configuration(schemaVersion: 1)
    private static var realm = try! Realm(configuration: config)
    
    static func findAll() -> Results<TextData> {
        realm.objects(self)
    }
    
    static func add(_ data: TextData) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    static func update(_ text: String) {
        let result = findAll().last!
        try! realm.write {
            result.text = text
        }
    }
    
    static func delete() {
        try! realm.write {
            let table = realm.objects(self)
            realm.delete(table)
        }
    }
}
