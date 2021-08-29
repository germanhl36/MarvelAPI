//
//  HomeViewModel.swift
//  MarvelAPI
//
//  Created by German Huerta on 27/08/21.
//

import Foundation
import UIKit
struct HomeViewModel:TableContentProtocol {
    private var manager = HTTPManager()
    private var comicVM:Box<[ComicInfoViewModel]> = Box<[ComicInfoViewModel]>([])
    private var errorHandler:((Error) -> ())?
    private var headerImage:UIImage!
    init(headerImage:UIImage) {
        self.headerImage = headerImage
    }
    
    
    func getItems(offset:Int = 0) {
        let currentDate = Date()
        print(currentDate.description)
        let timeStamp = currentDate.timeIntervalSince1970.description
        let md5Data = "\(timeStamp)\(Constants.MARVEL_PRIVATE_KEY)\(Constants.MARVEL_PUBLIC_KEY)"
       

        var urlComponents = URLComponents(string: Constants.MARVEL_ENDPOINT_COMICS)
        let apiKeyItem = URLQueryItem(name: "apikey", value: Constants.MARVEL_PUBLIC_KEY)
        let tsItem = URLQueryItem(name: "ts", value: timeStamp)
        let hashItem = URLQueryItem(name: "hash", value: md5Data.md5Hex())
        let limitItem = URLQueryItem(name: "limit", value: String(Constants.MAX_NUMBER_PER_REQUEST))
        let formatItem = URLQueryItem(name: "format", value: "comic")
        let orderItem = URLQueryItem(name: "orderBy", value: "title")

        var itemsArray = [tsItem, apiKeyItem, hashItem, limitItem, formatItem, orderItem]
        if offset != 0 {
            let offsetItem = URLQueryItem(name: "offset", value: String(offset))
            itemsArray.append(offsetItem)
        }
        urlComponents?.queryItems = itemsArray

        if let url  = urlComponents?.url {
            
            manager.request(url: url) { (result:Result<ComicModel,Error>) in
                switch(result) {
                case .success(let comicModel):
                    if let results = comicModel.data?.results
                    {
                        let comicVMResult =  self.convertResults(results: results)
                        self.comicVM.value.append(contentsOf: comicVMResult)
                    }
                    
                    break
                case .failure(let error):
                    self.errorHandler?(error)
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
    
    private func convertResults(results:[Results]) -> [ComicInfoViewModel] {
        let comicVMResult = (results.compactMap({ result -> ComicInfoViewModel in
            let title =  result.title ?? ""
            let description = result.description ?? ""
            let imagePath = result.thumbnail?.path ?? ""
            let imageExtension = result.thumbnail?.thumbnailExtension ?? ""
            let fullImageURL = "\(imagePath).\(imageExtension)"
            let pageCount = result.pageCount ?? -1
            
            
            var imagesURL:[String] = []
            if let images = result.images {
                images.forEach { imageInfo in
                    if let path = imageInfo.path, let ext = imageInfo.thumbnailExtension {
                        imagesURL.append("\(path).\(ext)")
                    }
                }
            }
            
            var creatorsList:[[String:String]] = []
            if let creatorOBj = result.creators, let items = creatorOBj.items  {
                items.forEach { item in
                    if let name = item.name, let role = item.role {
                        creatorsList.append([role : name])
                    }
                }
            }
            
            return ComicInfoViewModel(title: title,
                                      description: description,
                                      thumbnail: fullImageURL,
                                      creators:creatorsList,
                                      images:imagesURL,
                                      pageCount: pageCount
            )
        }))
        
        return comicVMResult
    }
 
    func reloadDataIfNeeded(action:@escaping ()->()){
        self.comicVM.bind {_ in
            action()
        }
    }
    
    func getCount() -> Int {
        return comicVM.value.count
    }
    
    func getCellVM(at index:Int) -> ItemDetailProtocol {
        return comicVM.value[index]
    }
    
   
    
    mutating func errorHandler(onError: @escaping (Error) -> Void) {
        self.errorHandler = onError
    }
    
    func getHeaderImage() -> UIImage {
        return self.headerImage
    }

}
