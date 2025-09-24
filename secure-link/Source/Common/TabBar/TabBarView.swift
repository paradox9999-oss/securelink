//
//  TabBarView.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import Foundation
import UIKit

class TabbarView: UIView {
    
    var didSelect: ((Int) -> Void)?
    
    private lazy var hStackView: UIStackView = {
        var view = ViewFactory.stack(.horizontal, spacing: 32)
        view.distribution = .fillEqually
        return view
    }()
    private var buttons: [UIButton] = []
    
    init() {
        super.init(frame: .zero)
        common()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func common() {
        let contentView = UIView()
        contentView.rounded(radius: 16)
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        contentView.backgroundColor = Asset.mainAdditional.color
        contentView.addSubview(hStackView)
        
        hStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.top.bottom.equalToSuperview().inset(8)
        }
                
        self.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func set(items: [TabItem]) {
        for (index, item) in items.enumerated() {
            let button = UIButton(type: .custom)
            button.setImage(item.icon, for: .selected)
            button.setImage(item.unselectIcon, for: .normal)
            button.tag = index
            button.addTarget(
                self,
                action: #selector(onDidTapTabItem(sender:)),
                for: .touchUpInside
            )
            button.snp.makeConstraints { make in
                make.size.equalTo(42)
            }
            self.buttons.append(button)
            self.hStackView.addArrangedSubview(button)
        }
    }
    
    func updateUI(selectedIndex: Int) {
        self.buttons.forEach { button in
            button.isSelected = button.tag == selectedIndex
        }
    }
    
    @objc
    private func onDidTapTabItem(sender: UIButton) {
        self.didSelect?(sender.tag)
    }
    
}

enum TabItem {
    case home
    case settings
    
    var icon: UIImage {
        switch self {
            case .home:
                return Asset.tabHome.image
            case .settings:
                return Asset.tabSettings.image
        }
    }
    var unselectIcon: UIImage {
        switch self {
            case .home:
                return Asset.tabUnselectHome.image
            case .settings:
                return Asset.tabUnselectSettings.image
        }
    }
}
