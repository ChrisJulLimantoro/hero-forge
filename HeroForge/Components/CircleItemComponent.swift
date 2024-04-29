//
//  CircleItemComponent.swift
//  HeroForge
//
//  Created by Christopher Julius on 28/04/24.
//

import Foundation
import SwiftUI

struct CircleItem: View {
    var image:String
    var size:CGFloat
    var strokeColor:Color
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().stroke(strokeColor, lineWidth: 2))
    }
}
