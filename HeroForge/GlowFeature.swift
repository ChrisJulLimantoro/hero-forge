//
//  GlowFeature.swift
//  HeroForge
//
//  Created by Christopher Julius on 01/05/24.
//

import Foundation
import SwiftUI

struct Glow:ViewModifier {
    @State var throb = false
    func body(content: Content) -> some View {
        ZStack{
            content
                .blur(radius:15)
                .animation(.easeOut(duration: 0.2),value: throb)
            
            content
        }
    }
}

extension View {
    func glow() -> some View {
        modifier(Glow())
    }
}
