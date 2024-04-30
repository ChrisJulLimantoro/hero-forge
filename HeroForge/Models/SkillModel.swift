//
//  SkillModel.swift
//  HeroForge
//
//  Created by Christopher Julius on 24/04/24.
//

struct Skill {
    var name:String = ""
    var level:Double = 0
    var maxLevel:Double = 0
    var image:String = ""
    var baseDamage:[Double] = []
    var baseDamageGrowth:[Double] = []
    var additionalDamage:[AddDamage] = []
    var passive:Passive = Passive()
    var cooldown:Double = 0
    var cooldownGrowth:Double = 0
    
    init(){
        self.level = 0
        self.maxLevel = 0
        self.image = "default-skill"
        self.baseDamage = []
        self.baseDamageGrowth = []
        self.additionalDamage = []
        self.passive = Passive()
        self.cooldown = 0
    }
    
    init(name:String,maxLevel: Double,baseDamage: [Double],baseDamageGrowth:[Double], additionalDamage: [AddDamage],image:String,cooldown:Double,cooldownGrowth:Double) {
        self.name = name
        self.level = 0
        self.maxLevel = maxLevel
        self.image = image
        self.baseDamage = baseDamage
        self.baseDamageGrowth = baseDamageGrowth
        self.additionalDamage = additionalDamage
        self.cooldown = cooldown
        self.cooldownGrowth = cooldownGrowth
    }
    
    mutating func levelUp()->Bool{
        guard self.level < self.maxLevel else{
            return false
        }
        self.level += 1
        
        for index in 0..<self.baseDamage.count{
            self.baseDamage[index] += self.baseDamageGrowth[index]
        }
        return true
    }
    
    mutating func levelDown()->Bool{
        guard self.level > 1 else{
            return false
        }
        self.level -= 1
        for index in 0..<self.baseDamage.count{
            self.baseDamage[index] -= self.baseDamageGrowth[index]
        }
        return true
    }
    
    func getPassive()->Passive{
        return self.passive
    }
}
