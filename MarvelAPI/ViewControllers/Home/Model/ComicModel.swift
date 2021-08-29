//
//  ComicModel.swift
//  MarvelAPI
//
//  Created by German Huerta on 27/08/21.

import Foundation

// MARK: - Welcome
struct ComicModel: Codable {
    var code:Int?
    var status:String?
    var copyright:String?
    var attributionText: String?
    var attributionHTML: String?
    var data: DataClass?
    var etag: String?
}

// MARK: - DataClass
struct DataClass: Codable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [Results]?
}

// MARK: - Result
struct Results: Codable {
    var id:Int?
    var digitalID:Int?
    var title:String?
    var issueNumber: Double?
    var variantDescription:String?
    var description:String?
    
    var modified:String?
    
    var isbn: String?
    var upc:String?
    var diamondCode:String?
    var ean:String?
    var issn: String?
    var format:String?
    var pageCount:Int?
    var textObjects: [TextObject]?
    
    
    var resourceURI: String?
    var urls: [URLElement]?
    var series: Series?
    var variants:[Series]?
    var collections:[Series]?
    var collectedIssues: [Series]?
    var dates: [DateElement]?
    var prices: [Price]?
    var thumbnail: Thumbnail?
    var images: [Thumbnail]?
    var creators:Characters?
    var characters: Characters?
    var stories: Stories?
    var events: Events?

   
}

// MARK: - Characters
struct Characters: Codable {
    var available:Int?
    var returned:Int?
    var collectionURI: String?
    var items: [CharactersItem]?
}

// MARK: - CharactersItem
struct CharactersItem: Codable {
    var resourceURI:String?
    var name:String?
    var role: String?
}

// MARK: - Series
struct Series: Codable {
    var resourceURI:String?
    var name: String?
}

// MARK: - DateElement
struct DateElement: Codable {
    var type:String?
    var date:String?
}

// MARK: - Events
struct Events: Codable {
    var available:Int?
    var returned:Int?
    var collectionURI: String?
    var items: [Series]?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    var path:String?
    var thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - Price
struct Price: Codable {
    var type:String?
    var price: Double?
}

// MARK: - Stories
struct Stories: Codable {
    var available:Int?
    var returned:Int?
    var collectionURI: String?
    var items: [StoriesItem]?
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    var resourceURI:String?
    var name:String?
    var type: String?
}

// MARK: - TextObject
struct TextObject: Codable {
    var type:String?
    var language:String?
    var text: String?
}

// MARK: - URLElement
struct URLElement: Codable {
    var type:String?
    var url: String?
}
