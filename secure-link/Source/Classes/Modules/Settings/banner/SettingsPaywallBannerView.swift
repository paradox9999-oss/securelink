//
//  SettingsPaywallBannerView.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import UIKit

class SettingsPaywallBannerView: UIView {

    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let containerView = UIView()
        let hStack = ViewFactory.stack(.horizontal, spacing: 4)
        let vStack = ViewFactory.stack(.vertical, spacing: 4)
        let logoView = UIImageView(image: Asset.settingsPaywallDizzy.image)
        logoView.contentMode = .scaleAspectFit
        let titleLabel = ViewFactory.label(
            font: FontFamily.RedHatDisplay.extraBold.font(size: 24),
            color: .white
        )
        let subtitleLabel = ViewFactory.label(
            font: FontFamily.RedHatDisplay.regular.font(size: 12),
            color: .white
        )
        titleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "Go Premium now"
        subtitleLabel.text = "2 easy steps for total protection"
        containerView.rounded(radius: 16)
        containerView.backgroundColor = Asset.mainPrimary.color
        
        hStack.alignment = .center
        
        addSubview(containerView)
        containerView.addSubview(hStack)
        hStack.addArrangedSubview(vStack)
        hStack.addArrangedSubview(UIView())
        hStack.addArrangedSubview(logoView)
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(subtitleLabel)
        
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().inset(24)
        }
        hStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.bottom.equalToSuperview().inset(12)
        }
    }

}
