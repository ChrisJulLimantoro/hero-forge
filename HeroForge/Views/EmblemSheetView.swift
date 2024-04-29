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
    @State var chosen:Int? = nil
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
        "sub1" : [Emblem(),Emblem()],
        "sub2" : [Emblem(),Emblem()],
        "sub3" : [Emblem(),Emblem()]
    ]
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading,spacing:20.0){
                HStack{
                    Spacer()
                    VStack(alignment: .leading){
                        HStack{
                            Spacer()
                            if chosen == nil {
                                CircleItem(image: "empty", size:50, strokeColor: Color.gray)
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
                                CircleItem(image: data[currentType]![chosen!].image, size:50, strokeColor: Color.gray)
                                VStack(alignment:.leading){
                                    Text(data[currentType]![chosen!].name)
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
                        if chosen == nil {
                            Text("Unselected")
                                .font(.caption)
                                .fontWeight(.light)
                                .fontDesign(.rounded)
                                .padding([.horizontal],4.0)
                        } else {
                            ForEach(data[currentType]![chosen!].textAtt, id:\.self){text in
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
                        ForEach(0..<((data[currentType]!.count + 3) / 4), id: \.self) { rowIndex in
                            HStack {
                                Spacer()
                                ForEach(0..<4) { columnIndex in
                                    let emblemIndex = rowIndex * 4 + columnIndex
                                    if emblemIndex < data[currentType]!.count {
                                        let emblem = data[currentType]![emblemIndex]
                                        if search == "" || emblem.name.lowercased().contains(search.lowercased()) {
                                            VStack(alignment:.center) {
                                                if(emblemIndex == chosen){
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
                                            }.onTapGesture{
                                                chosen = emblemIndex
                                            }
                                            Spacer()
                                        } else {
                                            //                                            Rectangle()
                                            //                                                .frame(width:60,height:60)
                                            //                                                .fill(.clear)
                                            Spacer()
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
                            hero.emblems[currentType] = data[currentType]![chosen!]
                            dismiss()
                        }.disabled(chosen == nil)
                        
                    }
                }
        }
    }
}
