//
//  ViewController.swift
//  my-first-app
//
//  Created by pinpinpin on 1/11/2568 BE.
//

import UIKit
import RxSwift
import RxCocoa
class IntroductionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    public let disposeBag = DisposeBag()
    //    Use PDF for icons/line art that must look sharp at any size (toolbars, onboarding illustrations).
    //    Use PNG/JPEG for photos/bitmaps or artwork with complex gradients/textures.
    let introImages = ["introduction-1", "introduction-2", "introduction-3"]
    
    
//    MARK: Traditional Way of Code Constraint Implementation
    private let logoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "odds-logo"))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addLogoImage()
        bindAction()
    }
    
    
    private func setupView() {
        collectionView.register(UINib(nibName: "TutorialCollectionCell", bundle: nil),
                                forCellWithReuseIdentifier: "TutorialCollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        
        pageControl.numberOfPages = introImages.count
        registerButton.tintColor = UIColor(red: 118/255, green: 157/255, blue: 173/255, alpha: 1)
    }
    
    private func addLogoImage() {
        view.addSubview(logoImageView)
        var constraints: [NSLayoutConstraint] = [
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 36),
            logoImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 140)
        ]
        if let img = logoImageView.image, img.size.height > 0 {
            let aspect = img.size.width / img.size.height
            constraints.append(
                logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: aspect)
            )
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    private func bindAction() {
        registerButton.rx.tap.subscribe(onNext: {
            let registerVC = RegisterViewController()
            registerVC.modalPresentationStyle = .fullScreen
            self.present(registerVC, animated: true)
        }).disposed(by: disposeBag)
    }
}

extension IntroductionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return introImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TutorialCollectionCell", for: indexPath) as? TutorialCollectionCell else {
            return UICollectionViewCell()
        }
        
        //
        //        cell.imageView.image = UIImage(named: introImages[indexPath.row])
        //        cell.imageView.contentMode = .scaleAspectFill
        
        cell.setupImage(imageName: introImages[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

