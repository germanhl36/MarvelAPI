//
//  ImageCollectionViewCell.swift
//  MarvelAPI
//
//  Created by German Huerta on 30/08/21.
//

import Foundation
import UIKit
class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "collectionCell"
    @IBOutlet private weak var imageView: UIImageView!
    
    func config(withImage image:String){
        self.imageView.downloadImage(url: image, placeHolder: UIImage(named: "marvel_logo")!)

    }

}
