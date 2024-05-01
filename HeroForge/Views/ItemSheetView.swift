//
//  ItemSheetView.swift
//  HeroForge
//
//  Created by Christopher Julius on 26/04/24.
//

import Foundation
import SwiftUI

struct ItemSheetView: View {
    @Environment(\.dismiss) var dismiss
    @State var current:Int?
    @Binding var chosen:Int?
    @Binding var hero:Hero
    @State var index:Int
    var data:[Item] = [
        Item(name:"Blade of Despair",image:"bod-item",price:3010,textAtt:["+ 160 Physical Attack","+ 5% Movement Speed"],textUn:["increase 25% physical attack when dealing damage to non-minion enemies below 50% HP"],type:.Attack),
        Item(name:"Hunter Strike",image:"hs-item",price:2010,textAtt:["+ 80 Physical Attack","+ 10% Cooldown Reduction"],textUn:["+ 15 Physical Penetration","+ 50% Movement Speed for 2s when damage to the same hero 5 times"],type:.Attack),
        Item(name:"Great Dragon Spear",image:"gds-item",price:2140,textAtt:["+ 70 Physical Attack","+ 10% Cooldown Reduction","+ 20% Critical Chance"],textUn: ["+ 30% Movement Speed for 7.5s after using ultimate"],type:.Attack),
        Item(name:"Sea Hallberd",image:"sh-item",price:2050,textAtt:["+ 80 Physical Attack","+ 20% Attack Speed"],textUn: ["+ 8% Damage on enemy with Higher extra HP","- 50% shield and HP Regen for 3s"],type:.Attack),
        Item(name:"Rose Gold Meteor",image:"rgm-item",price:1820,textAtt:["+ 60 Physical Attack","+ 23 Magic Defense","+ 10% Lifesteal"],textUn: ["when HP below 30% gain 840-1820 shield and 50% movement speed"],type:.Attack),
        Item(name:"Bloodlust Axe",image:"ba-item",price:1970,textAtt:["+ 70 Physical Attack","+ 10% Cooldown Reduction"],textUn: ["+ 20% Spell Vamp"],type:.Attack),
        Item(name:"Blade of Heptaseas",image:"boh-item",price:1950,textAtt:["+ 70 Physical Attack","+ 250 HP"],textUn: ["+ 15 Physical Penetration","+ 160(+40% Total Physical) in the next basic attack if no damage is taken for 5s"],type:.Attack),
        Item(name:"Windtalker",image:"w-item",price:1820,textAtt:["+ 20 Movement Speed","+ 35% Attack Speed","+ 10% Critical Chance"],textUn: ["+ 150-362 Magic Damage up to 3 enemy units","+ 5% Movement Speed"],type:.Attack),
        Item(name:"Endless blade",image:"eb-item",price:2330,textAtt:["+ 60 Physical Attack","+ 250 HP","+ 10% Cooldown Reduction","+ 8% Hybrid Lifesteal","+ 5% Movement Speed","+ 5 Mana Regen"],textUn: ["+ 60% Physical Attack as True Damage for next Basic Attack after casting a skill","+ 10% Movement Speed"],type:.Attack),
        Item(name:"Berseker's Fury",image:"bf-item",price:2500,textAtt:["+ 65 Physical Attack","+ 25% Critical Chance"],textUn: ["+ 40% Critical Damage","+ 5% Physical Attack for 2s"]),
        Item(name:"Haas' Claws",image:"hc-item",price:2020,textAtt:["+ 30 Physical Attack","+ 15% Attack Speed","+ 20% Critical Chance"],textUn: ["+ 25% Lifesteal","+ 20% Attack Speed after Critical Attack"],type:.Attack),
        Item(name:"Malefic Roar",image:"mr-item",price:2060,textAtt:["+ 60 Physical Attack"],textUn: ["+ 20% Physical Penetration","+ 0.125% Extra Physical Penetration for each of Enemy Physical Defense capped at 40%"],type:.Attack),
        Item(name:"War Axe",image:"wa-item",price:2100,textAtt:["+ 25 Physical Attack","+550 HP","+ 10% Cooldown Reduction"],textUn: ["+ 12 Physical Attack & 2% spellvamp for 4s after dealing damage up to 6 stacks and giving 10% True Damage at Full Stacks"],type:.Attack),
        Item(name:"Wind of Nature",image:"won-item",price:1910,textAtt:["+ 30 Physical Attack","+ 20% Attack Speed","+ 10% Lifesteal"],textUn: ["Immune to all physical damage for 2s at activation"],type:.Attack),
        Item(name:"Golden Staff",image:"gs-item",price:2000,textAtt:["+ 55 Physical Attack","+ 15% Attack Speed"],textUn: ["Convert 1% Critical Chance to Attack Speed","+ 80% Attack Speed after 2 non-crit Basic Attack"],type:.Attack),
        Item(name:"Corrosion Scythe",image:"cs-item",price:2050,textAtt:["+ 30 Physical Attack","+ 5% Movement Speed","+ 30% Attack Speed"],textUn: ["+ 80 Physical Damage and slow the target 8% after basic attack capped at 5 stacks","Grant 6% attack speed after basic attack capped at 5 stacks"],type:.Attack),
        Item(name:"Demon Hunter Sword",image:"dhs-item",price:2180,textAtt:["+ 35 Physical Attack","+ 20% Attack Speed"],textUn: ["deal 8% of target current HP as Physical Damage","3% Lifesteal for 3s after basic attack "],type:.Attack),
    ]
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading,spacing:20.0){
                HStack{
                    Spacer()
                    VStack(alignment: .leading){
                        HStack{
                            Spacer()
                            if current != nil {
                                CircleItem(image: data[current!].image, size:50, strokeColor: Color.gray)
                                VStack(alignment:.leading){
                                    Text(data[current!].name)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .fontDesign(.rounded)
                                        .padding([.bottom],-8.0)
                                    Text(data[current!].type.rawValue)
                                        .font(.caption)
                                        .fontWeight(.light)
                                        .fontDesign(.rounded)
                                }
                            }else{
                                CustomCircleComponent(size:50, strokeColor: Color.gray,line:2)
                                VStack(alignment:.leading){
                                    Text("Unselected")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .fontDesign(.rounded)
                                        .padding([.bottom],-8.0)
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
                            ForEach(data[current!].textAtt, id:\.self){text in
                                Text(text)
                                    .font(.caption)
                                    .fontWeight(.light)
                                    .fontDesign(.rounded)
                                    .padding([.horizontal],4.0)
                            }
                        }
                        Text("Unique Attribute")
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
                            ForEach(data[current!].textUn, id:\.self){text in
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
                ScrollView{
                HStack(alignment:.top){
                    let items:[Item] = data // Your data array
                    let itemsPerVStack:Int = (items.count + 1) / 2 // Calculate the number of items per VStack
                    let numberOfItems = items.count // Total number of items
                    
                        VStack(alignment:.leading) {
                            ForEach(0..<itemsPerVStack, id:\.self) { itemIndex in
                                HStack(alignment:.center){
                                    if current == itemIndex {
                                        Circle()
                                            .fill(.clear)
                                            .frame(width: 50, height: 50)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.blue, lineWidth: 2)
                                                    .frame(width: 50, height: 50)
                                            )
                                            .background{
                                                CircleItem(image:data[itemIndex].image, size:40, strokeColor: Color.gray)
                                            }
                                    }else{
                                        CircleItem(image:data[itemIndex].image, size:40, strokeColor: Color.gray)
                                    }
                                    VStack(alignment:.leading){
                                        Text(data[itemIndex].name)
                                            .fontWeight(.semibold)
                                            .font(.caption)
                                            .fontDesign(.rounded)
                                        
                                        Text("\(data[itemIndex].price)")
                                            .fontWeight(.light)
                                            .font(.caption)
                                            .fontDesign(.rounded)
                                    }
                                }.onTapGesture {
                                    current = itemIndex
                                }
                            }
                        }
                        .padding()
                        
                        VStack(alignment: .leading) {
                            ForEach(itemsPerVStack..<numberOfItems, id:\.self) { itemIndex in
                                HStack(alignment:.center){
                                    if current == itemIndex {
                                        Circle()
                                            .fill(.clear)
                                            .frame(width: 50, height: 50)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.blue, lineWidth: 2)
                                                    .frame(width: 50, height: 50)
                                            )
                                            .background{
                                                CircleItem(image:data[itemIndex].image, size:40, strokeColor: Color.gray)
                                            }
                                    }else{
                                        CircleItem(image:data[itemIndex].image, size:40, strokeColor: Color.gray)
                                    }
                                    VStack(alignment:.leading){
                                        Text(data[itemIndex].name)
                                            .fontWeight(.semibold)
                                            .font(.caption)
                                            .fontDesign(.rounded)
                                        
                                        Text("\(data[itemIndex].price)")
                                            .fontWeight(.light)
                                            .font(.caption)
                                            .fontDesign(.rounded)
                                    }
                                }.onTapGesture {
                                    current = itemIndex
                                }
                            }
                        }
                        .padding()
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
                .navigationTitle("Choose Item")
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
                            hero.items[index] = data[chosen!]
                            dismiss()
                        }.disabled(chosen == current)
                    }
                }
        }
    }
}
