//
//  ItemTileComponent.swift
//  HeroForge
//
//  Created by Christopher Julius on 26/04/24.
//

import Foundation
import SwiftUI

struct ItemTile: View {
    @Binding var isPresented:Bool
    @Binding var typePresented:Int
    @Binding var items:[Item]
    @Binding var current:Int
    var itemIndex:Int
    var body: some View {
        HStack{
            if(items[itemIndex].image == "empty") {
                CustomCircleComponent(size:40,strokeColor: Color.gray,line:1)
            }else {
                Image(items[itemIndex].image)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            }
            VStack(alignment:.leading){
                Text(items[itemIndex].name == "" ?  "unselected" : items[itemIndex].name ).fontWeight(.semibold).font(.caption).fontDesign(.rounded)
                Text(String(items[itemIndex].price) ).fontWeight(.light).font(.caption).foregroundStyle(.gray).fontDesign(.rounded)
            }
        }
        .onTapGesture{
            typePresented = 2
            current = itemIndex
            isPresented = true
        }
    }
}
