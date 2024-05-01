//
//  HeroSheetView.swift
//  HeroForge
//
//  Created by Christopher Julius on 26/04/24.
//

import Foundation
import SwiftUI

struct HeroSheetView: View {
    @Environment(\.dismiss) var dismiss
    var data:[Hero] = [
        Hero(name: "Lancelot", image:"lancelot-bg", avatar:"lancelot-avatar", role:"Assassin", hp: 2459, hpGrowth: 147, mana: 450, manaGrowth: 100, physicalAtt: 124, physicalAttGrowth: 11.7857, physicalDef: 16, physicalDefGrowth: 3.1429, magicDef: 15, magicDefGrowth: 1.6429, attSpeed: 1.08, attSpeedGrowth: 0.0185,skill:
                [
                    Skill(name:"Puncture",maxLevel:6,baseDamage:[100],baseDamageGrowth: [30], additionalDamage: [AddDamage(percentPhysical:0.5)],image:"puncture-skill",cooldown:14.0,cooldownGrowth: 0.4,sound:"lancelot-skill-1"),
                    Skill(name:"Thorned Rose",maxLevel:6,baseDamage:[170,170,170],baseDamageGrowth: [15,15,15], additionalDamage: [AddDamage(percentPhysical:1.3),AddDamage(percentPhysical:1.3),AddDamage(percentPhysical:1.3)],image:"thorned-rose-skill",cooldown:10.0,cooldownGrowth: 0.6,sound:"lancelot-skill-2"),
                    Skill(name:"Phantom Execution",maxLevel:3,baseDamage:[350],baseDamageGrowth: [75], additionalDamage: [AddDamage(percentPhysical:1.7)],image:"phantom-execution-skill",cooldown:27.0,cooldownGrowth: 3.0,sound:"lancelot-skill-3"),
                ],basicSound: "lancelot-basic"),
        Hero(name: "Tigreal", image:"tigreal-bg", avatar:"tigreal-avatar", role:"Tank", hp: 2690, hpGrowth: 292, mana: 450, manaGrowth: 100, physicalAtt: 112, physicalAttGrowth: 6.7857, physicalDef: 20, physicalDefGrowth: 5.3571, magicDef: 15, magicDefGrowth: 2.5, attSpeed: 1.03, attSpeedGrowth: 0.02,skill:
                [
                    Skill(name:"Puncture",maxLevel:6,baseDamage:[100],baseDamageGrowth: [30], additionalDamage: [AddDamage(percentPhysical:0.5)],image:"puncture-skill",cooldown:14.0,cooldownGrowth: 0.4,sound:"lancelot-skill-1"),
                    Skill(name:"Thorned Rose",maxLevel:6,baseDamage:[170,170,170],baseDamageGrowth: [15,15,15], additionalDamage: [AddDamage(percentPhysical:1.3),AddDamage(percentPhysical:1.3),AddDamage(percentPhysical:1.3)],image:"thorned-rose-skill",cooldown:14.0,cooldownGrowth: 0.4,sound:"lancelot-skill-2"),
                    Skill(name:"Phantom Execution",maxLevel:6,baseDamage:[100],baseDamageGrowth: [30], additionalDamage: [AddDamage(percentPhysical:0.5)],image:"phantom-execution-skill",cooldown:14.0,cooldownGrowth: 0.4,sound:"lancelot-skill-3"),
                ],basicSound: "lancelot-basic"),
    ]
    @Binding var hero:Hero
    @Binding var current:Int?
    @State var chosen:Int?
    @State var name:String = ""
    var useData:[Hero] {
        if name != "" {
            return data.filter{
                $0.name.lowercased().contains(name.lowercased())
            }
        }else{
            return data
        }
    }
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading){
                HStack{
                    VStack(alignment:.leading){
                        ForEach(0..<((useData.count + 3) / 4), id: \.self) { rowIndex in
                            HStack {
                                Spacer()
                                ForEach(0..<4) { columnIndex in
                                    let heroIndex = rowIndex * 4 + columnIndex
                                    if heroIndex < data.count {
                                        let hero = data[heroIndex]
                                        if name == "" || hero.name.lowercased().contains(name.lowercased()) {
                                            VStack {
                                                if(heroIndex == current){
                                                    Circle()
                                                        .fill(.clear)
                                                        .frame(width: 60, height: 60)
                                                        .overlay(
                                                            Circle()
                                                                .stroke(Color.blue, lineWidth: 2)
                                                                .frame(width: 60, height: 60)
                                                        )
                                                        .background{
                                                            CircleItem(image:hero.avatar, size:50, strokeColor: Color.gray)
                                                        }
                                                }else{
                                                    CircleItem(image:hero.avatar, size:50, strokeColor: Color.gray)
                                                }
                                                Text(hero.name)
                                                    .font(.callout)
                                                    .fontWeight(.medium)
                                                    .fontDesign(.rounded)
                                                    .frame(width:70,height:30,alignment:.center)
                                                    .fixedSize(horizontal:true,vertical:true)
                                                    .truncationMode(.tail)
                                            }.onTapGesture{
                                                current = heroIndex
                                            }
                                            Spacer()
                                        } else {
                                            
                                        }
                                    } else {
                                        Circle()
                                            .fill(.clear)
                                            .frame(width: 60, height: 60)
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(16.0)
                .background(
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white.gradient.shadow(.drop(color: .gray, radius: 2.6, x: 0, y: 4)))
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                    }
                )
                Spacer()
            }
            .searchable(text: $name)
            .navigationTitle("Choose Hero")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){
                        dismiss()
                        current = chosen
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        hero.setHero(hero:data[current!])
                        dismiss()
                    }.disabled(current == chosen)
                }
            }.padding([.horizontal],16.0)
            
        }
    }
}
