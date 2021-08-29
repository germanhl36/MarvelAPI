//
//  ItemDetailProtocol.swift
//  MarvelAPI
//
//  Created by German Huerta on 28/08/21.
//

import Foundation
protocol ItemDetailProtocol {
    var title:String {get set}
    var description:String  {get set}
    var thumbnail:String  {get set}
    var creators:[[String:String]]  {get set}
    var images:[String]  {get set}
    var pageCount:Int  {get set}
    
}
