//
//  SoundFeature.swift
//  HeroForge
//
//  Created by Christopher Julius on 02/05/24.
//

import Foundation
import AVFoundation

class SoundFeature {
    var audioPlayers: [AVAudioPlayer] = []
    private var bgmPlayer: AVAudioPlayer?
    private var currentBGMName: String?
    
    func playBGM(urlName: String, loop: Bool = true) {
        // Check if the BGM player is already created
        if let player = bgmPlayer {
            // If the URL name is the same, just return
            if currentBGMName == urlName {
                return
            }
            // Otherwise, stop the current player and prepare for the new BGM
            stopBGM()
        }
        
        // Create a new BGM player
        guard let url = Bundle.main.url(forResource: urlName, withExtension: "mp3") else { return }
        
        do {
            let newBGMPlayer = try AVAudioPlayer(contentsOf: url)
            newBGMPlayer.numberOfLoops = loop ? -1 : 0
            newBGMPlayer.play()
            
            // Set the new player as the current one
            currentBGMName = urlName
            bgmPlayer = newBGMPlayer
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func stopBGM() {
        if let player = bgmPlayer {
            player.stop()
            bgmPlayer = nil
            currentBGMName = nil
        }
    }
    
    func playSound(urlName: String, loop: Bool = false) {
        guard let url = Bundle.main.url(forResource: urlName, withExtension: "mp3") else { return }
        
        do {
            // Initialize audio player
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            // Set infinite looping if required
            if loop {
                audioPlayer.numberOfLoops = -1
            }
            // Append to the array of audio players
            audioPlayers.append(audioPlayer)
            // Play the sound
            audioPlayer.play()
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func stopAllSounds() {
        for player in audioPlayers {
            player.stop()
        }
        audioPlayers.removeAll()
    }
}
