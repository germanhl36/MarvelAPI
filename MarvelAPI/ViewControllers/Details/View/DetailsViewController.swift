//
//  DetailsViewController.swift
//  MarvelAPI
//
//  Created by German Huerta on 28/08/21.
//

import Foundation
import UIKit

class DetailsViewController: BaseViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var imagesTitleLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    private var thumbnailHeight:CGFloat = 140.0
    private let sectionInsets = UIEdgeInsets(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0)

    private var vm:ItemDetailProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailsViewController {
    func config(withVM vm:ItemDetailProtocol){
        self.vm = vm
    }
}

extension DetailsViewController {
    private func setupUI() {
        self.imagesCollectionView.reloadData()

        self.thumbnailImageView.downloadImage(url: self.vm.getThumbnail(), placeHolder: UIImage(named: "marvel_logo")!)

        let content = NSMutableAttributedString()
        content.append(self.vm.getTitle())
        content.append(NSAttributedString(string: "\n\n"))
        
        content.append(self.vm.getDescription())
        content.append(NSAttributedString(string: "\n\n"))
        if self.vm.getPageCount() != 0 {
            content.append(self.vm.getPageCount())
            content.append(NSAttributedString(string: "\n\n"))
        }
        let creatorList = self.vm.getCreators()
        creatorList.forEach { attStr in

            content.append(attStr)
            content.append(NSAttributedString(string: "\n\n"))

        }

        
        contentTextView.attributedText = content
        var imageRect = self.thumbnailImageView.frame
        imageRect.origin.x = imageRect.origin.x - 5

        imageRect.origin.y = imageRect.origin.y - 15
        let imageFrame = UIBezierPath(rect: imageRect)
        contentTextView.textContainer.exclusionPaths = [imageFrame]
        
        let fixedWidth = contentTextView.frame.size.width
        let newSize = contentTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newHeight = newSize.height + 20
        if newHeight < thumbnailHeight {
            newHeight = thumbnailHeight + 20
        }
        contentTextView.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
        contentTextView.layoutIfNeeded()
        
        if self.vm.getImages().count == 0 {
            self.imagesTitleLabel.isHidden = true
        }
        
        scrollContentView.layoutIfNeeded()
        scrollView.layoutIfNeeded()
        
        
    }
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm.getImages().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            fatalError()
        }
        let images = self.vm.getImages()
        cell.config(withImage: images[indexPath.row])
        
        return cell
    }
}
extension DetailsViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
      ) -> CGSize {
        // 2
       let imageWidth = 100
        let imageHeight = 140
        return CGSize(width: imageWidth, height: imageHeight)
      }
    
    // 3
     func collectionView(
       _ collectionView: UICollectionView,
       layout collectionViewLayout: UICollectionViewLayout,
       insetForSectionAt section: Int
     ) -> UIEdgeInsets {
       return sectionInsets
     }
     
     // 4
     func collectionView(
       _ collectionView: UICollectionView,
       layout collectionViewLayout: UICollectionViewLayout,
       minimumLineSpacingForSectionAt section: Int
     ) -> CGFloat {
       return 10
     }
}
