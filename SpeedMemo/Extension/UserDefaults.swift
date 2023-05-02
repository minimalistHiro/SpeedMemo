//
//  userDefault.swift
//  SpeedMemo
//
//  Created by 金子広樹 on 2023/04/30.
//

import Foundation

extension UserDefaults {
    func removeAll() {
        dictionaryRepresentation().forEach { removeObject(forKey: $0.key) }
    }
}
