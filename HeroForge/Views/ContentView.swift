//
//  ContentView.swift
//  HeroForge
//
//  Created by Christopher Julius on 23/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented = false
    @State private var selectedHeroes:[Hero] = [
        Hero(name:"Unselected",image:"placeholder-attacker"),
        Hero(name:"Unselected",image:"placeholder-defender")
    ]
    @State private var indexHero = 0
    @State var chosen:[Int?] = [nil,nil]
    @State var current:[Int?] = [nil,nil]
    @State var chosenItem:[[Int?]] = [[nil,nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil,nil]]
    @State var currentItem:[[Int?]] = [[nil,nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil,nil]]
    @State var chosenEmblem:[[String:Int?]] = [["main":nil,"sub1":nil,"sub2":nil,"sub3":nil],["main":nil,"sub1":nil,"sub2":nil,"sub3":nil]]
    @State var currentEmblem:[[String:Int?]] = [["main":nil,"sub1":nil,"sub2":nil,"sub3":nil],["main":nil,"sub1":nil,"sub2":nil,"sub3":nil]]
    @State var soundFeature = SoundFeature()
    
    var body: some View {
        NavigationStack{
            GeometryReader{ gp in
                ZStack{
                    VStack(spacing:0) {
                        ZStack{
                            Rectangle()
                                .frame(height: gp.size.height/2)
                                .foregroundStyle(
                                    LinearGradient(gradient: Gradient(colors: [.init(red: 34/255, green: 100/255, blue: 177/255), .clear]), startPoint: .init(x:0.8,y:0.7), endPoint: .top)
                                )
                                .background{
                                    Image(selectedHeroes[0].image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: gp.size.height/2 , alignment: .top)
                                        .clipped()
                                }
                                .onTapGesture{
                                    indexHero = 0
                                    isPresented = true
                                    DispatchQueue.global().async(){
                                        soundFeature.playSound(urlName:"selection")
                                    }
                                }
                            VStack{
                                Spacer()
                                Text("Tap to Customize Attacker")
                                    .font(.callout)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.white,.gray)
                                    .opacity(1.0)
                                Spacer()
                                HStack(alignment:.bottom){
                                    VStack(alignment:.leading,spacing:0){
                                        HStack(alignment:.bottom){
                                            ForEach(["main", "sub1", "sub2", "sub3"], id: \.self) { key in
                                                if(selectedHeroes[0].emblems[key]!.image == "empty"){
                                                    CustomCircleComponent(size:key == "main" ? 36 : 28,strokeColor: Color.white, line: 2)
                                                }else{
                                                    CircleItem(image: selectedHeroes[0].emblems[key]!.image, size: key == "main" ? 36 : 28, strokeColor: Color.white)
                                                }
                                            }
                                        }
                                        Text(selectedHeroes[0].name)
                                            .font(.system(size:40,weight:.heavy,design:.rounded))
                                            .foregroundStyle(.white)
                                        Text("Attacker")
                                            .font(.system(size:20,weight:.medium,design:.rounded))
                                            .foregroundStyle(.white)
                                    }
                                    Spacer()
                                    VStack(alignment:.trailing){
                                        ForEach(0..<2) { row in
                                            HStack(alignment: .bottom) {
                                                ForEach(0..<3) { column in
                                                    let index = row * 3 + column
                                                    if(selectedHeroes[0].items[index].image == "empty"){
                                                        CustomCircleComponent(size:28,strokeColor: Color.white, line: 2)
                                                    }else{
                                                        CircleItem(image: selectedHeroes[0].items[index].image, size:28,
                                                                   strokeColor: Color.white)
                                                    }
                                                    
                                                }
                                            }
                                        }
                                    }
                                }.padding(16.0)
                            }
                        }
                        ZStack{
                            Rectangle()
                                .frame(height: gp.size.height/2)
                                .foregroundStyle(
                                    LinearGradient(gradient: Gradient(colors: [.init(red: 159/255, green: 0, blue: 0), .clear]), startPoint: .init(x:0.2,y:0.2), endPoint: .bottom)
                                )
                                .background{
                                    Image(selectedHeroes[1].image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: gp.size.height/2 , alignment: .top)
                                        .clipped()
                                }
                                .onTapGesture{
                                    indexHero = 1
                                    isPresented = true
                                    DispatchQueue.global().async(){
                                        soundFeature.playSound(urlName:"selection")
                                    }
                                }
                            VStack{
                                HStack(alignment:.top){
                                    VStack(alignment:.leading){
                                        ForEach(0..<2) { row in
                                            HStack(alignment: .bottom) {
                                                ForEach(0..<3) { column in
                                                    let index = row * 3 + column
                                                    if(selectedHeroes[1].items[index].image == "empty"){
                                                        CustomCircleComponent(size:28,strokeColor: Color.white, line: 2)
                                                    }else{
                                                        CircleItem(image: selectedHeroes[1].items[index].image, size:28,
                                                                   strokeColor: Color.white)
                                                    }
                                                    
                                                }
                                            }
                                        }
                                    }
                                    Spacer()
                                    VStack(alignment:.trailing,spacing:0){
                                        Text("Defender")
                                            .font(.system(size:20,weight:.medium,design:.rounded))
                                            .foregroundStyle(.white)
                                        Text(selectedHeroes[1].name)
                                            .font(.system(size:40,weight:.heavy,design:.rounded))
                                            .foregroundStyle(.white)
                                            .padding([.top],-5.0)
                                            .padding([.bottom],5.0)
                                        HStack(alignment:.top){
                                            ForEach(["sub3", "sub2", "sub1", "main"], id: \.self) { key in
                                                if(selectedHeroes[1].emblems[key]!.image == "empty"){
                                                    CustomCircleComponent(size:key == "main" ? 36 : 28,strokeColor: Color.white, line: 2)
                                                }else{
                                                    CircleItem(image: selectedHeroes[1].emblems[key]!.image, size: key == "main" ? 36 : 28, strokeColor: Color.white)
                                                }
                                            }
                                        }
                                        
                                    }
                                }
                                .padding(16.0)
                                Spacer()
                                Text("Tap to Customize Defender")
                                    .font(.callout)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.white,.gray)
                                    .opacity(1.0)
                                Spacer()
                            }
                        }
                    }
                    NavigationLink(destination: ResultView(
                        selectedHeroes: selectedHeroes,
                        chosenItem: chosenItem,
                        currentItem:currentItem,
                        chosenEmblem: chosenEmblem,
                        currentEmblem: currentEmblem
                    ),label:{
                        Image("vs-button")
                            .resizable()
                            .frame(width:gp.size.width/3.5,height:gp.size.width/3.5)
                            .grayscale(chosen[0] == nil || chosen[1] == nil ? 1.0 : 0.0)
                    }).disabled(chosen[0] == nil || chosen[1] == nil)
                }
            }
            .onAppear(){
                DispatchQueue.global().async(){
                    soundFeature.playBGM(urlName:"selection-sound",loop:true)
                }
            }
            .sheet(isPresented: $isPresented){
                MainSheetView(
                    selectedHeroes:$selectedHeroes,
                    indexHero:$indexHero,
                    chosenHero:$chosen[indexHero],
                    currentHero:$current[indexHero],
                    chosenEmblem:$chosenEmblem[indexHero],
                    currentEmblem:$currentEmblem[indexHero],
                    chosenItem:$chosenItem[indexHero],
                    currentItem:$currentItem[indexHero],
                    tempHero:selectedHeroes[indexHero]
                )
                .presentationDetents([.large])
                .presentationBackgroundInteraction(.disabled)
                .presentationBackground(.thinMaterial)
            }
            .ignoresSafeArea()
        }
    }
}

//#Preview {
//    ContentView()
//}
