//
//  ButtonModifier.swift
//  SpeedMemo
//
//  Created by 金子広樹 on 2023/04/30.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(width: 25)
    }
}
