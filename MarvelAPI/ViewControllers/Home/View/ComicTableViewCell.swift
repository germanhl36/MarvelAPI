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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pagesLabel: UILabel!

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var shadowContainerView: UIView!

    private var vm:ItemDetailProtocol!
    
    func config(with vm:ItemDetailProtocol) {
        self.vm = vm
        titleLabel.text = self.vm.getTitle().string
        descriptionLabel.text = self.vm.getDescription().string
        if self.vm.getPageCount() == 0 {
            pagesLabel.isHidden = true
        } else {
            pagesLabel.isHidden = false
        }
        pagesLabel.text = self.vm.getPageCount().string
        self.thumbnailImageView.downloadImage(url: self.vm.getThumbnail(), placeHolder: UIImage(named: "marvel_logo")!)
    }
    
}
