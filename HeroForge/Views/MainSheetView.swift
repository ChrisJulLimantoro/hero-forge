//
//  MainSheetView.swift
//  HeroForge
//
//  Created by Christopher Julius on 26/04/24.
//

import SwiftUI
import Foundation


struct MainSheetView:View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedHeroes:[Hero]
    @Binding var indexHero:Int
    @Binding var chosenHero:Int?
    @Binding var currentHero:Int?
    @Binding var chosenEmblem:[String:Int?]
    @Binding var currentEmblem:[String:Int?]
    @Binding var chosenItem:[Int?]
    @Binding var currentItem:[Int?]
    @State private var isPresented = false
    @State private var typePresented = 0
    @State private var soundFeature = SoundFeature()
    @State var tempHero:Hero
    @State var emblemType = ""
    @State var itemIndex = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Section{
                    VStack(alignment:.leading){
                        Text("Hero")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .fontDesign(.rounded)
                            .padding([.bottom],-4.0)
                        HStack{
                            if tempHero.avatar == "" {
                                CustomCircleComponent(size:50,strokeColor: Color.gray, line: 2)
                            }else {
                                CircleItem(image:tempHero.avatar, size:50, strokeColor: Color.gray)
                            }
                            VStack(alignment:.leading){
                                Text(tempHero.name).fontWeight(.medium).fontDesign(.rounded)
                                Text(tempHero.role).fontWeight(.light).font(.caption).fontDesign(.rounded)
                            }
                            .frame(maxWidth:.infinity, alignment: .leading)
                            Spacer()
                            Text("Choose Hero >")
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .fontDesign(.rounded)
                        }.onTapGesture {
                            typePresented = 0
                            isPresented = true
                            DispatchQueue.global().async(){
                                soundFeature.playSound(urlName:"selection")
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
                    }
                    .padding([.horizontal],16.0)
                }.padding([.vertical],12.0)
                
                Section{
                    VStack(alignment:.leading){
                        Text("Emblems")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .fontDesign(.rounded)
                            .padding([.bottom],-4.0)
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
                    }
                    .padding([.horizontal],16.0)
                }.padding([.vertical],12.0)
                Section{
                    VStack(alignment:.leading){
                        Text("Items")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding([.bottom],-4.0)
                            .fontDesign(.rounded)
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
                    }
                    .padding([.horizontal],16.0)
                }
                Spacer()
            }
            .navigationTitle(indexHero == 0 ? "Attacker" : "Defender")
            .navigationBarTitleDisplayMode(.inline)
            .presentationCornerRadius(8.0)
            .presentationDragIndicator(Visibility.automatic)
            .toolbar{
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        tempHero = selectedHeroes[indexHero]
                        currentHero = chosenHero
                        currentItem = chosenItem
                        currentEmblem = chosenEmblem
                        DispatchQueue.global().async(){
                            soundFeature.playSound(urlName:"close")
                        }
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        selectedHeroes[indexHero] = tempHero
                        chosenHero = currentHero
                        chosenItem = currentItem
                        chosenEmblem = currentEmblem
                        DispatchQueue.global().async(){
                            soundFeature.playSound(urlName:"selection")
                        }
                        dismiss()
                    }.disabled((chosenHero == currentHero && chosenItem == currentItem && chosenEmblem == currentEmblem) || currentHero == nil)
                }
            }
            .sheet(isPresented: $isPresented) {
                if typePresented == 0 {
                    HeroSheetView(hero: $tempHero, current: $currentHero, chosen: chosenHero)
                        .presentationDetents([.large])
                        .presentationBackgroundInteraction(.disabled)
                        .presentationBackground(.thinMaterial)
                }else if typePresented == 1{
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
            print(indexHero)
        }
    }
}
