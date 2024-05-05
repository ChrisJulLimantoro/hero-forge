//
//  EmblemModel.swift
//  HeroForge
//
//  Created by Christopher Julius on 25/04/24.
//

struct Emblem {
    var id:Int = 0
    var name:String = ""
    var image:String = "empty"
    var passive:Passive = Passive()
    var addDamage:AddDamage = AddDamage()
    var textAtt:[String] = []
    
//    From main
    var hp:Double = 0
    var atk:Double = 0
    var hyDef:Double = 0
    var pen:Double = 0
    var magic:Double = 0
    var magPen:Double = 0
    var cooldown:Double = 0
//    From sub-1
    var belowDef:Double = 0
//    From sub-2
    var itemReduction:Double = 0.05
    var increaseAllAtk:Double = 0.05
//    From sub-3
    var skillDmg:Double = 0
    var skillDmgGrowth:Double = 0

}
