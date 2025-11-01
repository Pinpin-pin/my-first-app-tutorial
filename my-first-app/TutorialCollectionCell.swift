//
//  TutorialCollectionCell.swift
//  my-first-app
//
//  Created by pinpinpin on 1/11/2568 BE.
//

import UIKit

class TutorialCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }

    func setupImage(imageName: String) {
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
    }
}
