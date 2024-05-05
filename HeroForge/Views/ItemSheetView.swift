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
        //        Attack
        Item(id:1,name:"Blade of Despair",image:"bod-item",price:3010,textAtt:["+ 160 Physical Attack","+ 5% Movement Speed"],textUn:["increase 25% physical attack when dealing damage to non-minion enemies below 50% HP"],type:.Attack,physicalAtt: 160),
        Item(id:2,name:"Hunter Strike",image:"hs-item",price:2010,textAtt:["+ 80 Physical Attack","+ 10% Cooldown Reduction"],textUn:["+ 15 Physical Penetration","+ 50% Movement Speed for 2s when damage to the same hero 5 times"],type:.Attack,physicalAtt: 80,cooldown: 0.1,fixPhyPen: 15),
        Item(id:3,name:"Great Dragon Spear",image:"gds-item",price:2140,textAtt:["+ 70 Physical Attack","+ 10% Cooldown Reduction","+ 20% Critical Chance"],textUn: ["+ 30% Movement Speed for 7.5s after using ultimate"],type:.Attack,physicalAtt: 70,cooldown: 0.1),
        Item(id:4,name:"Sea Hallberd",image:"sh-item",price:2050,textAtt:["+ 80 Physical Attack","+ 20% Attack Speed"],textUn: ["+ 8% Damage on enemy with Higher extra HP","- 50% shield and HP Regen for 3s"],type:.Attack,physicalAtt: 80),
        Item(id:5,name:"Rose Gold Meteor",image:"rgm-item",price:1820,textAtt:["+ 60 Physical Attack","+ 23 Magic Defense","+ 10% Lifesteal"],textUn: ["when HP below 30% gain 840-1820 shield and 50% movement speed"],type:.Attack,physicalAtt: 60,magDef: 23),
        Item(id:6,name:"Bloodlust Axe",image:"ba-item",price:1970,textAtt:["+ 70 Physical Attack","+ 10% Cooldown Reduction"],textUn: ["+ 20% Spell Vamp"],type:.Attack,physicalAtt: 70,cooldown: 0.1),
        Item(id:7,name:"Blade of Heptaseas",image:"boh-item",price:1950,textAtt:["+ 70 Physical Attack","+ 250 HP"],textUn: ["+ 15 Physical Penetration","+ 160(+40% Total Physical) in the next basic attack if no damage is taken for 5s"],type:.Attack,hp:250,physicalAtt: 70,fixPhyPen: 15),
        Item(id:8,name:"Windtalker",image:"w-item",price:1820,textAtt:["+ 20 Movement Speed","+ 35% Attack Speed","+ 10% Critical Chance"],textUn: ["+ 150-362 Magic Damage up to 3 enemy units","+ 5% Movement Speed"],type:.Attack),
        Item(id:9,name:"Endless blade",image:"eb-item",price:2330,textAtt:["+ 60 Physical Attack","+ 250 HP","+ 10% Cooldown Reduction","+ 8% Hybrid Lifesteal","+ 5% Movement Speed","+ 5 Mana Regen"],textUn: ["+ 60% Physical Attack as True Damage for next Basic Attack after casting a skill","+ 10% Movement Speed"],type:.Attack,hp:250,physicalAtt: 60,cooldown:0.1),
        Item(id:10,name:"Berseker's Fury",image:"bf-item",price:2500,textAtt:["+ 65 Physical Attack","+ 25% Critical Chance"],textUn: ["+ 40% Critical Damage","+ 5% Physical Attack for 2s"],physicalAtt: 65),
        Item(id:11,name:"Haas' Claws",image:"hcs-item",price:2020,textAtt:["+ 30 Physical Attack","+ 15% Attack Speed","+ 20% Critical Chance"],textUn: ["+ 25% Lifesteal","+ 20% Attack Speed after Critical Attack"],type:.Attack,physicalAtt: 30),
        Item(id:12,name:"Malefic Roar",image:"mr-item",price:2060,textAtt:["+ 60 Physical Attack"],textUn: ["+ 20% Physical Penetration","+ 0.125% Extra Physical Penetration for each of Enemy Physical Defense capped at 40%"],type:.Attack,physicalAtt: 60,percPhyPen: 0.2),
        Item(id:13,name:"War Axe",image:"wa-item",price:2100,textAtt:["+ 25 Physical Attack","+550 HP","+ 10% Cooldown Reduction"],textUn: ["+ 12 Physical Attack & 2% spellvamp for 4s after dealing damage up to 6 stacks and giving 10% True Damage at Full Stacks"],type:.Attack,hp:550,physicalAtt: 25,cooldown: 0.1),
        Item(id:14,name:"Wind of Nature",image:"won-item",price:1910,textAtt:["+ 30 Physical Attack","+ 20% Attack Speed","+ 10% Lifesteal"],textUn: ["Immune to all physical damage for 2s at activation"],type:.Attack,physicalAtt: 30),
        Item(id:15,name:"Golden Staff",image:"gs-item",price:2000,textAtt:["+ 55 Physical Attack","+ 15% Attack Speed"],textUn: ["Convert 1% Critical Chance to Attack Speed","+ 80% Attack Speed after 2 non-crit Basic Attack"],type:.Attack,physicalAtt: 55),
        Item(id:16,name:"Corrosion Scythe",image:"cs-item",price:2050,textAtt:["+ 30 Physical Attack","+ 5% Movement Speed","+ 30% Attack Speed"],textUn: ["+ 80 Physical Damage and slow the target 8% after basic attack capped at 5 stacks","Grant 6% attack speed after basic attack capped at 5 stacks"],type:.Attack,physicalAtt: 30),
        Item(id:17,name:"Demon Hunter Sword",image:"dhs-item",price:2180,textAtt:["+ 35 Physical Attack","+ 20% Attack Speed"],textUn: ["deal 8% of target current HP as Physical Damage","3% Lifesteal for 3s after basic attack "],type:.Attack,physicalAtt: 35),
        //        Defense
        Item(id:101,name:"Oracle",image:"ora-item",price:1860,textAtt:["+ 850 HP","+ 20 Magic Defense","+ 20 Physical Defense","+ 10% Cooldown Reduction"],textUn: ["Received shield + HP Regen increased by 30%"],type:.Defense,hp:850,cooldown:0.1,magDef: 20,phyDef: 20),
        Item(id:102,name:"Athena's Shield",image:"as-item",price:2150,textAtt:["+ 900 HP","+ 48 Magic Defense","+ 2 HP Regen"],textUn: ["+ 25% Magic Damage Reduction when hit"],type:.Defense,hp:900,magDef: 48),
        Item(id:103,name:"Brute Force Breastplate",image:"bfb-item",price:1870,textAtt:["+ 600 HP","+ 23 Physical Defense","+ 10% Cooldown"],textUn: ["Gain 6 ectra physical attack and MAgic power for each stack after dealing damage"],type:.Defense,hp:600,cooldown:0.1,phyDef: 23),
        Item(id:104,name:"Blade Armor",image:"bar-item",price:1910,textAtt:["+ 70 Physical Defense"],textUn: ["+ 20% critical damage reduction","Reflect 30% of Physical Damage taken"],type:.Defense,phyDef: 70),
        Item(id:105,name:"Cursed Helmet",image:"ch-item",price:1760,textAtt:["+ 1200 HP","+ 20 Magic Defense"],textUn: ["Deal 1.2% of Max HP as Magic Damage to nearby enemies"],type:.Defense, hp:1200,magDef: 20),
        Item(id:106,name:"Dominance Ice",image:"da-item",price:2010,textAtt:["+ 500 Mana","+ 55 Physical Defense","+ 5% Movement Soeed"],textUn: ["+ 20% Attack Speed Reduction","+ Reduce 50% the shield and HP Regen for 1s"],type:.Defense,phyDef: 55),
        Item(id:107,name:"Immortality",image:"imo-item",price:2120,textAtt:["+ 800 HP","+ 15 Physical Defense"],textUn: ["Revive 2.5s after death with 15% HP and 40% HP Regen for 3s"],type:.Defense,hp:800,phyDef: 15),
        Item(id:108,name:"Radiant Armor",image:"ra-item",price:1880,textAtt:["+ 950 HP","+ 40 Magic Defense","+ 12 HP Regen"],textUn: ["Taking damage get 6-20 Magic Defense for 5s up to 6 stacks"],type:.Defense,hp:950,magDef: 40),
        Item(id:109,name:"Twilight Armor",image:"ta-item",price:2100,textAtt:["+ 1200 HP","+ 15 Physical Defense"],textUn: ["Reduce damage taken to 800 capped + 300 + 15% of max HP"] ,type:.Defense,hp:1200,phyDef:15),
        Item(id:110,name:"Antique Cuiras",image:"ac-item",price:2170,textAtt:["+ 920 HP","+ 40 Physical Defense","+ 4 HP Regen"],textUn: ["Reduce 6% of enemy physical attack for 2s (up to 3 times)"],type:.Defense,hp:920,phyDef:40),
        Item(id:111,name:"Guardian Helmet",image:"gh-item",price:2200,textAtt:["+ 1550 HP","+ 20 HP Regen"],textUn: ["Regen 2.5% of Max HP per second (0.5% when taking damage)"],type:.Defense,hp:1550),
        Item(id:112,name:"Thunder Belt",image:"tb-item",price:1990,textAtt:["+ 800 HP","+ 30 Physical Defense","+ 10% Cooldown Reduction","+ 10 Mana Regen"],textUn:["next basic attack after skill deals additional 50 + 5% of extra HP as True Damage for 1s"],type:.Defense, hp:800, cooldown:0.1, phyDef:30),
        
        //        Magic
        Item(id:201,name:"Flask of The Oasis",image:"foo-item",price:1850,textAtt:["+ 60 Magic Power","+ 300 HP","+ 10% Cooldown Reduction"],textUn:["+ 12 % Healing Effect", "When casting healing will get shield (100 - 1500) if health < 35%"],type:.Magic,hp:300,cooldown:0.1,magPow: 60),
        Item(id:202,name:"Genius Wand",image:"gw-item",price:2000,textAtt:["+ 75 Magic Power","+ 5% Movement Speed"],textUn:["+ 10 Magic Penetration","Dealing Magic damage will reduce magic Defense by 3 - 7 (stack up to 3)"],type:.Magic,magPow:75,fixMagPen: 10),
        Item(id:203,name:"Lightning Truncheon",image:"lt-item",price:2250,textAtt:["+ 70 Magic Power","+ 400 Mana","+ 10% Cooldown Reduction"],textUn:["Every 6s will deal damage equal to 120% of Magic Power"],type:.Magic,cooldown:0.1,magPow: 70),
        Item(id:204,name:"Fleeting Time",image:"ft-item",price:2050,textAtt:["+ 70 Magic Power","+ 300 HP","+ 10% Cooldown Reduction"],textUn:["Hero Kills or Assist will reduct 30% of Ultimate Cooldown"],type:.Magic),
        Item(id:205,name:"Blood Wings",image:"bw-item",price:2100,textAtt:["+ 90 Magic Power"],textUn:["Gain 800 + 100% Magic Pwer as Shield"],type:.Magic,magPow:90),
        Item(id:206,name:"Clock of Destiny",image:"cod-item",price:1950,textAtt:["+ 60 Magic Power","+ 500 HP","+ 600 Mana"],textUn:["Gain 20 extra Max HP and 4 extra magic power every 20s (stack up to 15)","Gains 5% of extra Magic Power and 600 extra Max Mana at max Stack"],type:.Magic,hp:500,magPow:60),
        Item(id:207,name:"Starlium Scythe",image:"ss-item",price:2220,textAtt:["+ 70 Magic Power","+ 10% Cooldown Reduction","+ 8% Hybrid Lifesteal","+ 6 Mana Regen"],textUn:["next basic attack after skill deals additional 100 + 100% Magic Power as True Damage for 1s"],type:.Magic,cooldown:0.1,magPow:70),
        Item(id:208,name:"Glowing Wand",image:"gwand-item",price:1950,textAtt:["+ 75 Magic Power","+ 400 HP","+ 5% Movement Speed"],textUn:["Burn targets for 3s dealing equal 1.5% of target Max HP"],type:.Magic,hp:400,magPow:75),
        Item(id:209,name:"Ice Queen Wand",image:"iqw-item",price:2040,textAtt:["+ 75 Magic Power","+ 10% Spell Vamp","+ 300 HP","+ 7% Movement Speed"],textUn:["When a skills damage will slow enemy for 10% for 2s"],type:.Magic,hp:300,magPow:75),
        Item(id:210,name:"Concentrated Energy",image:"ce-item",price:2020,textAtt:["+ 70 Magic Power","+ 400 HP"],textUn:["+20 % Hybrid Lifesteal","increase magic power by 5 after dealing magic damage (stack up to 6)","when full stack will increase magic damage by 12%"],type:.Magic,hp:400,magPow:70),
        Item(id:211,name:"Holy Crystal",image:"hc-item",price:3000,textAtt:["+ 185 Magic Power"],textUn:["Gain Extra 21% - 35% extra Magic Power by Level"],type:.Magic,magPow:185),
        Item(id:212,name:"Divine Glaive",image:"dg-item",price:1970,textAtt:["+ 60 Magic Power"],textUn:["+ 40% Magic Penetration","Gain 0.1% extra Magic Penetration capped at 20%"],type:.Magic,magPow:60,perMagPen:0.4),
        Item(id:213,name:"Necklace of Durance",image:"nod-item",price:2010,textAtt:["+ 60 Magic Power","+ 300 HP","+ 380 Mana","+ 5% Cooldown Reduction"],textUn:["Regenerate 20% of Max HP and mana over 2s after leveling up","Dealing damage to enemy will reduce 50% of regen effect for 3s"],type:.Magic,hp:300,cooldown:0.05,magPow:60),
        Item(id:214,name:"Feather of Heaven",image:"foh-item",price:2030,textAtt:["+ 55 Magic Power","+ 20% Attack Speed","+ 10% Lifesteal","+ 5% Cooldown Reduction"],textUn:["Basic attack deals 50 + 30% of magic power"],type:.Magic,cooldown:0.05,magPow:55),
        Item(id:215,name:"Winter Truncheon",image:"wt-item",price:1910,textAtt:["+ 60 Magic Power","+ 20 Physical Defense","+ 400 HP"],textUn:["unable to move and immune to all damage for 2s"],type:.Magic,hp:400,magPow: 60,phyDef:20),
        Item(id:216,name:"Enchanted Talisman",image:"et-item",price:1870,textAtt:["+ 50 Magic Power","+ 250 HP","+ 20% Cooldown Reduction"],textUn:["Regenerate 15% mana every 10s","Max Cooldown reduction + 5%"],type:.Magic,hp:250,cooldown:0.2,magPow:50)
    ]
    @State var name:String = ""
    @State private var filter:TypeItem = .All
    @State private var soundFeature = SoundFeature()
    var useData:[Item] {
        if name != "" {
            if filter == .All{
                return data.filter{
                    $0.name.lowercased().contains(name.lowercased())
                }
            }else {
                return data.filter{
                    $0.name.lowercased().contains(name.lowercased()) &&
                    $0.type == filter
                }
            }
        }else{
            if filter == .All {
                return data
            } else {
                return data.filter{
                    $0.type == filter
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading,spacing:20.0){
                HStack{
                    Spacer()
                    Picker("Filter",selection: $filter){
                        ForEach(TypeItem.allCases,id:\.self){ typeItem in
                            Text(typeItem.description).tag(typeItem)
                        }
                    }.pickerStyle(MenuPickerStyle())
                }.padding(.vertical,-10.0)
                HStack{
                    Spacer()
                    VStack(alignment: .leading){
                        HStack{
                            Spacer()
                            if current != nil {
                                CircleItem(image: data.first(where: { $0.id == current })!.image, size:50, strokeColor: Color.gray)
                                VStack(alignment:.leading){
                                    Text(data.first(where: { $0.id == current })!.name)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .fontDesign(.rounded)
                                        .padding([.bottom],-8.0)
                                    Text(data.first(where: { $0.id == current })!.type.rawValue)
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
                            ForEach(data.first(where: { $0.id == current })!.textAtt, id:\.self){text in
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
                            ForEach(data.first(where: { $0.id == current })!.textUn, id:\.self){text in
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
                        let items:[Item] = useData // Your data array
                        let itemsPerVStack:Int = (items.count + 1) / 2 // Calculate the number of items per VStack
                        let numberOfItems = items.count // Total number of items
                        Spacer()
                        VStack(alignment:.leading) {
                            ForEach(0..<itemsPerVStack, id:\.self) { itemIndex in
                                HStack(alignment:.center){
                                    if current == items[itemIndex].id {
                                        Circle()
                                            .fill(.clear)
                                            .frame(width: 50, height: 50)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.blue, lineWidth: 2)
                                                    .frame(width: 50, height: 50)
                                            )
                                            .background{
                                                CircleItem(image:items[itemIndex].image, size:40, strokeColor: Color.gray)
                                            }
                                    }else{
                                        CircleItem(image:items[itemIndex].image, size:40, strokeColor: Color.gray)
                                    }
                                    VStack(alignment:.leading){
                                        Text(items[itemIndex].name)
                                            .fontWeight(.semibold)
                                            .font(.caption)
                                            .fontDesign(.rounded)
                                        
                                        Text("\(items[itemIndex].price)")
                                            .fontWeight(.light)
                                            .font(.caption)
                                            .fontDesign(.rounded)
                                    }
                                }.onTapGesture {
                                    current = items[itemIndex].id
                                    DispatchQueue.global().async(){
                                        soundFeature.playSound(urlName:"selection")
                                    }
                                }
                            }
                        }
                        .padding()
                        Spacer()
                        VStack(alignment: .leading) {
                            ForEach(itemsPerVStack..<numberOfItems, id:\.self) { itemIndex in
                                HStack(alignment:.center){
                                    if current == items[itemIndex].id {
                                        Circle()
                                            .fill(.clear)
                                            .frame(width: 50, height: 50)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.blue, lineWidth: 2)
                                                    .frame(width: 50, height: 50)
                                            )
                                            .background{
                                                CircleItem(image:items[itemIndex].image, size:40, strokeColor: Color.gray)
                                            }
                                    }else{
                                        CircleItem(image:items[itemIndex].image, size:40, strokeColor: Color.gray)
                                    }
                                    VStack(alignment:.leading){
                                        Text(items[itemIndex].name)
                                            .fontWeight(.semibold)
                                            .font(.caption)
                                            .fontDesign(.rounded)
                                        
                                        Text("\(items[itemIndex].price)")
                                            .fontWeight(.light)
                                            .font(.caption)
                                            .fontDesign(.rounded)
                                    }
                                }.onTapGesture {
                                    current = items[itemIndex].id
                                    DispatchQueue.global().async(){
                                        soundFeature.playSound(urlName:"selection")
                                    }
                                }
                            }
                        }
                        .padding()
                        Spacer()
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
                .searchable(text:$name)
                .onAppear(){
                    current = chosen
                }
                .toolbar{
                    ToolbarItem(placement: .cancellationAction){
                        Button("Cancel"){
                            DispatchQueue.global().async(){
                                soundFeature.playSound(urlName:"close")
                            }
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction){
                        Button("Save"){
                            if chosen != nil {
                                hero.unequipItem(item: data.first(where: {$0.id == chosen})!, slot: index)
                            }
                            chosen = current
                            hero.equipItem(item:data.first(where: {$0.id == chosen})!,slot:index)
                            DispatchQueue.global().async(){
                                soundFeature.playSound(urlName:"selection")
                            }
                            dismiss()
                        }.disabled(chosen == current)
                    }
                }
        }
    }
}
