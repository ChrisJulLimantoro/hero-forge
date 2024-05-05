//
//  ResultView.swift
//  HeroForge
//
//  Created by Christopher Julius on 30/04/24.
//

import Foundation
import SwiftUI
import UIKit

struct ResultView:View{
    @State var selectedHeroes:[Hero]
    @State var isAlive = true
    @State var isLeveling = true
    @State var isAttack = false
    @State var isSlashing = false
    @State var soundFeature = SoundFeature()
    @State var cooldown:[Double] = [0.0,0.0,0.0]
    @State var isPresented:Bool = false
    @State var numberHero:Int = 0
    @State var chosenItem:[[Int?]] = [[nil,nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil,nil]]
    @State var currentItem:[[Int?]] = [[nil,nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil,nil]]
    @State var chosenEmblem:[[String:Int?]] = [["main":nil,"sub1":nil,"sub2":nil,"sub3":nil],["main":nil,"sub1":nil,"sub2":nil,"sub3":nil]]
    @State var currentEmblem:[[String:Int?]] = [["main":nil,"sub1":nil,"sub2":nil,"sub3":nil],["main":nil,"sub1":nil,"sub2":nil,"sub3":nil]]
    @GestureState private var tapGestureState = false
    @State var isBasic = true
    @State var damage:[Double] = []
    @State var offsetX:[Double] = []
    @State var offsetY:[Double] = []
    
