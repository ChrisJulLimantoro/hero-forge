//
//  ItemModel.swift
//  HeroForge
//
//  Created by Christopher Julius on 25/04/24.
//

import Foundation

enum TypeItem:String {
    case Attack = "attack"
    case Defense = "defense"
    case Magic = "magic"
    case Movement = "movement"
}

struct Item{
    var damage:AddDamage? = nil
    var passive:[Passive] = []
    var name:String = ""
    var image:String = "empty"
    var price:Int = 0
    var textAtt:[String] = []
    var textUn:[String] = []
    var type:TypeItem = .Attack
}
