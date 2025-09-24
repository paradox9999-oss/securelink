//
//  HomeServerView.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import UIKit

class HomeServerView: UIView {

    private lazy var iconView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = Asset.homeFastetServer.image
        return view
    }()
    private lazy var signalView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var arrowView: UIImageView = {
        var view = UIImageView()
        view.image = Asset.chevronRight.image
        view.contentMode = .center
        return view
    }()
    private lazy var titleLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.RedHatDisplay.medium.font(size: 16),
            color: Asset.mainLightBlue.color
        )
        label.text = "Select Server"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let containerView = UIView()
        containerView.backgroundColor = Asset.mainAdditional.color
        containerView.rounded(radius: 20)
        
        let hStack = ViewFactory.stack(.horizontal, spacing: 12)
        
        addSubview(containerView)
        containerView.addSubview(hStack)
        
        hStack.addArrangedSubview(iconView)
        hStack.addArrangedSubview(titleLabel)
        hStack.addArrangedSubview(signalView)
        hStack.addArrangedSubview(arrowView)
        
        iconView.snp.makeConstraints { make in
            make.size.equalTo(32)
        }
        signalView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        arrowView.snp.makeConstraints { make in
            make.width.equalTo(16)
        }
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        hStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(string: String) {
        self.titleLabel.text = string
    }
    
    func configure(cred: Country?) {
        if let cred = cred {
            self.iconView.sd_setImage(with: URL.init(string: "https://flagsapi.com/\(cred.flag)/flat/64.png"))
            self.titleLabel.text = cred.country
        } else {
            self.titleLabel.text = "Select Server"
            self.iconView.image = Asset.homeFastetServer.image
        }
    }

}
