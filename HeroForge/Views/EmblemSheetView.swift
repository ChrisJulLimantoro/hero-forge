//
//  EmblemSheetView.swift
//  HeroForge
//
//  Created by Christopher Julius on 26/04/24.
//

import Foundation
import SwiftUI

struct EmblemSheetView: View {
    @Environment(\.dismiss) var dismiss
    @State var currentType:String
    @Binding var chosen:Int?
    @State var current:Int?
    @State var search:String = ""
    @Binding var hero:Hero
    var data:[String:[Emblem]] = [
        "main" : [
            Emblem(name:"Assassin",image:"assassin-emblem",textAtt: ["+ 14 Adaptive Penetration","+ 10 Adaptive Attack","+ 3% Movement Speed"]),
            Emblem(name:"Common",image:"common-emblem",textAtt: ["+ 12 Hybrid Regen","+ 275 HP","+ 22 Adaptive Attack"]),
            Emblem(name:"tank",image:"tank-emblem",textAtt: ["+ 500 HP","+ 10 Hybrid Defense","+ 4 HP Regen"]),
            Emblem(name:"Mage",image:"mage-emblem",textAtt: ["+ 30 Magic Power","+ 5% Cooldown Reduction","+ 8 Magic Penetration"]),
            Emblem(name:"Fighter",image:"fighter-emblem",textAtt: ["+ 10% Spell Vamp","+ 22 Adaptive Attack","+ 6 Hybrid Defense"]),
            Emblem(name:"Marksman",image:"marksman-emblem",textAtt: ["+ 15% Attack Speed","+ 5% Adaptive Attack","+ 5% Lifesteal"]),
            Emblem(name:"Support",image:"support-emblem",textAtt: ["+ 12% Healing Effect","+ 10% Cooldown Reduction", "+ 6% Movement Speed"])
        ],
        "sub1" : [
            Emblem(name:"Thrill", image:"thrill-emblem", textAtt:["+ 16 Adaptive Attack"]),
            Emblem(name:"Swift",image:"swift-emblem",textAtt:["+ 10% Attack Speed"]),
            Emblem(name:"Vitality",image:"vitality-emblem",textAtt:["+ 225 HP"]),
            Emblem(name:"Rupture",image:"rupture-emblem",textAtt:["+ 5 Adaptive Penetration"]),
            Emblem(name:"Inspire",image:"inspire-emblem",textAtt: ["+ 5% Cooldown Reduction"]),
            Emblem(name:"Firmness",image:"firmness-emblem",textAtt:["+ 6 Hybrid Defense"]),
            Emblem(name:"Agility",image:"agility-emblem",textAtt:["+ 4% Movement Speed"]),
            Emblem(name:"Fatal",image:"fatal-emblem",textAtt:["+ 5% Critical Chance","+ 10% Critical Damage"]),
        ],
        "sub2" : [
            Emblem(name:"Wilderness Blessing", image:"wb-emblem", textAtt: ["+ 10% Movement Speed in Jungle and River"]),
            Emblem(name:"Seasoned Hunter", image:"sh-emblem", textAtt: ["+ 15% Damage against Lord and Turtle"]),
            Emblem(name:"Tenacity", image:"tenacity-emblem",textAtt:["+ 15 Hybrid Defense when HP < 50%"]),
            Emblem(name:"Master Assassin",image:"ma-emblem",textAtt:["+ 7% Damage when 1 vs 1"]),
            Emblem(name:"Bargain Hunter",image:"bh-emblem",textAtt:["- 5% Price of Item"]),
            Emblem(name:"Festival of Blood",image:"fob-emblem",textAtt:["+ 6%-10& Spell Vamp"]),
            Emblem(name:"Pull Yourself Together",image:"pyt-emblem",textAtt:["- 15% Cooldown Reduction on Battle Spell"]),
            Emblem(name:"Weapons Master",image:"wm-emblem",textAtt:["+ 5% Attack on All Equipment"])
        ],
        "sub3" : [
            Emblem(name:"Impure Rage",image:"ir-emblem",textAtt:["+ 44-240 Adaptive Damage","restore 2% Mana on hit"]),
            Emblem(name:"Quantum Charge",image:"qc-emblem",textAtt:["+ 30% Movement Speed for 1.5s on hit"]),
            Emblem(name:"Concussive Blast",image:"cb-emblem",textAtt:["dealing 100 + 7% total HP after the next Basic Attack"]),
            Emblem(name:"Killing Spree",image:"ks-emblem",textAtt:["recover 15% losing HP after killing hero","+ 20% Movement Speed after killing hero"]),
            Emblem(name:"Lethal Ignition",image:"li-emblem",textAtt: ["+ 162-750 Adaptive Damage"]),
            Emblem(name:"Brave Smite",image:"bs-emblem",textAtt: ["Recovers 5% of Max HP after dealing Skill damage"]),
            Emblem(name:"Focusing Mark",image:"fm-emblem",textAtt:["Increase 6% damage for Allied Hero"]),
            Emblem(name:"Weakness Finder",image:"wf-emblem",textAtt:["- 50% Movement Speed for 1s","- 30% Attack Speed for 1s"])
        ]
    ]
    var useData:[Emblem] {
        if search != "" {
            return data[currentType]!.filter{
                $0.name.lowercased().contains(search.lowercased())
            }
        }else{
            return data[currentType]!
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading,spacing:20.0){
                HStack{
                    Spacer()
                    VStack(alignment: .leading){
                        HStack{
                            Spacer()
                            if current == nil {
                                CustomCircleComponent(size:50, strokeColor: Color.gray,line:2)
                                VStack(alignment:.leading){
                                    Text("Unselected")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .fontDesign(.rounded)
                                        .padding([.bottom],-8.0)
                                    Text(currentType == "main" ? "Main Emblem":"Sub Emblem")
                                        .font(.caption)
                                        .fontWeight(.light)
                                        .fontDesign(.rounded)
                                }
                            }else{
                                CircleItem(image: data[currentType]![current!].image, size:50, strokeColor: Color.gray)
                                VStack(alignment:.leading){
                                    Text(data[currentType]![current!].name)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .fontDesign(.rounded)
                                        .padding([.bottom],-8.0)
                                    Text(currentType == "main" ? "Main Emblem":"Sub Emblem")
                                        .font(.caption)
                                        .fontWeight(.light)
                                        .fontDesign(.rounded)
                                }
                            }
                            Spacer()
                        }
                        Text("Attribute")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .fontDesign(.rounded)
                        if current == nil {
                            Text("Unselected")
                                .font(.caption)
                                .fontWeight(.light)
                                .fontDesign(.rounded)
                                .padding([.horizontal],4.0)
                        } else {
                            ForEach(data[currentType]![current!].textAtt, id:\.self){text in
                                Text(text)
                                    .font(.caption)
                                    .fontWeight(.light)
                                    .fontDesign(.rounded)
                                    .padding([.horizontal],4.0)
                            }
                        }
                    }
                    Spacer()
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
                HStack{
                    VStack(alignment: .leading){
                        ForEach(0..<((useData.count + 3) / 4), id: \.self) { rowIndex in
                            HStack {
                                Spacer()
                                ForEach(0..<4) { columnIndex in
                                    let emblemIndex = rowIndex * 4 + columnIndex
                                    if emblemIndex < useData.count {
                                        let emblem = useData[emblemIndex]
                                        if search == "" || emblem.name.lowercased().contains(search.lowercased()) {
                                            VStack(alignment:.center) {
                                                if(emblemIndex == current){
                                                    Circle()
                                                        .fill(.clear)
                                                        .frame(width: 60, height: 60)
                                                        .overlay(
                                                            Circle()
                                                                .stroke(Color.blue, lineWidth: 2)
                                                                .frame(width: 60, height: 60)
                                                        )
                                                        .background{
                                                            CircleItem(image:emblem.image, size:50, strokeColor: Color.gray)
                                                        }
                                                }else{
                                                    CircleItem(image:emblem.image, size:50, strokeColor: Color.gray)
                                                }
                                                Text(emblem.name)
                                                    .font(.caption)
                                                    .fontWeight(.medium)
                                                    .fontDesign(.rounded)
                                                    .frame(width:60,height:50,alignment:.center)
                                                    .fixedSize(horizontal:true,vertical:true)
                                                    .truncationMode(.tail)
                                            }.onTapGesture{
                                                current = emblemIndex
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
            }.padding(16.0)
                .navigationTitle("Choose Emblem")
                .searchable(text: $search)
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
                            hero.emblems[currentType] = data[currentType]![chosen!]
                            dismiss()
                        }.disabled(chosen == current)
                        
                    }
                }
        }
    }
}
