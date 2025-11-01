import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class RegisterViewController: UIViewController {
    public let disposeBag = DisposeBag()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let closeButton = SocialButton(imageName: "close-icon")
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let firstNameField  = AuthTextField(placeholder: "First Name",  keyboardType: .default,      isSecure: false)
    private let lastNameField   = AuthTextField(placeholder: "Last Name",   keyboardType: .default,      isSecure: false)
    private let userNameField   = AuthTextField(placeholder: "User Name",   keyboardType: .default,      isSecure: false)
    private let emailField      = AuthTextField(placeholder: "Email",       keyboardType: .emailAddress, isSecure: false)
    private let passwordField   = AuthTextField(placeholder: "Password",    keyboardType: .default,      isSecure: true)
    private let confirmField    = AuthTextField(placeholder: "Confirm Password", keyboardType: .default, isSecure: true)
    private let createButton = UIButton(type: .system)
    private let bottomTextLabel = UILabel()
    private let loginButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutUI()
        wireActions()
    }

    private func layoutUI() {
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        view.addSubview(bottomTextLabel)
        view.addSubview(loginButton)

        scrollView.keyboardDismissMode = .onDrag
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(80)
        }

        closeButton.tintColor = .secondaryLabel
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.trailing.equalToSuperview().inset(24)
            make.width.height.equalTo(44)
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }

        [titleLabel, subtitleLabel, firstNameField, lastNameField, userNameField,
         emailField, passwordField, confirmField, createButton].forEach {
            contentView.addSubview($0)
        }

        titleLabel.text = "Let’s Get Started!"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textAlignment = .center

        subtitleLabel.text = "Create an account on ODDS| to get all features"
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0

        createButton.setTitle("Create Account", for: .normal)
        createButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        createButton.backgroundColor = UIColor(red: 118/255, green: 157/255, blue: 173/255, alpha: 1)
        createButton.tintColor = .white
        createButton.layer.cornerRadius = 12

        bottomTextLabel.text = "Already have an account?"
        bottomTextLabel.font = .systemFont(ofSize: 15)
        bottomTextLabel.textColor = .secondaryLabel

        loginButton.setTitle("Login here", for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        loginButton.tintColor = UIColor(red: 118/255, green: 157/255, blue: 173/255, alpha: 1)

        // form layout
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(titleLabel)
        }

        firstNameField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(48)
        }

        lastNameField.snp.makeConstraints { make in
            make.top.equalTo(firstNameField)
            make.leading.equalTo(firstNameField.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(firstNameField)
            make.height.equalTo(48)
        }

        userNameField.snp.makeConstraints { make in
            make.top.equalTo(firstNameField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }

        emailField.snp.makeConstraints { make in
            make.top.equalTo(userNameField.snp.bottom).offset(12)
            make.leading.trailing.height.equalTo(userNameField)
        }

        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(12)
            make.leading.trailing.height.equalTo(userNameField)
        }

        confirmField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(12)
            make.leading.trailing.height.equalTo(userNameField)
        }

        createButton.snp.makeConstraints { make in
            make.top.equalTo(confirmField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(userNameField)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(20)
        }

        bottomTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.centerX.equalToSuperview().offset(-40)
        }

        loginButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomTextLabel)
            make.leading.equalTo(bottomTextLabel.snp.trailing).offset(6)
        }
    }


    private func wireActions() {
        closeButton.rx.tap.subscribe(onNext: {
            self.onClose()
        }).disposed(by: disposeBag)
        
        loginButton.rx.tap.subscribe(onNext: {
            self.onLogin()
        }).disposed(by: disposeBag)
        
        createButton.rx.tap.subscribe(onNext: {
            self.onCreate()
        }).disposed(by: disposeBag)
    }

    private func onClose() {
        dismiss(animated: true)
    }

    private func onLogin() {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }

    private func onCreate() {
        guard let email = emailField.text, email.contains("@"),
              let p1 = passwordField.text, !p1.isEmpty,
              p1 == confirmField.text else {
            showAlert("Please check your email and confirm your password.")
            return
        }
        showAlert("Submitted! (demo)")
    }

    private func showAlert(_ message: String) {
        let ac = UIAlertController(title: "Register", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
