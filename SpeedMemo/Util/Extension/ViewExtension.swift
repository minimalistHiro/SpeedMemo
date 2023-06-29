//
//  ViewExtension.swift
//  SpeedMemo
//
//  Created by 金子広樹 on 2023/06/10.
//

import SwiftUI

extension View {
    func asAlert() -> some View {
        modifier(AlertModifier())
    }
}
