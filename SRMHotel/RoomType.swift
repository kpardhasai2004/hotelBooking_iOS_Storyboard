//
//  RoomType.swift
//  SRMHotel
//
//  Created by Avya Rathod on 24/01/24.
//

import Foundation

struct RoomType:Equatable{
    var id: Int
    var name:String
    var shortName:String
    var price:Int
    
    static var all:[RoomType]{
        return[RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 200), RoomType(id: 1, name: "King", shortName: "K", price: 300), RoomType(id: 2, name: "Pent House", shortName: "PH", price: 305)]
    }
    
    static func == (lhs:RoomType, rhs:RoomType)->Bool{
        return lhs.id == rhs.id
    }
    
}
