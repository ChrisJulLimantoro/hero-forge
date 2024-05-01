//
//  SkillLevelingComponent.swift
//  HeroForge
//
//  Created by Christopher Julius on 01/05/24.
//

import Foundation
import SwiftUI

struct SkillLevelingComponent:View {
    @Binding var isLeveling:Bool
    @Binding var attacker:Hero
    @State var indexSkill:Int
    
    var body: some View{
        VStack{
            Text("+")
                .font(.title)
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .foregroundStyle(.white)
                .background(
                    CustomCircleComponent(size:30,strokeColor:Color.white,line:2)
                )
                .onTapGesture{
                    isLeveling = attacker.skillLevelUp(skillIndex:indexSkill)
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    
                    generator.impactOccurred()
                }
                .padding(.top,-12.0)
            Text("-")
                .font(.title)
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .foregroundStyle(.white)
                .background(
                    CustomCircleComponent(size:30,strokeColor:Color.white,line:2)
                )
                .onTapGesture{
                    isLeveling = attacker.skillLevelDown(skillIndex:indexSkill)
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    
                    generator.impactOccurred()
                }
        }
    }
}
