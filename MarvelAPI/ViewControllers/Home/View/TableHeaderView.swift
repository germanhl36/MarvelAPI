//
//  TableHeaderView.swift
//  MarvelAPI
//
//  Created by German Huerta on 29/08/21.
//

import Foundation
import UIKit

class TableHeaderView: UIView
{

    @IBOutlet weak var imageView: UIImageView!

    var image: UIImage? {
        didSet {
            if let image = image {
                imageView.image = image
            } else {
                imageView.image = nil
            }
        }
    }
}
