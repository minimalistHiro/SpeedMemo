//
//  ViewExtension.swift
//  SpeedMemo
//
//  Created by 金子広樹 on 2023/04/30.
//

import SwiftUI

extension View {
    func asButton() -> some View {
        modifier(ButtonModifier())
    }
}
