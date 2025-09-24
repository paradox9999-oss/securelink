//
//  ServerCell.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import Foundation
import UIKit
import SDWebImage

class ServerCell: UITableViewCell {

    static let identifier = "ServerCell"

    private lazy var iconView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    private lazy var checkView: UIImageView = {
        var view = UIImageView()
        view.image = Asset.serversCheckCircle.image
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var signalView: UIImageView = {
        var view = UIImageView()
        view.image = Asset.serversGoodSignal.image
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var titleLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.RedHatDisplay.regular.font(size: 18),
            color: .white
        )
        label.text = "Germany"
        return label
    }()
    private lazy var iconContainerView: UIView = {
        var view = UIView()
        view.layer.masksToBounds = true
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.iconContainerView.layoutIfNeeded()
        self.iconContainerView.layer.cornerRadius = self.iconView.frame.height / 2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let containerView = UIView()
        contentView.addSubview(containerView)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let hStack = ViewFactory.stack(.horizontal, spacing: 16)
        containerView.addSubview(hStack)
        hStack.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(32)
            make.height.equalTo(32)
        }
        
        let iconContainerView = UIView()
        iconContainerView.clipsToBounds = true
        iconContainerView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let dividerView = UIView()
        dividerView.backgroundColor = Asset.mainGrey.color
        
        hStack.addArrangedSubview(iconContainerView)
        hStack.addArrangedSubview(titleLabel)
        hStack.addArrangedSubview(signalView)
        hStack.addArrangedSubview(checkView)
        containerView.addSubview(dividerView)
        
        iconContainerView.snp.makeConstraints { make in
            make.width.equalTo(iconContainerView.snp.height)
        }
        signalView.snp.makeConstraints { make in
            make.width.equalTo(23)
        }
        checkView.snp.makeConstraints { make in
            make.width.equalTo(20)
        }
        dividerView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
    }
    
    func configure(server: ServerCountry, isSelected: Bool) {
        self.titleLabel.text = server.country
        self.iconView.sd_setImage(with: URL.init(string: "https://flagsapi.com/\(server.flag)/flat/64.png"))
        self.checkView.image = isSelected ? Asset.serversCheckCircleFilled.image : Asset.serversCheckCircle.image
    }

}
