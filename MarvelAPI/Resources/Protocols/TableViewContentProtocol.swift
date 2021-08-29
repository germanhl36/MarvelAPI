//
//  TableViewContentProtocol.swift
//  MarvelAPI
//
//  Created by German Huerta on 27/08/21.
//

import Foundation
import UIKit
protocol TableContentProtocol {
    func getItems(offset:Int)
    func reloadDataIfNeeded(action:@escaping ()->())
    func getCount() -> Int
    func getCellVM(at index:Int) -> ItemDetailProtocol
    mutating func errorHandler(onError: @escaping (Error) -> Void)
    func getHeaderImage() -> UIImage
}
