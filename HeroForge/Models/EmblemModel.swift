//
//  EmblemModel.swift
//  HeroForge
//
//  Created by Christopher Julius on 25/04/24.
//

struct Emblem {
    var name:String = ""
    var image:String = "empty"
    var passive:Passive = Passive()
    var addDamage:AddDamage = AddDamage()
    var textAtt:[String] = []
}
