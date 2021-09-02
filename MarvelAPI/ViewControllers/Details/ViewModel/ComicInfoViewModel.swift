//
//  ComicInfoViewModel.swift
//  MarvelAPI
//
//  Created by German Huerta on 27/08/21.
//

import Foundation
import UIKit.UIFont

struct ComicInfoViewModel:ItemDetailProtocol {
    private var title:String
    private var description:String
    private var thumbnail:String
    private var creators:[(name:String, title:String)]
    private var images:[String]
    private var pageCount:Int
    
    init(title:String, description:String, thumbnail:String, creators:[(name:String, title:String)], images:[String], pageCount:Int ) {
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
        self.creators = creators
        self.images = images
        self.pageCount = pageCount
    }
    
    func getTitle() -> NSAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.white ,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        let title = self.title.htmlString ?? self.title
        
        let attStr = NSAttributedString(string: title,attributes: attributes)
        
        return attStr
    }
    
    func getDescription() -> NSAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.white ,
            .font: UIFont.systemFont(ofSize: 14, weight: .light)
        ]
        let description = self.description.htmlString ?? self.description
        let attStr = NSAttributedString(string: description, attributes: attributes)
        
        return attStr
    }
    
    func getCreators() -> [NSAttributedString] {
        var creatorArray:[NSAttributedString] = []
        self.creators.forEach { creator in
            let attributesForTitle:[NSAttributedString.Key : Any] = [
                .foregroundColor: UIColor.white ,
                .font: UIFont.systemFont(ofSize: 14, weight: .bold)
            ]
            let title = creator.title.htmlString ?? creator.title
            let name = creator.name.htmlString ?? creator.name
            
            let attTitleStr = NSMutableAttributedString(string: "\(title.capitalized): " , attributes: attributesForTitle)
            
            let attributesForName:[NSAttributedString.Key : Any] = [
                .foregroundColor: UIColor.white ,
                .font: UIFont.systemFont(ofSize: 14, weight: .light)
            ]
            let attNameStr = NSAttributedString(string: name , attributes: attributesForName)
            
            
            attTitleStr.append(attNameStr)
            creatorArray.append(attTitleStr)
        }
        return creatorArray
    }
    
    func getPageCount() -> NSAttributedString {
        let attributesForTitle:[NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.white ,
            .font: UIFont.systemFont(ofSize: 14, weight: .bold)
        ]
        let attStr = NSMutableAttributedString(string: "Pages: " , attributes: attributesForTitle)
        
        let attributesForName:[NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.white ,
            .font: UIFont.systemFont(ofSize: 14, weight: .light)
        ]
        let attPageStr = NSAttributedString(string: "\(self.pageCount)" , attributes: attributesForName)
        attStr.append(attPageStr)
        return attStr
    }
    func getPageCount() -> Int {
        return self.pageCount
    }
    func getThumbnail() -> String {
        return self.thumbnail
    }
    
    func getImages() -> [String] {
        return self.images
    }
    
    
    
}
