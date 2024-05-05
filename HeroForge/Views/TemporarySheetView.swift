//
//  TemporarySheetView.swift
//  HeroForge
//
//  Created by Christopher Julius on 01/05/24.
//

import Foundation
import SwiftUI

struct TemporarySheetView:View {
    @Environment (\.dismiss) var dismiss
    @Binding var selectedHeroes:[Hero]
    @Binding var indexHero:Int
    @Binding var chosenEmblem:[String:Int?]
    @Binding var currentEmblem:[String:Int?]
    @Binding var chosenItem:[Int?]
    @Binding var currentItem:[Int?]
    @State var tempHero:Hero
    @State private var isPresented:Bool = false
    @State var typePresented = 0
    @State var emblemType = ""
    @State var itemIndex:Int = 0
    @State var soundFeature = SoundFeature()
        
    var body: some View {
        NavigationStack{
            VStack(){
                HStack(alignment:.center){
                    Spacer()
                    VStack{
                        ZStack{
                            CircleItem(image:tempHero.avatar, size:70, strokeColor: Color.gray)
                            Image(systemName: "info.circle.fill")
                                .foregroundStyle(.white)
                                .font(.headline)
                                .offset(x:20,y:20)
                        }
                        Text(tempHero.name).fontWeight(.bold).font(.title).fontDesign(.rounded)
                        Text(indexHero == 0 ? "Attacker":"Defender").font(.callout).fontDesign(.rounded)
                    }
                    Spacer()
                }.onTapGesture {
                    
                }
                .padding(16.0)
                HStack{
                    VStack{
                        if tempHero.emblems["main"]!.image == "empty" {
                            CustomCircleComponent(size:60,strokeColor: Color.gray, line: 2)
                        }else {
                            CircleItem(image:tempHero.emblems["main"]!.image, size:60, strokeColor: Color.gray)
                        }
                        Text(tempHero.emblems["main"]!.name == "" ? "Unselected" : tempHero.emblems["main"]!.name).fontWeight(.semibold).font(.caption).fontDesign(.rounded)
                        Text("main emblem").fontWeight(.light).font(.caption).foregroundStyle(.gray).fontDesign(.rounded)
                    }.onTapGesture{
                        typePresented = 1
                        emblemType = "main"
                        isPresented = true
                        DispatchQueue.global().async(){
                            soundFeature.playSound(urlName:"selection")
                        }
                    }
                    Spacer()
                    HStack{
                        VStack{
                            if tempHero.emblems["sub1"]!.image == "empty" {
                                CustomCircleComponent(size:50,strokeColor: Color.gray, line: 2)
                            }else {
                                CircleItem(image:tempHero.emblems["sub1"]!.image, size:50, strokeColor: Color.gray)
                            }
                            Text(tempHero.emblems["sub1"]!.name == "" ? "Unselected" : tempHero.emblems["sub1"]!.name).fontWeight(.semibold).font(.caption2).fontDesign(.rounded).frame(width:60,height:30)
                            Text("sub-emblem").fontWeight(.light).font(.caption).foregroundStyle(.gray).fontDesign(.rounded)
                        }
                        .onTapGesture{
                            typePresented = 1
                            emblemType = "sub1"
                            isPresented = true
                            DispatchQueue.global().async(){
                                soundFeature.playSound(urlName:"selection")
                            }
                        }
                        VStack{
                            if tempHero.emblems["sub2"]!.image == "empty" {
                                CustomCircleComponent(size:50,strokeColor: Color.gray, line: 2)
                            }else {
                                CircleItem(image:tempHero.emblems["sub2"]!.image, size:50, strokeColor: Color.gray)
                            }
                            Text(tempHero.emblems["sub2"]!.name == "" ? "Unselected" : tempHero.emblems["sub2"]!.name).fontWeight(.semibold).font(.caption2).fontDesign(.rounded).frame(width:60,height:30)
                            Text("sub-emblem").fontWeight(.light).font(.caption).foregroundStyle(.gray).fontDesign(.rounded)
                        }
                        .onTapGesture{
                            typePresented = 1
                            emblemType = "sub2"
                            isPresented = true
                            DispatchQueue.global().async(){
                                soundFeature.playSound(urlName:"selection")
                            }
                        }
                        VStack{
                            if tempHero.emblems["sub3"]!.image == "empty" {
                                CustomCircleComponent(size:50,strokeColor: Color.gray, line: 2)
                            }else {
                                CircleItem(image:tempHero.emblems["sub3"]!.image, size:50, strokeColor: Color.gray)
                            }
                            Text(tempHero.emblems["sub3"]!.name == "" ? "Unselected" : tempHero.emblems["sub3"]!.name).fontWeight(.semibold).font(.caption2).fontDesign(.rounded).frame(width:60,height:30)
                            Text("sub-emblem").fontWeight(.light).font(.caption).foregroundStyle(.gray).fontDesign(.rounded)
                        }
                        .onTapGesture{
                            typePresented = 1
                            emblemType = "sub3"
                            isPresented = true
                            DispatchQueue.global().async(){
                                soundFeature.playSound(urlName:"selection")
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
                HStack{
                    VStack(alignment:.leading){
                        ForEach (0..<3) {index in
                            ItemTile(isPresented:$isPresented,
                                     typePresented:$typePresented,
                                     items:$tempHero.items,current:$itemIndex,
                                     itemIndex:index)
                        }
                    }
                    Spacer()
                    VStack(alignment:.leading){
                        ForEach (3..<6) {index in
                            ItemTile(isPresented:$isPresented,
                                     typePresented:$typePresented,
                                     items:$tempHero.items,current:$itemIndex,
                                     itemIndex:index)
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
                Spacer()
            }.padding(.horizontal,16.0)
                .navigationTitle("Quick Access")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .cancellationAction){
                        Button("Cancel"){
                            tempHero = selectedHeroes[indexHero]
                            currentItem = chosenItem
                            currentEmblem = chosenEmblem
                            DispatchQueue.global().async(){
                                soundFeature.playSound(urlName:"close")
                            }
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction){
                        Button("Save"){
                            selectedHeroes[indexHero] = tempHero
                            chosenItem = currentItem
                            chosenEmblem = currentEmblem
                            DispatchQueue.global().async(){
                                soundFeature.playSound(urlName:"selection")
                            }
                            dismiss()
                        }
                    }
                }
                .sheet(isPresented:$isPresented){
                    if typePresented == 1{
                        EmblemSheetView(
                            currentType: emblemType,
                            chosen: Binding<Int?>(
                                get: { currentEmblem[emblemType]! },
                                set: { currentEmblem[emblemType] = $0 }
                            ),
                            current: currentEmblem[emblemType] ?? nil,
                            hero: $tempHero
                        )
                        .presentationDetents([.large])
                        .presentationBackgroundInteraction(.disabled)
                        .presentationBackground(.thinMaterial)
                    }else if typePresented == 2{
                        ItemSheetView(current:currentItem[itemIndex],chosen:$currentItem[itemIndex], hero:$tempHero, index:itemIndex)
                            .presentationDetents([.large])
                            .presentationBackgroundInteraction(.disabled)
                            .presentationBackground(.thinMaterial)
                    }
                }
        }.onAppear {
            tempHero = selectedHeroes[indexHero]
            
        }
    }
}
