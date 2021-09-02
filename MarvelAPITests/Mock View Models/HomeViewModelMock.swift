//
//  HomeViewModelMock.swift
//  MarvelAPITests
//
//  Created by German Huerta on 31/08/21.
//

import Foundation
@testable import MarvelAPI

struct HomeViewModelMock:TableContentProtocol {

    
    private var items:Box<[ItemDetailProtocol]> = Box<[ItemDetailProtocol]>([])
    private var errorHandler:((Error) -> ())?
    private var headerImage:String!
    private var selectionHandler:((Int) ->())?

    
    func getItems(offset: Int) {
        let url = Bundle(for: MarvelAPITests.self).url(forResource: "ComicsAPIResponse", withExtension: "json")
        guard let dataURL = url, let data = try? Data(contentsOf: dataURL) else {
             fatalError("Couldn't read data.json file")
        }
        do {
            let decoder = JSONDecoder()
            let comicModel = try decoder.decode(ComicModel.self, from: data)
            if let results = comicModel.data?.results {
                self.items.value = self.convertResults(results: results)

            }
        }catch {
            
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
            
            var creatorsList:[(name:String, title:String)] = []
            if let creatorOBj = result.creators, let items = creatorOBj.items  {
                items.forEach { item in
                    if let name = item.name, let role = item.role {
                        creatorsList.append((name: name, title: role))
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
    
    func getHeaderImage() -> String {
        return self.headerImage
    }
    
    mutating func setHeaderImage(imageName name: String) {
        self.headerImage = name
    }
    
    
    func reloadDataIfNeeded(action:@escaping ()->()){
        self.items.bind {_ in
            action()
        }
    }
    
    func getCount() -> Int {
        return items.value.count
    }
    
    func getItemVM(at index:Int) -> ItemDetailProtocol {
        return items.value[index]
    }
    
    mutating func errorHandler(onError: @escaping (Error) -> Void) {
        self.errorHandler = onError
    }

    mutating func selectionHandler(onItemSelected: @escaping (Int) -> Void) {
        self.selectionHandler = onItemSelected
    }
    
    func itemSelected(atIndex index: Int) {
        self.selectionHandler?(index)
    }
}
