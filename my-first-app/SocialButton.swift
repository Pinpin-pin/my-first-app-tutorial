//
//  UIButton+Extension.swift
//  my-first-app
//
//  Created by pinpinpin on 1/11/2568 BE.
//
import UIKit


/// Filled button with subtle border; uses SF Symbols for icon if provided
final class SocialButton: UIButton {
    init(imageName: String) {
        super.init(frame: .zero)
        
        let image = UIImage(named: imageName)
        setImage(image, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        clipsToBounds = true
        setTitle(nil, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Make it a perfect circle
        layer.cornerRadius = bounds.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
