//
//  ItemDetailProtocol.swift
//  MarvelAPI
//
//  Created by German Huerta on 28/08/21.
//

import Foundation
protocol ItemDetailProtocol {
    func getTitle() -> NSAttributedString
    func getDescription() -> NSAttributedString
    func getCreators() -> [NSAttributedString]
    func getPageCount() -> NSAttributedString
    func getPageCount() -> Int
    func getThumbnail() -> String
    func getImages() -> [String]
}