    var body: some View{
        NavigationStack{
            GeometryReader{gp in
                ZStack{
                    Rectangle()
                        .frame(width:gp.size.width,height: gp.size.height)
                        .foregroundStyle(
                            LinearGradient(gradient: Gradient(colors: [.init(red: 159/255, green: 0, blue: 0), .clear]), startPoint: .init(x:0.5,y:0.55), endPoint: .top)
                        )
                        .background{
                            Image(selectedHeroes[1].image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: gp.size.height/0.9 , alignment: .top)
                                .clipped()
                        }
                        .offset(x:isAttack ? CGFloat.random(in: -10...10) : 0, y:0)
                        .animation(.default.repeatCount(5).speed(5),value:isAttack)
                    ForEach(damage.indices, id:\.self){index in
                        Text(String(format: "%.2f", self.damage[index]))
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .offset(x:offsetX[index],y:offsetY[index])
                            .opacity(1+(offsetY[index]/250))
                    }
                    VStack{
                        Rectangle()
                            .fill(.clear)
                            .frame(height:gp.size.height*0.29)
                        HStack{
                            Spacer()
                            Text("-")
                                .font(.title)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundStyle(.white)
                                .background(
                                    CustomCircleComponent(size:30,strokeColor:Color.white,line:2)
                                )
                                .onTapGesture{
                                    isLeveling = selectedHeroes[1].levelDown()
                                    DispatchQueue.global().async(){
                                        soundFeature.playSound(urlName:"skill-up")
                                    }
                                }.padding(.trailing,12.0)
                            HStack{
                                ZStack{
                                    CircleItem(image:selectedHeroes[1].avatar,size:60,strokeColor:Color.white)
                                    Image(systemName:"gearshape.fill")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .offset(x:30,y:20)
                                    Path { path in
                                        path.move(to: CGPoint(x: 0, y: 0))
                                        path.addLine(to: CGPoint(x: 60, y: 60))
                                    }
                                    .trim(from: 0, to: isSlashing ? 1 : 0)
                                    .stroke(Color.red, style: StrokeStyle(lineWidth: 10))
                                    .animation(.easeInOut(duration: 0.5), value: isSlashing)
                                }
                                .frame(width:60,height:60)
                                .gesture(
                                    TapGesture()
                                        .onEnded {
                                            numberHero = 1
                                            isPresented = true
                                        }
                                )
                                Text(String(selectedHeroes[1].level))
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.white)
                                    .background(
                                        CustomCircleComponent(size:30,strokeColor:Color.white,line:2)
                                    ).padding(.top,-28.0).padding(.leading,-4.0)
                            }
                            Text("+")
                                .font(.title)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundStyle(.white)
                                .background(
                                    CustomCircleComponent(size:30,strokeColor:Color.white,line:2)
                                )
                                .onTapGesture{
                                    isLeveling = selectedHeroes[1].levelUp()
                                    DispatchQueue.global().async(){
                                        soundFeature.playSound(urlName:"skill-up")
                                    }
                                }.padding(.leading,12.0)
                            Spacer()
                        }.padding(.bottom,12.0)
                        HStack(spacing:0){
                            ZStack{
                                Rectangle()
                                    .fill(.white)
                                    .opacity(0.18)
                                    .frame(width: max(gp.size.width - 100, 0), height: max(60, 0))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.white, lineWidth: 2)
                                            .frame(width: max(gp.size.width - 100, 0), height: max(60, 0))
                                    )
                                VStack(alignment:.leading){
                                    HStack{
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(.red)
                                            .frame(width:max((gp.size.width - 120) * (selectedHeroes[1].hp/selectedHeroes[1].maxHp),0),height:max(40,0))
                                            .padding(10)
                                        Spacer()
                                        
                                    }
                                }
                                .padding(.leading,36)
                                HStack{
                                    Image(systemName:"heart.fill")
                                        .font(.caption)
                                        .foregroundStyle(.white)
                                    Text("\(Int(selectedHeroes[1].hp)) / \(Int(selectedHeroes[1].maxHp))")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                    Spacer()
                                    Image(systemName:"arrow.clockwise.circle.fill")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                        .onTapGesture{
                                            isAlive = selectedHeroes[1].revive()
                                        }
                                }.padding(.horizontal,56.0)
                            }
                            
                        }
                        Spacer()
                        HStack{
                            Spacer()
                            ZStack{
                                CircleItem(image:selectedHeroes[0].avatar,size:60,strokeColor:Color.white)
                                Image(systemName:"gearshape.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .offset(x:30,y:20)
                            }.onTapGesture {
                                numberHero = 0 //there
                                isPresented = true
                            }
                        }.padding(.horizontal,36.0).padding(.bottom,-16.0)
                        HStack(alignment:.top,spacing:12.0){
                            Spacer()
                            VStack{
                                ForEach([2,1,0], id: \.self) { index in
                                    HStack(alignment: .center, spacing: 16.0) {
                                        SkillLevelingComponent(
                                            isLeveling: $isLeveling,
                                            attacker: $selectedHeroes[0],
                                            indexSkill: index
                                        )
                                        SkillTileComponent(
                                            indexSkill: index,
                                            isAlive: $isAlive,
                                            isAttack: $isAttack,
                                            isSlashing: $isSlashing,
                                            defender: $selectedHeroes[1],
                                            attacker: $selectedHeroes[0],
                                            damage: $damage,
                                            offsetX: $offsetX,
                                            offsetY: $offsetY
                                        )
                                    }
                                    .padding(.trailing, index == 1 ? 10.0 : -100.0) // Adjust trailing padding based on index
                                    .padding(.bottom, 16.0)
                                }
                                
                            }
                            VStack{
                                ZStack{
                                    Image(uiImage:UIImage(named:"basic-attack")!.withRenderingMode(.alwaysTemplate))
                                        .resizable()
                                        .frame(width:150, height:150)
                                        .foregroundStyle(.white)
                                        .scaleEffect(1.03)
                                    Image("basic-attack")
                                        .resizable()
                                        .frame(width:150, height:150)
                                }
                                .onTapGesture {
                                    if isBasic {
                                        isAlive = selectedHeroes[1].takeDamage(dmg:selectedHeroes[0].calculateDamage(),pen:0,percPen:0)
                                        let generator = UIImpactFeedbackGenerator(style: .heavy)
                                        //
                                        DispatchQueue.global().async{
                                            generator.impactOccurred()
                                            soundFeature.playSound(urlName:selectedHeroes[0].basicSound)
                                        }
                                        isBasic = false
                                        isAttack = true
                                        isSlashing = true
//                                        Create damage text
                                        damage.append(-selectedHeroes[0].calculateDamage())
                                        offsetX.append(CGFloat.random(in: -100...100))
                                        offsetY.append(0)
//                                        Animate damage text
                                        withAnimation(.easeInOut(duration: 2.5)){
                                            offsetY[offsetY.count-1] = -250
                                        }
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                        isBasic = true
                                        isAttack = false
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                        isSlashing = false
                                    }
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 10.0){
//                                        damage.removeFirst()
//                                        offsetX.removeFirst()
//                                        offsetY.removeFirst()
//                                    }
                                }
                            }.padding(.top,72.0)
                            Spacer()
                        }
                        Spacer()
                    }.padding(.horizontal,16.0)
                    Rectangle()
                        .fill(.white)
                        .opacity(isAttack ? 0.32: 0)
                        .frame(width: gp.size.width, height: gp.size.height)
                        .transition(.opacity)
                        .animation(.easeInOut(duration:0.5),value:isAttack)
                }
            }
            .onAppear(){
                DispatchQueue.global().async(){
                    soundFeature.playBGM(urlName:"combat-sound",loop:true)
                }
            }
            .sheet(isPresented: $isPresented){
                TemporarySheetView(
                    selectedHeroes: $selectedHeroes,
                    indexHero: $numberHero,
                    chosenEmblem:$chosenEmblem[numberHero],
                    currentEmblem:$currentEmblem[numberHero],
                    chosenItem:$chosenItem[numberHero],
                    currentItem:$currentItem[numberHero],
                    tempHero: selectedHeroes[numberHero]
                )
                .presentationDetents([.large])
                .presentationBackgroundInteraction(.disabled)
                .presentationBackground(.thinMaterial)
                .onAppear {
                    print("NUMBER HERO: \(numberHero)")
                }
            }
            .ignoresSafeArea()
        }
    }
}

