//
//  HeroModel.swift
//  HeroForge
//
//  Created by Christopher Julius on 23/04/24.
//

// Structure for Hero
struct Hero{
    var id:Int = 0
    var name:String = "Unselected"
    var role:String = "Unselected"
    var level:Int = 0
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
    var basicSound:String = ""
    
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
            self.level = 0
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
    init(id:Int,name: String, image:String, avatar:String, role:String,level:Int, hp: Double, hpGrowth: Double, mana: Double, manaGrowth: Double, physicalAtt: Double, physicalAttGrowth: Double, physicalDef: Double, physicalDefGrowth: Double, magicDef: Double, magicDefGrowth: Double, attSpeed: Double, attSpeedGrowth: Double,skill:[Skill],basicSound:String) {
        self.id = id
        self.name = name
        self.image = image
        self.avatar = avatar
        self.role = role
        self.level = level
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
        self.basicSound = basicSound
    }
    
    mutating func setHero(hero:Hero){
        self.id = hero.id
        self.name = hero.name
        self.image = hero.image
        self.avatar = hero.avatar
        self.role = hero.role
        self.level = hero.level
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
        self.basicSound = hero.basicSound
    }
    
    mutating func levelUp()->Bool{
        guard self.level < 15 else {
            return false
        }
        
        guard self.level > 0 else {
            self.level = 1
            return true
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
    
    mutating func revive()->Bool{
        self.hp = self.maxHp
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
    
//    Equip Emblem
    mutating func equipEmblem(emblem: Emblem, slot: String){
        self.emblems[slot] = emblem
        self.maxHp += emblem.hp
        self.hp += emblem.hp
        
        if self.magicPower > self.physicalAtt {
            self.magicPower += emblem.atk
        } else {
            self.physicalAtt += emblem.atk
        }
        
        self.magicDef += emblem.hyDef
        self.physicalDef += emblem.hyDef
        self.magicPower += emblem.magic
        
//        cooldown skill
        for index in 0..<self.skills.count {
            self.skills[index].cooldown *= (1 - emblem.cooldown)
        }
    }
    
    mutating func unequipEmblem(emblem: Emblem,slot:String){
        self.emblems[slot] = Emblem()
        self.maxHp -= emblem.hp
        self.hp -= emblem.hp
        
        if self.magicPower > self.physicalAtt {
            self.magicPower -= emblem.atk
        } else {
            self.physicalAtt -= emblem.atk
        }
        
        self.magicDef -= emblem.hyDef
        self.physicalDef -= emblem.hyDef
        self.magicPower -= emblem.magic
        
        for index in 0..<self.skills.count {
            self.skills[index].cooldown *= (1/(1 - emblem.cooldown))
        }
    }
    
    mutating func equipItem(item: Item,slot:Int){
        self.items[slot] = item
        self.maxHp += item.hp
        self.hp += item.hp
        self.physicalAtt += item.physicalAtt
        self.magicPower += item.magPow
        self.magicDef += item.magDef
        self.physicalDef += item.phyDef
    }
    
    mutating func unequipItem(item: Item, slot:Int){
        self.items[slot] = Item()
        self.maxHp -= item.hp
        self.hp -= item.hp
        self.physicalAtt -= item.physicalAtt
        self.magicPower -= item.magPow
        self.magicDef -= item.magDef
        self.physicalDef -= item.phyDef
    }
    
    
//    Calculate Damage Basic Attack
    mutating func calculateDamage()->Double{
        guard self.level > 0 else {
            return 0
        }
        var dmg = self.physicalAtt
//        Calculate damage increase from Emblems
        for emblem in self.emblems.values {
            dmg += emblem.addDamage.calculateDamage(
                physical: self.physicalAtt, magic: self.magicPower, enemyCurrentHealth: nil
            )
        }
        
//        Calculate from Item
        
        return dmg
    }
    
//    Calculate Damage Skill based on Index Skill
    mutating func calculateDamageSkill(index: Int)->Double{
        guard self.level > 0 else {
            return 0
        }
        var dmg:Double = 0.0
        for i in 0..<self.skills[index].baseDamage.count{
//            Multiply by skill alone
            dmg += self.skills[index].baseDamage[i] + self.skills[index].additionalDamage[i].calculateDamage(physical:self.physicalAtt, magic: self.magicPower,enemyCurrentHealth: nil)
            
//            Calculating from the emblems
            for emblem in self.emblems.values {
                dmg += emblem.addDamage.calculateDamage(
                    physical: self.physicalAtt, magic: self.magicPower, enemyCurrentHealth: nil
                )
                dmg += emblem.skillDmg
            }
            
//            Calculating from the items
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
    
}

