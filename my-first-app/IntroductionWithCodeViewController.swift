//
//  ViewController.swift
//  my-first-app
//
//  Created by pinpinpin on 1/11/2568 BE.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class IntroductionWithCodeViewController: UIViewController {
    
//    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var pageControl: UIPageControl!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var subtitleLabel: UILabel!
//    @IBOutlet weak var registerButton: UIButton!
//    var window: UIWindow?
    
    public let disposeBag = DisposeBag()
    //    Use PDF for icons/line art that must look sharp at any size (toolbars, onboarding illustrations).
    //    Use PNG/JPEG for photos/bitmaps or artwork with complex gradients/textures.
    let introImages = ["introduction-1", "introduction-2", "introduction-3"]
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(UINib(nibName: "TutorialCollectionCell", bundle: nil),
                    forCellWithReuseIdentifier: "TutorialCollectionCell")
        return cv
    }()

    private let pageControl = UIPageControl()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    
    private let registerButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.setTitle("Register", for: .normal)
        button.backgroundColor = UIColor(red: 118/255, green: 157/255, blue: 173/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    
//    MARK: Traditional Way of Code Constraint Implementation
    private let logoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "odds-logo"))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let closeButton = SocialButton(imageName: "close-icon")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindAction()
    }
    
    
    private func setupView() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(registerButton)
        view.addSubview(logoImageView)
        view.addSubview(closeButton)
        view.backgroundColor = .white
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(140)
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
        }
        
        closeButton.tintColor = .secondaryLabel
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.trailing.equalToSuperview().inset(24)
            make.width.height.equalTo(44)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        pageControl.numberOfPages = introImages.count
        pageControl.pageIndicatorTintColor = UIColor(red: 122/255, green: 158/255, blue: 174/255, alpha: 1)
        pageControl.currentPageIndicatorTintColor = UIColor(red: 75/255, green: 140/255, blue: 169/255, alpha: 1)
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        
        registerButton.tintColor = UIColor(red: 118/255, green: 157/255, blue: 173/255, alpha: 1)
        
        registerButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
    }
    
    private func bindAction() {
        titleLabel.text = "Lorem Ipsum"
        subTitleLabel.text = "Lorem Ipsum is a dummy text used as placeholder"
        registerButton.rx.tap.observe(on: MainScheduler.instance)
            .bind { [weak self] in
                guard let self = self else { return }
                let vc = RegisterViewController()

                if let nav = self.navigationController {
                    nav.pushViewController(vc, animated: true)
                } else {
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    self.present(nav, animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        closeButton.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)
    }
}

extension IntroductionWithCodeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
        if !pageIndex.isNaN {
            pageControl.currentPage = Int(pageIndex)
        } else {
            pageControl.currentPage = 0
        }
    }
}

