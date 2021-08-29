//
//  ImageView+Extensions.swift
//  MarvelAPI
//
//  Created by German Huerta on 27/08/21.
//

import Foundation
import UIKit
extension UIImageView {
    
    func downloadImage(url urlString:String, placeHolder:UIImage){
        if self.image == nil{
            self.image = placeHolder
        }
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error  in
            if error != nil {
                return
            } else if let data = data {
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.image = image
                }
                
            }
        }.resume()
    }
}
