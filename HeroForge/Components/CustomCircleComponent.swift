//
//  CustomCircleComponent.swift
//  HeroForge
//
//  Created by Christopher Julius on 30/04/24.
//

import Foundation
import SwiftUI

struct CustomCircleComponent:View {
    var size:CGFloat
    var strokeColor:Color
    var line:CGFloat
    var body: some View {
        Circle()
            .fill(.clear)
            .frame(width: size, height: size)
            .overlay(
                Circle()
                    .stroke(strokeColor, lineWidth: line)
                    .frame(width: size, height: size)
                )
    }
}
