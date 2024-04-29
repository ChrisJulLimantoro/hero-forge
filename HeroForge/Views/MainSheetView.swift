//
//  MainSheetView.swift
//  HeroForge
//
//  Created by Christopher Julius on 26/04/24.
//

import SwiftUI
import Foundation


struct MainSheetView:View {
    @Binding var selectedHeroes:[Hero]
    @Binding var indexHero:Int
    @Binding var chosenHero:Int?
    @Environment(\.dismiss) var dismiss
    @State private var isPresented = false
    @State private var typePresented = 0
    @State private var items = [Item?](repeating: nil, count: 6)
    @State var tempHero:Hero
    
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
                                CircleItem(image:"empty", size:50, strokeColor: Color.gray)
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
                            isPresented = true
                            typePresented = 0
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
                                if tempHero.emblems["main"]!.image == "" {
                                    CircleItem(image:"default", size:60, strokeColor: Color.gray)
                                }else {
                                    CircleItem(image:tempHero.emblems["main"]!.image, size:60, strokeColor: Color.gray)
                                }
                                Text("Unselected").fontWeight(.semibold).font(.caption).fontDesign(.rounded)
                                Text("main emblem").fontWeight(.light).font(.caption).foregroundStyle(.gray).fontDesign(.rounded)
                            }.onTapGesture{
                                isPresented = true
                                typePresented = 1
                            }
                            Spacer()
                            HStack{
                                VStack{
                                    if tempHero.emblems["sub1"]!.image == "" {
                                        CircleItem(image:"default", size:50, strokeColor: Color.gray)
                                    }else {
                                        CircleItem(image:tempHero.emblems["sub1"]!.image, size:50, strokeColor: Color.gray)
                                    }
                                    Text("Unselected").fontWeight(.semibold).font(.caption).fontDesign(.rounded)
                                    Text("sub-emblem").fontWeight(.light).font(.caption).foregroundStyle(.gray).fontDesign(.rounded)
                                }
                                .onTapGesture{
                                    isPresented = true
                                    typePresented = 1
                                }
                                VStack{
                                    if tempHero.emblems["sub2"]!.image == "" {
                                        CircleItem(image:"default", size:50, strokeColor: Color.gray)
                                    }else {
                                        CircleItem(image:tempHero.emblems["sub2"]!.image, size:50, strokeColor: Color.gray)
                                    }
                                    Text("Unselected").fontWeight(.semibold).font(.caption2).fontDesign(.rounded)
                                    Text("sub-emblem").fontWeight(.light).font(.caption).foregroundStyle(.gray).fontDesign(.rounded)
                                }
                                .onTapGesture{
                                    isPresented = true
                                    typePresented = 1
                                }
                                VStack{
                                    if tempHero.emblems["sub3"]!.image == "" {
                                        CircleItem(image:"default", size:50, strokeColor: Color.gray)
                                    }else {
                                        CircleItem(image:tempHero.emblems["sub3"]!.image, size:50, strokeColor: Color.gray)
                                    }
                                    Text("Unselected").fontWeight(.semibold).font(.caption).fontDesign(.rounded)
                                    Text("sub-emblem").fontWeight(.light).font(.caption).foregroundStyle(.gray).fontDesign(.rounded)
                                }
                                .onTapGesture{
                                    isPresented = true
                                    typePresented = 1
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
                            VStack{
                                ForEach (0..<3) {index in
                                    ItemTile(isPresented:$isPresented,
                                             typePresented:$typePresented,
                                             items:$tempHero.items,
                                             itemIndex:index)
                                }
                            }
                            Spacer()
                            VStack(alignment:.leading){
                                ForEach (3..<6) {index in
                                    ItemTile(isPresented:$isPresented,
                                             typePresented:$typePresented,
                                             items:$tempHero.items,
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
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        selectedHeroes[indexHero] = tempHero
                        dismiss()
                    }.disabled(chosenHero == nil)
                }
            }
            .sheet(isPresented: $isPresented) {
                if typePresented == 0 {
                    HeroSheetView(hero: $tempHero,chosen: $chosenHero, current: chosenHero)
                        .presentationDetents([.large])
                        .presentationBackgroundInteraction(.disabled)
                        .presentationBackground(.thinMaterial)
                }else if typePresented == 1{
                    EmblemSheetView(currentType:"main",hero: $tempHero)
                        .presentationDetents([.large])
                        .presentationBackgroundInteraction(.disabled)
                        .presentationBackground(.thinMaterial)
                }else if typePresented == 2{
                    ItemSheetView()
                        .presentationDetents([.large])
                        .presentationBackgroundInteraction(.disabled)
                        .presentationBackground(.thinMaterial)
                }
            }
            
        }
    }
}
