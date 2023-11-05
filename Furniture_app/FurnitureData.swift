//
//  FurnitureData.swift
//  Furniture_app
//
//  Created by Nishit Vats on 02/11/23.
//

import Foundation
import SwiftUI

struct furniture:Identifiable{
    
    let id = UUID()
    let name:String
    let price:Int
    let image:Image
    let imageName:String
    let Description:String
    var isLiked:Bool
    
}

let sofaImage = Image("sofa")
let chairImage = Image("chair")
let tableImage = Image("table")

let demoData: [furniture] = [
    furniture(name: "Comfy Sofa", price: 899, image: sofaImage, imageName: "sofa", Description: "A comfortable sofa for your living room.", isLiked: false),
    furniture(name: "Cozy Armchair", price: 299, image: chairImage, imageName: "chair", Description: "A cozy armchair for your reading nook.", isLiked: false),
    furniture(name: "Elegant Coffee Table", price: 199, image: tableImage, imageName: "table", Description: "An elegant coffee table for your lounge.", isLiked: false),
]

var likedFurniture:[furniture] = []
var cartItems:[furniture] = []


