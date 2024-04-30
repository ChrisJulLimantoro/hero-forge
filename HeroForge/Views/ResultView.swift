//
//  ResultView.swift
//  HeroForge
//
//  Created by Christopher Julius on 30/04/24.
//

import Foundation
import SwiftUI
import UIKit
import AVFoundation

struct ResultView:View{
    @State var selectedHeroes:[Hero]
    @State var isAlive = true
    @State var audioPlayer: AVAudioPlayer?
//    @State var level:Double = 3
//    var maxLevel:Double = 6
    var body: some View{
        NavigationStack{
            GeometryReader{gp in
                ZStack{
                    Rectangle()
                        .frame(width: .infinity, height: gp.size.height)
                        .foregroundStyle(
                            LinearGradient(gradient: Gradient(colors: [.init(red: 159/255, green: 0, blue: 0), .clear]), startPoint: .init(x:0.5,y:0.3), endPoint: .top)
                        )
                        .background{
                            Image(selectedHeroes[1].image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width:.infinity, height: gp.size.height/0.77 , alignment: .top)
                                .clipped()
                        }
                    VStack{
                        Rectangle()
                            .fill(.clear)
                            .frame(width:.infinity,height:gp.size.height*0.29)
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
                                    selectedHeroes[1].levelDown()
                                }.padding(.trailing,12.0)
                            HStack{
                                CircleItem(image:selectedHeroes[1].avatar,size:60,strokeColor:Color.white)
                                Text(String(selectedHeroes[1].level))
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.white)
                                    .background(
                                        CustomCircleComponent(size:30,strokeColor:Color.white,line:2)
                                    ).padding(.top,-28.0).padding(.leading,-4.0)
//                                VStack{
//                                    Text()
//                                }
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
                                    selectedHeroes[1].levelUp()
                                }.padding(.leading,12.0)
                            Spacer()
                        }.padding(.bottom,12.0)
                        HStack(spacing:0){
                            ZStack{
                                Rectangle()
                                    .fill(.white)
                                    .opacity(0.18)
                                    .frame(width:gp.size.width - 100, height:50)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.white, lineWidth: 2)
                                            .frame(width:gp.size.width - 100, height:50)
                                    )
                                VStack(alignment:.leading){
                                    HStack{
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(.red)
                                            .frame(width:(gp.size.width - 120) * (selectedHeroes[1].hp/selectedHeroes[1].maxHp),height:30)
                                            .padding(10)
                                        Spacer()
                                        
                                    }
                                }
                                .padding(.leading,36)
                                Text("HP: \(Int(selectedHeroes[1].hp)) / \(Int(selectedHeroes[1].maxHp))")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            }
                            
                        }
                        Spacer()
                        HStack(alignment:.top,spacing:12.0){
                            Spacer()
                            VStack{
                                HStack(alignment:.center,spacing:16){
                                    VStack(){
                                        Text("+")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .fontDesign(.rounded)
                                            .foregroundStyle(.white)
                                            .background(
                                                CustomCircleComponent(size:30,strokeColor:Color.white,line:2)
                                            )
                                            .onTapGesture{
                                                selectedHeroes[0].skillLevelUp(skillIndex:2)
                                            }
                                            .padding(.top,-12.0)
                                        Text("-")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .fontDesign(.rounded)
                                            .foregroundStyle(.white)
                                            .background(
                                                CustomCircleComponent(size:30,strokeColor:Color.white,line:2)
                                            )
                                            .onTapGesture{
                                                selectedHeroes[0].skillLevelDown(skillIndex:2)
                                            }
                                    }
                                    Circle()
                                        .fill(.clear)
                                        .frame(width:80,height:80)
                                        .overlay{
                                            ForEach(0..<Int(selectedHeroes[0].skills[2].maxLevel), id:\.self) { index in
                                                let startTrim = CGFloat(1.0 / selectedHeroes[0].skills[2].maxLevel) * CGFloat(index) + 0.008
                                                let endTrim = CGFloat(1.0 / selectedHeroes[0].skills[2].maxLevel) * CGFloat(index + 1) - 0.008
                                                Circle()
                                                    .trim(from: startTrim, to: endTrim)
                                                    .stroke(index < Int(selectedHeroes[0].skills[2].level) ? Color.yellow : Color.gray, lineWidth: 5)
                                                    .frame(width: 80, height: 80)
                                                    .rotationEffect(.degrees(-90))
                                            }
                                        }
                                        .background(
                                            Image(selectedHeroes[0].skills[2].image)
                                                .resizable()
                                                .frame(width:70, height:70)
                                                .clipShape(Circle())
                                                .overlay(
                                                    Circle()
                                                        .stroke(Color.white, lineWidth: 2)
                                                )
                                        )
                                        .padding(.trailing,-100.0)
                                        .padding(.bottom,16.0)
                                        .onTapGesture{
                                            isAlive = selectedHeroes[1].takeDamage(dmg:selectedHeroes[0].calculateDamageSkill(index:2),pen:0,percPen:0)
                                            let generator = UIImpactFeedbackGenerator(style: .heavy)
                                            
                                            generator.impactOccurred()
                                        }
                                }
                                HStack(alignment:.center,spacing:16.0){
                                    VStack(){
                                        Text("+")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .fontDesign(.rounded)
                                            .foregroundStyle(.white)
                                            .background(
                                                CustomCircleComponent(size:30,strokeColor:Color.white,line:2)
                                            )
                                            .onTapGesture{
                                                selectedHeroes[0].skillLevelUp(skillIndex:1)
                                            }
                                            .padding(.top,-12.0)
                                        Text("-")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .fontDesign(.rounded)
                                            .foregroundStyle(.white)
                                            .background(
                                                CustomCircleComponent(size:30,strokeColor:Color.white,line:2)
                                            )
                                            .onTapGesture{
                                                selectedHeroes[0].skillLevelDown(skillIndex:1)
                                            }
                                    }
                                    Circle()
                                        .fill(.clear)
                                        .frame(width:80,height:80)
                                        .overlay(
                                            ForEach(0..<Int(selectedHeroes[0].skills[1].maxLevel), id:\.self) { index in
                                                let startTrim = CGFloat(1.0 / selectedHeroes[0].skills[1].maxLevel) * CGFloat(index) + 0.008
                                                let endTrim = CGFloat(1.0 / selectedHeroes[0].skills[1].maxLevel) * CGFloat(index + 1) - 0.008
                                                Circle()
                                                    .trim(from: startTrim, to: endTrim)
                                                    .stroke(index < Int(selectedHeroes[0].skills[1].level) ? Color.yellow : Color.gray, lineWidth: 5)
                                                    .frame(width: 80, height: 80)
                                                    .rotationEffect(.degrees(-90))
                                            }
                                        )
                                        .background(
                                            Image(selectedHeroes[0].skills[1].image)
                                                .resizable()
                                                .frame(width:70, height:70)
                                                .clipShape(Circle())
                                                .overlay(
                                                    Circle()
                                                        .stroke(Color.white, lineWidth: 2)
                                                )
                                        )
                                        .padding(.trailing,10.0)
                                        .padding(.bottom,16.0)
                                        .onTapGesture{
                                            isAlive = selectedHeroes[1].takeDamage(dmg:selectedHeroes[0].calculateDamageSkill(index:1),pen:0,percPen:0)
                                            let generator = UIImpactFeedbackGenerator(style: .heavy)
                                            
                                            generator.impactOccurred()
                                        }
                                }
                                HStack(alignment:.center,spacing:16.0){
                                    VStack(){
                                        Text("+")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .fontDesign(.rounded)
                                            .foregroundStyle(.white)
                                            .background(
                                                CustomCircleComponent(size:30,strokeColor:Color.white,line:2)
                                            )
                                            .onTapGesture{
                                                selectedHeroes[0].skillLevelUp(skillIndex:0)
                                            }
                                            .padding(.top,-12.0)
                                        Text("-")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .fontDesign(.rounded)
                                            .foregroundStyle(.white)
                                            .background(
                                                CustomCircleComponent(size:30,strokeColor:Color.white,line:2)
                                            )
                                            .onTapGesture{
                                                selectedHeroes[0].skillLevelDown(skillIndex:0)
                                            }
                                    }
                                    Circle()
                                        .fill(.clear)
                                        .frame(width:80,height:80)
                                        .overlay(
                                            ForEach(0..<Int(selectedHeroes[0].skills[0].maxLevel)) { index in
                                                let startTrim = CGFloat(1.0 / selectedHeroes[0].skills[0].maxLevel) * CGFloat(index) + 0.008
                                                let endTrim = CGFloat(1.0 / selectedHeroes[0].skills[0].maxLevel) * CGFloat(index + 1) - 0.008
                                                Circle()
                                                    .trim(from: startTrim, to: endTrim)
                                                    .stroke(index < Int(selectedHeroes[0].skills[0].level) ? Color.yellow : Color.gray, lineWidth: 5)
                                                    .frame(width: 80, height: 80)
                                                    .rotationEffect(.degrees(-90))
                                            }
                                        )
                                        .background(
                                            Image(selectedHeroes[0].skills[0].image)
                                                .resizable()
                                                .frame(width:70, height:70)
                                                .clipShape(Circle())
                                                .overlay(
                                                    Circle()
                                                        .stroke(Color.white, lineWidth: 2)
                                                )
                                        )
                                        .padding(.trailing,-100.0)
                                        .padding(.bottom,16.0)
                                        .onTapGesture{
                                            isAlive = selectedHeroes[1].takeDamage(dmg:selectedHeroes[0].calculateDamageSkill(index:0),pen:0,percPen:0)
                                            let generator = UIImpactFeedbackGenerator(style: .heavy)
                                            
                                            generator.impactOccurred()
                                        }
                                }
                            }
                            VStack{
                                Image("basic-attack")
                                    .resizable()
                                    .frame(width:150, height:150)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .onTapGesture {
                                        isAlive = selectedHeroes[1].takeDamage(dmg:selectedHeroes[0].physicalAtt,pen:0,percPen:0)
                                        let generator = UIImpactFeedbackGenerator(style: .heavy)
                                        
                                        generator.impactOccurred()
                                        playSound(urlName:"sound/lancelot-basic")
                                    }
                            }.padding(.top,75.0)
                            Spacer()
                        }
                        Spacer()
                    }.padding(.horizontal,16.0)
                }
            }
            .ignoresSafeArea()
        }
    }
    func playSound(urlName:String) {
        guard let url = Bundle.main.url(forResource: urlName, withExtension: "mp3") else { return }
        
        do {
            // Initialize audio player
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            // Play the sound
            audioPlayer?.play()
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
}

#Preview{
    ResultView(selectedHeroes:[
        Hero(name: "Lancelot", image:"lancelot-bg", avatar:"lancelot-avatar", role:"Assassin", hp: 2459, hpGrowth: 147, mana: 450, manaGrowth: 100, physicalAtt: 124, physicalAttGrowth: 11.7857, physicalDef: 16, physicalDefGrowth: 3.1429, magicDef: 15, magicDefGrowth: 1.6429, attSpeed: 1.08, attSpeedGrowth: 0.0185,skill:
                [
                    Skill(name:"Puncture",maxLevel:6,baseDamage:[100],baseDamageGrowth: [30], additionalDamage: [AddDamage(percentPhysical:0.5)],image:"puncture-skill",cooldown:14.0,cooldownGrowth: 0.4),
                    Skill(name:"Thorned Rose",maxLevel:6,baseDamage:[170,170,170],baseDamageGrowth: [15,15,15], additionalDamage: [AddDamage(percentPhysical:1.3),AddDamage(percentPhysical:1.3),AddDamage(percentPhysical:1.3)],image:"thorned-rose-skill",cooldown:14.0,cooldownGrowth: 0.4),
                    Skill(name:"Phantom Execution",maxLevel:3,baseDamage:[100],baseDamageGrowth: [30], additionalDamage: [AddDamage(percentPhysical:0.5)],image:"phantom-execution-skill",cooldown:14.0,cooldownGrowth: 0.4),
                ]),
        Hero(name: "Tigreal", image:"tigreal-bg", avatar:"tigreal-avatar", role:"Tank", hp: 2690, hpGrowth: 292, mana: 450, manaGrowth: 100, physicalAtt: 112, physicalAttGrowth: 6.7857, physicalDef: 20, physicalDefGrowth: 5.3571, magicDef: 15, magicDefGrowth: 2.5, attSpeed: 1.03, attSpeedGrowth: 0.02,skill:
                [
                    Skill(name:"Puncture",maxLevel:6,baseDamage:[100],baseDamageGrowth: [30], additionalDamage: [AddDamage(percentPhysical:0.5)],image:"puncture-skill",cooldown:14.0,cooldownGrowth: 0.4),
                    Skill(name:"Thorned Rose",maxLevel:6,baseDamage:[170,170,170],baseDamageGrowth: [15,15,15], additionalDamage: [AddDamage(percentPhysical:1.3),AddDamage(percentPhysical:1.3),AddDamage(percentPhysical:1.3)],image:"thorned-rose-skill",cooldown:14.0,cooldownGrowth: 0.4),
                    Skill(name:"Phantom Execution",maxLevel:6,baseDamage:[100],baseDamageGrowth: [30], additionalDamage: [AddDamage(percentPhysical:0.5)],image:"phantom-execution-skill",cooldown:14.0,cooldownGrowth: 0.4),
                ]),
    ])
}
