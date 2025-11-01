import UIKit
import SnapKit

final class RegisterViewController: UIViewController {

    // MARK: - UI
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.keyboardDismissMode = .onDrag
        return sv
    }()

    private let contentStack = UIStackView()

    private let logoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "odds-logo"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome back"
        lbl.font = .systemFont(ofSize: 28, weight: .bold)
        lbl.textAlignment = .center
        return lbl
    }()

    private let subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Log in to continue"
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = .secondaryLabel
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()

    private let usernameField = AuthTextField(placeholder: "Email or username", keyboardType: .emailAddress, isSecure: false)
    private let passwordField = AuthTextField(placeholder: "Password", keyboardType: .default, isSecure: true)

    private let forgotButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Forgot password?", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        btn.contentHorizontalAlignment = .trailing
        return btn
    }()

    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log In", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        btn.backgroundColor = .systemBlue
        btn.tintColor = .white
        btn.layer.cornerRadius = 12
        return btn
    }()

    private let orLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "or continue with"
        lbl.textAlignment = .center
        lbl.textColor = .secondaryLabel
        lbl.font = .systemFont(ofSize: 13, weight: .regular)
        return lbl
    }()

    private let socialStack = UIStackView()

    private let fbButton = SocialButton(imageName: "facebook-icon")
    private let googleButton = SocialButton(imageName: "google-icon")
    private let appleButton = SocialButton(imageName: "apple-icon")
    // Bottom bar
    private let bottomBar = UIView()
    private let bottomTextLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Don’t have an account?"
        lbl.textColor = .secondaryLabel
        lbl.font = .systemFont(ofSize: 15)
        return lbl
    }()
    private let signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        return btn
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        setupActions()
    }

    // MARK: - Layout
    private func setupLayout() {
        // ScrollView
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        view.addSubview(bottomBar)
        bottomBar.backgroundColor = .systemBackground
        bottomBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.greaterThanOrEqualTo(50)
        }

        bottomBar.addSubview(bottomTextLabel)
        bottomBar.addSubview(signUpButton)

        bottomTextLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-30)
        }
        signUpButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomTextLabel)
            make.left.equalTo(bottomTextLabel.snp.right).offset(6)
        }

        contentStack.axis = .vertical
        contentStack.spacing = 16
        scrollView.addSubview(contentStack)

        contentStack.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(24)
            make.leading.equalTo(scrollView.frameLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(scrollView.frameLayoutGuide.snp.trailing).inset(20)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom).inset(24)
        }

        contentStack.snp.makeConstraints { make in
            make.width.equalTo(scrollView.frameLayoutGuide.snp.width).inset(20)
        }

        contentStack.addArrangedSubview(logoImageView)
        contentStack.setCustomSpacing(24, after: titleLabel)
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(subtitleLabel)
        contentStack.setCustomSpacing(24, after: subtitleLabel)
        contentStack.addArrangedSubview(usernameField)
        contentStack.addArrangedSubview(passwordField)
        contentStack.addArrangedSubview(forgotButton)
        contentStack.addArrangedSubview(loginButton)
        contentStack.setCustomSpacing(22, after: loginButton)
        contentStack.addArrangedSubview(orLabel)
        contentStack.addArrangedSubview(socialStack)

        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.height.equalTo(36)
        }
        usernameField.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(16)
        }
        passwordField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        forgotButton.contentHorizontalAlignment = .trailing

        let socialContainer = UIView()
        contentStack.addArrangedSubview(socialContainer)

        let icon: CGFloat = 44
        let gap: CGFloat = 12
        let totalWidth = icon * 3 + gap * 2

        socialStack.axis = .horizontal
        socialStack.spacing = gap
        socialStack.distribution = .fillEqually
        socialStack.alignment = .center

        // 3) Add buttons
        socialStack.addArrangedSubview(fbButton)
        socialStack.addArrangedSubview(googleButton)
        socialStack.addArrangedSubview(appleButton)

        socialContainer.addSubview(socialStack)
        socialStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.height.equalTo(icon)
            make.width.equalTo(totalWidth)
        }
        
        scrollView.contentInset.bottom = 20
        scrollView.verticalScrollIndicatorInsets.bottom = 20
        let bottomSpacer = UIView()
        bottomSpacer.backgroundColor = .clear
        contentStack.addArrangedSubview(bottomSpacer)
        bottomSpacer.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
    }

    // MARK: - Actions
    private func setupActions() {
       
    }
}

/// Rounded, padded text field for auth screens
final class AuthTextField: UITextField {
    init(placeholder: String, keyboardType: UIKeyboardType, isSecure: Bool) {
        super.init(frame: .zero)
        borderStyle = .none
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.separator.cgColor
        backgroundColor = .secondarySystemBackground
        textColor = .label
        font = .systemFont(ofSize: 16)
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecure

        let pad = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 10))
        leftView = pad
        leftViewMode = .always

        snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(44)
        }
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

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
