//
//  ComicTableViewCell.swift
//  MarvelAPI
//
//  Created by German Huerta on 27/08/21.
//

import Foundation
import UIKit

class ComicTableViewCell: UITableViewCell {
    static let cellID = "ComicCell"
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var shadowContainerView: UIView!

    private var vm:ItemDetailProtocol!
    
    func config(with vm:ItemDetailProtocol) {
        self.vm = vm
        titleLabel.text = self.vm.title
        self.thumbnailImageView.downloadImage(url: self.vm.thumbnail, placeHolder: UIImage(named: "marvel_logo")!)
    }
    
}
