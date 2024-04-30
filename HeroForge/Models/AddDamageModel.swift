//
//  DamageModel.swift
//  HeroForge
//
//  Created by Christopher Julius on 25/04/24.
//

import Foundation

struct AddDamage{
    var fixedPhysical:Double = 0
    var fixedMagical:Double = 0
    var percentPhysical:Double = 0
    var percentMagical:Double = 0
    var percentCurrentHealth:Double = 0 // for demon hunter sword
    var percentMaxHealth:Double = 0
    var trueDamage:Double = 0
    
    func calculateDamage(physical:Double,magic:Double,enemyCurrentHealth:Double?)->Double{
        return (self.fixedPhysical + self.fixedMagical + (self.percentPhysical * physical) + (self.percentMagical * magic) + (self.percentCurrentHealth * (enemyCurrentHealth ?? 0.0)) + self.trueDamage)
    }
}
