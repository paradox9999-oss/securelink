//
//  PaywallViewController.swift
//  secure-link
//
//  Created by Александр on 04.07.2025.
//

import UIKit

class OptionView: UIView {
    
    enum Option: CaseIterable {
        case unlimitedBandwidth
        case fasterServers
        case wifiSecurity
        case exclusive
        case adfree
        
        var subtitle: String {
            switch self {
                case .unlimitedBandwidth: return "Unlimited Bandwidth"
                case .fasterServers: return "Faster Servers"
                case .wifiSecurity: return "Wi-Fi Security Check Pro"
                case .exclusive: return "Exclusive Locations"
                case .adfree: return "Ad-Free Experience"
            }
        }
        var title: String {
            switch self {
                case .unlimitedBandwidth: return "❤️‍🔥"
                case .fasterServers: return "🚀"
                case .wifiSecurity: return "🔐"
                case .exclusive: return "🧭"
                case .adfree: return "🚫"
            }
        }
    }
    
    private lazy var leftTitleLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.RedHatDisplay.semiBold.font(size: 20),
            color: .white
        )
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.snp.makeConstraints { make in
            make.width.equalTo(24)
        }
        return label
    }()
    private lazy var rightTitleLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.RedHatDisplay.semiBold.font(size: 20),
            color: .white
        )
        label.adjustsFontSizeToFitWidth = true
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        common()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func common() {
        let hStack = ViewFactory.stack(.horizontal, spacing: 16)
        hStack.alignment = .top
        addSubview(hStack)
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        hStack.addArrangedSubview(leftTitleLabel)
        hStack.addArrangedSubview(rightTitleLabel)
    }
    
    func configure(icon: String, title: String) {
        self.leftTitleLabel.text = icon
        self.rightTitleLabel.text = title
    }
    
}

class PaywallViewController: UIViewController, Loadable, Toastable {

    var viewModel: PaywallViewModel?
    
    private lazy var productStack: UIStackView = {
        var view = ViewFactory.stack(.vertical, spacing: 12)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBindings()
        viewModel?.viewDidLoad()
        showProducts()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        self.view.backgroundColor = Asset.mainBg.color
        let bgView = UIImageView(image: Asset.paywallBg.image)
        let circleView = UIImageView(image: Asset.paywallCircle.image)
        bgView.contentMode = .scaleAspectFill
        circleView.contentMode = .scaleAspectFit
        
        self.view.addSubview(bgView)
        self.view.addSubview(circleView)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        circleView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(12)
        }
        
        let vStack = ViewFactory.stack(.vertical, spacing: 32)
        view.addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(32)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        
        let topStack = ViewFactory.stack(.horizontal, spacing: 10)
        let dismissButton = UIButton(type: .custom)
        dismissButton.setImage(Asset.paywallDismiss.image, for: .normal)
        dismissButton.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        dismissButton.addAction(UIAction.init(handler: { [weak self] action in
            self?.dismiss(animated: true)
        }), for: .touchUpInside)
        topStack.addArrangedSubview(dismissButton)
        topStack.addArrangedSubview(UIView())
        
        let centerStack: UIStackView = {
            let view = ViewFactory.stack(.horizontal, spacing: 32)
            let rightStackView = ViewFactory.stack(.vertical, spacing: 4)
            rightStackView.distribution = .equalSpacing
            
            let titleView = UIImageView(image: Asset.paywallUnlock.image)
            titleView.contentMode = .scaleAspectFit
            
            let titleLabel = ViewFactory.label(
                font: FontFamily.RedHatDisplay.bold.font(size: 42),
                color: .white
            )
            titleLabel.numberOfLines = 3
            titleLabel.adjustsFontSizeToFitWidth = true
            titleLabel.text = "Premium Security & Privacy"
            
            rightStackView.addArrangedSubview(titleLabel)
//            rightStackView.addArrangedSubview(UIView())
            
            view.addArrangedSubview(titleView)
            view.addArrangedSubview(rightStackView)
            
            OptionView.Option.allCases.forEach { option in
                let optionView = OptionView()
                optionView.configure(icon: option.title, title: option.subtitle)
                optionView.setContentHuggingPriority(.defaultLow, for: .vertical)
                optionView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
                rightStackView.addArrangedSubview(optionView)
            }
            
            return view
        }()
        
