//
//  HeroModel.swift
//  HeroForge
//
//  Created by Christopher Julius on 23/04/24.
//

// Structure for Hero
struct Hero{
    var name:String = "Unselected"
    var role:String = "Unselected"
    var level:Int = 1
    var image:String = ""
    var avatar:String = ""
    var hp:Double = 0
    var maxHp:Double = 0
    var hpGrowth:Double = 0
    var mana:Double = 0
    var manaGrowth:Double = 0
    var physicalAtt:Double = 0
    var physicalAttGrowth:Double = 0
    var magicPower:Double = 0
    var physicalDef:Double = 0
    var physicalDefGrowth:Double = 0
    var magicDef:Double = 0
    var magicDefGrowth:Double = 0
    var attSpeed:Double = 0
    var attSpeedGrowth:Double = 0
    
//    Fluctuative Stats
    var skills:[Skill] = []
    var passives:[Passive] = []
    var emblems:[String:Emblem] = [
        "main" : Emblem(),
        "sub1" : Emblem(),
        "sub2" : Emblem(),
        "sub3" : Emblem()
    ]
    var items:[Item] = [
        Item(),
        Item(),
        Item(),
        Item(),
        Item(),
        Item(),
    ]
    
    //    initialize empty
        init(){
            self.name = "Unselected"
            self.role = "Unselected"
            self.level = 1
            self.hp = 0
            self.maxHp = 0
            self.hpGrowth = 0
            self.mana = 0
            self.manaGrowth = 0
            self.physicalAtt = 0
            self.physicalAttGrowth = 0
            self.physicalDef = 0
            self.physicalDefGrowth = 0
            self.magicDef = 0
            self.magicDefGrowth = 0
            self.attSpeed = 0
            self.attSpeedGrowth = 0
        }
    
//    initialize for image and name only
    init(name: String, image:String) {
        self.name = name
        self.image = image
    }
    
//    initialize
    init(name: String, image:String, avatar:String, role:String, hp: Double, hpGrowth: Double, mana: Double, manaGrowth: Double, physicalAtt: Double, physicalAttGrowth: Double, physicalDef: Double, physicalDefGrowth: Double, magicDef: Double, magicDefGrowth: Double, attSpeed: Double, attSpeedGrowth: Double,skill:[Skill]) {
        self.name = name
        self.image = image
        self.avatar = avatar
        self.role = role
        self.level = 1
        self.hp = hp
        self.maxHp = hp
        self.hpGrowth = hpGrowth
        self.mana = mana
        self.manaGrowth = manaGrowth
        self.physicalAtt = physicalAtt
        self.physicalAttGrowth = physicalAttGrowth
        self.magicPower = 0
        self.physicalDef = physicalDef
        self.physicalDefGrowth = physicalDefGrowth
        self.magicDef = magicDef
        self.magicDefGrowth = magicDefGrowth
        self.attSpeed = attSpeed
        self.attSpeedGrowth = attSpeedGrowth
        self.skills = skill
    }
    
    mutating func setHero(hero:Hero){
        self.name = hero.name
        self.image = hero.image
        self.avatar = hero.avatar
        self.role = hero.role
        self.level = 1
        self.hp = hero.hp
        self.maxHp = hero.maxHp
        self.hpGrowth = hero.hpGrowth
        self.mana = hero.mana
        self.manaGrowth = hero.manaGrowth
        self.physicalAtt = hero.physicalAtt
        self.physicalAttGrowth = hero.physicalAttGrowth
        self.magicPower = 0
        self.physicalDef = hero.physicalDef
        self.physicalDefGrowth = hero.physicalDefGrowth
        self.magicDef = hero.magicDef
        self.magicDefGrowth = hero.magicDefGrowth
        self.attSpeed = hero.attSpeed
        self.attSpeedGrowth = hero.attSpeedGrowth
        self.skills = hero.skills
    }
    
    mutating func levelUp()->Bool{
        guard self.level < 15 else {
            return false
        }
        self.hp += self.hpGrowth
        self.maxHp += self.hpGrowth
        self.mana += self.manaGrowth
        self.attSpeed += self.attSpeedGrowth
        self.physicalAtt += self.physicalAttGrowth
        self.physicalDef += self.physicalDefGrowth
        self.magicDef += self.magicDefGrowth
        self.level += 1
        return true
    }
    
    mutating func levelDown()->Bool{
        guard self.level > 1 else {
            return false
        }
        if self.hp < 0 {
            self.hp = 0
        }else {
            self.hp -= self.hpGrowth
        }
        self.maxHp -= self.hpGrowth
        self.mana -= self.manaGrowth
        self.attSpeed -= self.attSpeedGrowth
        self.physicalAtt -= self.physicalAttGrowth
        self.physicalDef -=  self.physicalDefGrowth
        self.magicDef -= self.magicDefGrowth
        self.level -= 1
        return true
    }
    
    mutating func skillLevelUp(skillIndex: Int) -> Bool {
        guard skillIndex < self.skills.count else {
            // Handle case where skillIndex is not found in the dictionary
            return false
        }
        guard self.skills[skillIndex].levelUp() else {
            return false
        }
        
        guard self.levelUp() else {
            return false
        }
        
        return true
    }

    
    mutating func skillLevelDown(skillIndex: Int)->Bool{
        guard skillIndex < self.skills.count else {
            // Handle case where skillIndex is not found in the dictionary
            return false
        }
        guard self.skills[skillIndex].levelDown() else {
            return false
        }
        
        guard self.levelDown() else {
            return false
        }
        
        return true
    }
    
    mutating func calculateDamage(){
        
    }
    
    mutating func calculateDamageSkill(index: Int)->Double{
        var dmg:Double = 0.0
        for i in 0..<self.skills[index].baseDamage.count{
            dmg += self.skills[index].baseDamage[i] + self.skills[index].additionalDamage[i].calculateDamage(physical:self.physicalAtt, magic: self.magicPower,enemyCurrentHealth: nil)
        }
        return dmg
    }
    
    mutating func takeDamage(dmg:Double,pen:Double,percPen:Double)->Bool{
        guard self.hp > 0 else {
            return false
        }
        guard self.hp - dmg > 0 else {
            self.hp = 0
            return false
        }
        self.hp -= dmg
        return true
    }
    
    mutating func setPassive(passive:Passive){
        self.passives.append(passive)
    }
    
    mutating func unSetPassive(passive:Passive){
        
    }
    
    mutating func activatePassive(index:Int){
        self.passives[index].activate()
    }
    
    mutating func deactivatePassive(index:Int){
        self.passives[index].deactivate()
    }
}

