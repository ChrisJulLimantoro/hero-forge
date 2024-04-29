//
//  ItemSheetView.swift
//  HeroForge
//
//  Created by Christopher Julius on 26/04/24.
//

import Foundation
import SwiftUI

struct ItemSheetView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading,spacing:20.0){
                HStack{
                    Spacer()
                    VStack(alignment: .leading){
                        HStack{
                            Spacer()
                            CircleItem(image: "bod", size:50, strokeColor: Color.gray)
                            VStack(alignment:.leading){
                                Text("Blade of Despair")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .fontDesign(.rounded)
                                    .padding([.bottom],-8.0)
                                Text("Attack")
                                    .font(.caption)
                                    .fontWeight(.light)
                                    .fontDesign(.rounded)
                            }
                            Spacer()
                        }
                        Text("Attribute")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .fontDesign(.rounded)
                        Text("+14 Adaptive Penetration")
                            .font(.caption)
                            .fontWeight(.light)
                            .fontDesign(.rounded)
                            .padding([.horizontal],4.0)
                        Text("+10 Adaptive Attack")
                            .font(.caption)
                            .fontWeight(.light)
                            .fontDesign(.rounded)
                            .padding([.horizontal],4.0)
                        Text("+3% Movement Speed")
                            .font(.caption)
                            .fontWeight(.light)
                            .fontDesign(.rounded)
                            .padding([.horizontal],4.0)
                    }
                    Spacer()
                }
                .padding(16.0)
                .background(
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white.gradient.shadow(.drop(color: .gray, radius: 2.6, x: 0, y: 4)))
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                    }
                )
                HStack{
                    VStack(alignment: .leading){
                        HStack{
                            Image("bod")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                .scaledToFill()
                            VStack(alignment:.leading){
                                Text("Blade Of Despair").fontWeight(.semibold).font(.caption).fontDesign(.rounded)
                                Text("3010").fontWeight(.light).font(.caption).foregroundStyle(.gray).fontDesign(.rounded)
                            }
                        }
                        HStack{
                            Image("bod")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                .scaledToFill()
                            VStack(alignment:.leading){
                                Text("Blade Of Despair").fontWeight(.semibold).font(.caption).fontDesign(.rounded)
                                Text("3010").fontWeight(.light).font(.caption).foregroundStyle(.gray).fontDesign(.rounded)
                            }
                        }
                        HStack{
                            Image("bod")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                .scaledToFill()
                            VStack(alignment:.leading){
                                Text("Blade Of Despair").fontWeight(.semibold).font(.caption).fontDesign(.rounded)
                                Text("3010").fontWeight(.light).font(.caption).foregroundStyle(.gray).fontDesign(.rounded)
                            }
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading){
                        HStack{
                            Image("bod")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                .scaledToFill()
                            VStack(alignment:.leading){
                                Text("Blade Of Despair").fontWeight(.semibold).font(.caption).fontDesign(.rounded)
                                Text("3010").fontWeight(.light).font(.caption).foregroundStyle(.gray).fontDesign(.rounded)
                            }
                        }
                        HStack{
                            Image("bod")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                .scaledToFill()
                            VStack(alignment:.leading){
                                Text("Blade Of Despair").fontWeight(.semibold).font(.caption).fontDesign(.rounded)
                                Text("3010").fontWeight(.light).font(.caption).foregroundStyle(.gray).fontDesign(.rounded)
                            }
                        }
                        HStack{
                            Image("bod")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                .scaledToFill()
                            VStack(alignment:.leading){
                                Text("Blade Of Despair").fontWeight(.semibold).font(.caption).fontDesign(.rounded)
                                Text("3010").fontWeight(.light).font(.caption).foregroundStyle(.gray).fontDesign(.rounded)
                            }
                        }
                    }
                }
                .padding(16.0)
                .background(
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white.gradient.shadow(.drop(color: .gray, radius: 2.6, x: 0, y: 4)))
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                    }
                )
                Spacer()
            }.padding(16.0)
            .navigationTitle("Choose Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        dismiss()
                    }
                }
            }
        }
    }
}
