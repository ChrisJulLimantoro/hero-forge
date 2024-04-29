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
        Hero(name: "Lancelot", image:"lancelot-bg", avatar:"lancelot-avatar", role:"Assassin", hp: 2459, hpGrowth: 147, mana: 450, manaGrowth: 100, physicalAtt: 124, physicalAttGrowth: 11.7857, physicalDef: 16, physicalDefGrowth: 3.1429, magicDef: 15, magicDefGrowth: 1.6429, attSpeed: 1.08, attSpeedGrowth: 0.0185),
        Hero(name: "Tigreal", image:"tigreal-bg", avatar:"tigreal-avatar", role:"Tank", hp: 2690, hpGrowth: 292, mana: 450, manaGrowth: 100, physicalAtt: 112, physicalAttGrowth: 6.7857, physicalDef: 20, physicalDefGrowth: 5.3571, magicDef: 15, magicDefGrowth: 2.5, attSpeed: 1.03, attSpeedGrowth: 0.02),
    ]
    @Binding var hero:Hero
    @Binding var chosen:Int?
    @State var name:String = ""
    @State var current:Int?
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    VStack{
                        ForEach(0..<((data.count + 3) / 4), id: \.self) { rowIndex in
                            HStack {
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
                                            }.onTapGesture{
                                                current = heroIndex
                                            }
                                            Spacer()
                                        } else {
                                            Spacer()
                                        }
                                    } else {
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
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        chosen = current
                        hero.setHero(hero:data[chosen!])
                        dismiss()
                    }.disabled(current == chosen)
                }
            }.padding([.horizontal],16.0)
        }
    }
}