        let termsView: UIView = {
            let view = ViewFactory.stack(.horizontal, spacing: 4)
            view.distribution = .equalSpacing
            view.alignment = .center
            
            let privacy = UIButton(type: .system)
            privacy.titleLabel?.font = FontFamily.RedHatDisplay.regular.font(size: 12)
            privacy.setTitleColor(Asset.mainLightBlue.color, for: .normal)
            privacy.setTitle("Privacy Policy", for: .normal)
            privacy.addAction(UIAction(handler: { [weak self] action in
                self?.viewModel?.didTap(state: .privacy)
            }), for: .touchUpInside)

            let restore = UIButton(type: .system)
            restore.titleLabel?.font = FontFamily.RedHatDisplay.regular.font(size: 12)
            restore.setTitleColor(Asset.mainLightBlue.color, for: .normal)
            restore.setTitle("Restore purchase", for: .normal)
            privacy.addAction(UIAction(handler: { [weak self] action in
                self?.viewModel?.didTap(state: .restore)
            }), for: .touchUpInside)
            
            let terms = UIButton(type: .system)
            terms.titleLabel?.font = FontFamily.RedHatDisplay.regular.font(size: 12)
            terms.setTitleColor(Asset.mainLightBlue.color, for: .normal)
            terms.setTitle("Terms of use", for: .normal)
            privacy.addAction(UIAction(handler: { [weak self] action in
                self?.viewModel?.didTap(state: .terms)
            }), for: .touchUpInside)
            
            let spacerView = UIView()
            spacerView.backgroundColor = Asset.mainLightBlue.color
            spacerView.snp.makeConstraints { make in
                make.width.equalTo(0.5)
                make.height.equalTo(16)
            }
            
            let spacerView2 = UIView()
            spacerView2.backgroundColor = Asset.mainLightBlue.color
            spacerView2.snp.makeConstraints { make in
                make.width.equalTo(0.5)
                make.height.equalTo(16)
            }
            
            view.addArrangedSubview(privacy)
            view.addArrangedSubview(spacerView)
            view.addArrangedSubview(restore)
            view.addArrangedSubview(spacerView2)
            view.addArrangedSubview(terms)
            
            return view
        }()
        
        vStack.addArrangedSubview(topStack)
        vStack.addArrangedSubview(centerStack)
        vStack.addArrangedSubview(UIView())
        vStack.addArrangedSubview(productStack)
        vStack.addArrangedSubview(termsView)
        
    }
    
    func showProducts() {
        productStack.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        self.viewModel?.dipslayProducts.forEach { product in
            let button = UIButton(type: .system)
            if product.hasIntroOffer == true {
                button.backgroundColor = Asset.mainPrimary.color
            } else {
                button.backgroundColor = Asset.mainBg.color
            }
            button.accessibilityLabel = product.id
            let title: String = product.name
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = FontFamily.RedHatDisplay.bold.font(size: 18)
            button.setTitleColor(.white, for: .normal)
            button.snp.makeConstraints { make in
                make.height.equalTo(56)
            }
            button.addAction(UIAction(handler: { [weak self] action in
                self?.viewModel?.payTapped(productId: product.id)
            }), for: .touchUpInside)
            button.layoutIfNeeded()
            button.rounded(radius: 28)
            
            productStack.addArrangedSubview(button)
        }
    }
    
    func setupBindings() {
        viewModel?.didLoading = { [weak self] isLoaded in
            isLoaded ? self?.startLoading() : self?.stopLoading()
        }
        viewModel?.didShowError = { [weak self] errorString in
            self?.showToast(message: errorString)
        }
        viewModel?.didDismiss = { [weak self] in
            DispatchQueue.main.async {
                self?.dismiss(animated: true)
            }
        }
    }

}
