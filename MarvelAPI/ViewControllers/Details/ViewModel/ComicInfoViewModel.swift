//
//  ComicInfoViewModel.swift
//  MarvelAPI
//
//  Created by German Huerta on 27/08/21.
//

import Foundation
struct ComicInfoViewModel:ItemDetailProtocol {
    var title:String
    var description:String
    var thumbnail:String
    var creators:[[String:String]]
    var images:[String]
    var pageCount:Int
}
