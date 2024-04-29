//
//  ItemModel.swift
//  HeroForge
//
//  Created by Christopher Julius on 25/04/24.
//

import Foundation

struct Item{
    var damage:AddDamage? = nil
    var passive:[Passive] = []
    var name:String = ""
    var image:String = "empty"
    var price:Int = 0
}