//
//  PassiveModel.swift
//  HeroForge
//
//  Created by Christopher Julius on 25/04/24.
//

import Foundation

struct Passive{
    var isActive:Bool = false
    var stack:Int = 0
    var maxStack:Int = 0
    
    mutating func activate(){
        self.isActive = true
    }
    
    mutating func deactivate(){
        self.isActive = false
    }
    
    mutating func stackUp(up:Int)->Bool{
        guard self.stack == self.maxStack else{
            return false
        }
        if self.stack + up >= self.maxStack {
            self.stack = self.maxStack
        }else {
            self.stack += up
        }
        return true
    }
    
    mutating func stackDown(down:Int)->Bool{
        guard self.stack == 0 else {
            return false
        }
        
        if self.stack - down <= 0{
            self.stack = 0
        } else {
            self.stack -= down
        }
        return true
    }
}
