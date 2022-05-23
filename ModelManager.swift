//
//  ModelManager.swift
//  JiaJu
//


import Foundation


struct PrudctModel:Hashable, Codable{
     var productType:Int
    var productId:String
     var titleName:String
     var img:String
     var currentPrice:String = "0"
     var offcount:String
     var detail:PrudctDetailModel
    var goodsNum:String = "1"
 
}

struct PrudctDetailModel:Hashable, Codable{
     var descimgs:[String]
     var decription:String
     var headImg:String
}

struct CartModel:Hashable, Codable{
     var goodsName:String
     var currentPrice:String = "0"
     var imageUrl:String
     var goodsId:String
     var goodsNum:String = "1"
     var totalPrice:String = "0"
    
 
}
