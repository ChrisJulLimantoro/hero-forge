//
//  SkillTileComponent.swift
//  HeroForge
//
//  Created by Christopher Julius on 01/05/24.
//

import Foundation
import SwiftUI
import AVFoundation

struct SkillTileComponent:View {
    @State var indexSkill:Int
    @Binding var isAlive:Bool
    @Binding var defender:Hero
    @Binding var attacker:Hero
    @State var isTapped = false
    @State var audioPlayer: AVAudioPlayer?
    @State var timer : Timer?
    @State var isCooldown = false
    @State var cooldownTimeElapsed: Double = 0.0 // Track time elapsed during cooldown
    @State var cooldownDuration: Double = 0.0 // Track cooldown duration
    
    var body:some View {
        ZStack{
            Circle()
                .fill(.clear)
                .frame(width:80,height:80)
                .overlay(
                    ForEach(0..<Int(attacker.skills[indexSkill].maxLevel)) { index in
                        let startTrim = CGFloat(1.0 / attacker.skills[indexSkill].maxLevel) * CGFloat(index) + 0.008
                        let endTrim = CGFloat(1.0 / attacker.skills[indexSkill].maxLevel) * CGFloat(index + 1) - 0.008
                        Circle()
                            .trim(from: startTrim, to: endTrim)
                            .stroke(index < Int(attacker.skills[indexSkill].level) ? Color.yellow : Color.gray, lineWidth: 5)
                            .frame(width: 80, height: 80)
                            .rotationEffect(.degrees(-90))
                    }
                )
                .background(
                    Image(attacker.skills[indexSkill].image)
                        .resizable()
                        .frame(width:70, height:70)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                )
                .onTapGesture{
                    if !isCooldown{
                        isAlive = defender.takeDamage(
                            dmg:attacker.calculateDamageSkill(index:indexSkill),
                            pen:0,
                            percPen:0
                        )
                        let generator = UIImpactFeedbackGenerator(style: .heavy)
                        isTapped = true
                        isCooldown = true
                        generator.impactOccurred()
                        //                    Run a dispatch time to start a countdown for Cooldown of Skil
                        cooldownDuration = attacker.skills[indexSkill].cooldown
                        startCooldownTimer()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation {
                                isTapped = false
                            }
                        }
                        playSound(urlName:attacker.skills[indexSkill].sound)
                    }
                }
//          only be here if isCooldown
            if isCooldown {
                Circle()
                    .fill(.black)
                    .opacity(0.4)
                    .blur(radius:5)
                    .animation(.easeInOut(duration:0.2),value:isCooldown)
                    .overlay{
                        Text(String(format: "%.1f", cooldownDuration - cooldownTimeElapsed))
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        Circle()
                            .trim(from:0.0,to:CGFloat(cooldownTimeElapsed / cooldownDuration))
                            .fill(.clear)
                            .stroke(Color.white,lineWidth: 6)
                            .rotationEffect(.degrees(-90))
                            .frame(width:62,height:62)
                        Circle()
                            .trim(from:CGFloat(cooldownTimeElapsed / cooldownDuration),to:1.0)
                            .fill(.clear)
                            .stroke(Color.gray,lineWidth: 6)
                            .rotationEffect(.degrees(-90))
                            .frame(width:62,height:62)
                    }
            }
            
            if isTapped {
                Circle()
                    .fill(.white)
                    .opacity(0.4) // Set initial opacity to 0.8
                    .blur(radius: 10)
                    .transition(.opacity)
                    .animation(.easeOut(duration: 0.2),value:isTapped) // Ease-out animation
//                    .opacity(0) // Gradually decrease opacity back to 0
            }
            
        }.frame(width: 80, height: 80)
    }
    // Function to start the cooldown timer
//    private func startCooldownTimer() {
//        let cooldownDuration = attacker.skills[indexSkill].cooldown // Get cooldown duration from the skill
//        timer = Timer.scheduledTimer(withTimeInterval: cooldownDuration, repeats: false) { _ in
//            isCooldown = false // Reset cooldown state when the timer finishes
//        }
//    }
    private func startCooldownTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            cooldownTimeElapsed += 0.1 // Increment cooldown time elapsed
            if cooldownTimeElapsed >= cooldownDuration {
                // Reset cooldown state and timer when cooldown is finished
                isCooldown = false
                cooldownTimeElapsed = 0.0
                timer?.invalidate()
            }
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
