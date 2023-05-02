//
//  Persistent.swift
//  SpeedMemo
//
//  Created by 金子広樹 on 2023/04/28.
//

import Foundation

let userDefaults = UserDefaults.standard
let keyName: String = "textKey"                 // キーネーム
let textMaxCount = 10000                        // テキスト最大文字数

struct AlertEntity {
    let title: String
    let message: String
    let actionText: String
    let cancelText: String
}