//#Preview{
//    ResultView(selectedHeroes:[
//        Hero(id:1,name: "Lancelot", image:"lancelot-bg", avatar:"lancelot-avatar", role:"Assassin",level:0, hp: 2459, hpGrowth: 147, mana: 450, manaGrowth: 100, physicalAtt: 124, physicalAttGrowth: 11.7857, physicalDef: 16, physicalDefGrowth: 3.1429, magicDef: 15, magicDefGrowth: 1.6429, attSpeed: 1.08, attSpeedGrowth: 0.0185,skill:
//                [
//                    Skill(name:"Puncture",maxLevel:6,baseDamage:[100],baseDamageGrowth: [30], additionalDamage: [AddDamage(percentPhysical:0.5)],image:"puncture-skill",cooldown:14.0,cooldownGrowth: 0.4,sound:"lancelot-skill-1"),
//                    Skill(name:"Thorned Rose",maxLevel:6,baseDamage:[170,170,170],baseDamageGrowth: [15,15,15], additionalDamage: [AddDamage(percentPhysical:1.3),AddDamage(percentPhysical:1.3),AddDamage(percentPhysical:1.3)],image:"thorned-rose-skill",cooldown:10.0,cooldownGrowth: 0.6,sound:"lancelot-skill-2"),
//                    Skill(name:"Phantom Execution",maxLevel:3,baseDamage:[350],baseDamageGrowth: [75], additionalDamage: [AddDamage(percentPhysical:1.7)],image:"phantom-execution-skill",cooldown:27.0,cooldownGrowth: 3.0,sound:"lancelot-skill-3"),
//                ],basicSound: "lancelot-basic"),
//        Hero(id:2,name: "Tigreal", image:"tigreal-bg", avatar:"tigreal-avatar", role:"Tank",level:1, hp: 2690, hpGrowth: 292, mana: 450, manaGrowth: 100, physicalAtt: 112, physicalAttGrowth: 6.7857, physicalDef: 20, physicalDefGrowth: 5.3571, magicDef: 15, magicDefGrowth: 2.5, attSpeed: 1.03, attSpeedGrowth: 0.02,skill:
//                [
//                    Skill(name:"Puncture",maxLevel:6,baseDamage:[100],baseDamageGrowth: [30], additionalDamage: [AddDamage(percentPhysical:0.5)],image:"puncture-skill",cooldown:14.0,cooldownGrowth: 0.4,sound:"lancelot-skill-1"),
//                    Skill(name:"Thorned Rose",maxLevel:6,baseDamage:[170,170,170],baseDamageGrowth: [15,15,15], additionalDamage: [AddDamage(percentPhysical:1.3),AddDamage(percentPhysical:1.3),AddDamage(percentPhysical:1.3)],image:"thorned-rose-skill",cooldown:14.0,cooldownGrowth: 0.4,sound:"lancelot-skill-2"),
//                    Skill(name:"Phantom Execution",maxLevel:6,baseDamage:[100],baseDamageGrowth: [30], additionalDamage: [AddDamage(percentPhysical:0.5)],image:"phantom-execution-skill",cooldown:14.0,cooldownGrowth: 0.4,sound:"lancelot-skill-3"),
//                ],basicSound: "lancelot-basic"),
//    ])
//}
