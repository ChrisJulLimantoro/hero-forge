//
//  ItemModel.swift
//  HeroForge
//
//  Created by Christopher Julius on 25/04/24.
//

import Foundation

enum TypeItem: String, CaseIterable, CustomStringConvertible {
    case All = "all"
    case Attack = "attack"
    case Defense = "defense"
    case Magic = "magic"
    case Movement = "movement"
    
    var description: String {
        return self.rawValue
    }
}

struct Item{
    var id:Int = 0
    var damage:AddDamage? = nil
    var passive:[Passive] = []
    var name:String = ""
    var image:String = "empty"
    var price:Int = 0
    var textAtt:[String] = []
    var textUn:[String] = []
    var type:TypeItem = .Attack
    
//    item physical not unique
    var hp:Double = 0
    var physicalAtt:Double = 0
    var cooldown:Double = 0
    var magDef:Double = 0
    
//    unique
    var percPhyPen:Double = 0
    var fixPhyPen:Double = 0
    
//    item magical not unique
    var magPow:Double = 0
    var phyDef:Double = 0
    
//    unique
    var perMagPen:Double = 0
    var fixMagPen:Double = 0
    
//    item defense not unique
}
