//
//  SkillModel.swift
//  HeroForge
//
//  Created by Christopher Julius on 24/04/24.
//

struct Skill {
    var level:Int = 0
    var maxLevel:Int = 0
    var image:String = ""
    var baseDamage:[Int] = []
    var baseDamageGrowth:[Int] = []
    var additionalDamage:[AddDamage] = []
    var passive:Passive = Passive()
    var cooldown:Double = 0
    
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
    
    init(level: Int, maxLevel: Int,baseDamage: [Int],baseDamageGrowth:[Int], additionalDamage: [AddDamage],passive:Passive) {
        self.level = level
        self.maxLevel = maxLevel
        self.baseDamage = baseDamage
        self.baseDamageGrowth = baseDamageGrowth
        self.additionalDamage = additionalDamage
        self.passive = passive
    }
    
    mutating func levelUp()->Bool{
        guard self.level < self.maxLevel else{
            return false
        }
        self.level += 1
        
        for index in 0...self.baseDamage.count{
            self.baseDamage[index] += self.baseDamageGrowth[index]
        }
        return true
    }
    
    mutating func levelDown()->Bool{
        guard self.level > 1 else{
            return false
        }
        self.level -= 1
        for index in 0...self.baseDamage.count{
            self.baseDamage[index] -= self.baseDamageGrowth[index]
        }
        return true
    }
    
    func getPassive()->Passive{
        return self.passive
    }
}
