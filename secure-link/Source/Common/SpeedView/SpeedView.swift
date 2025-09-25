//
//  SpeedView.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import UIKit

enum SpeedType {
    case download
    case upload

    var icon: UIImage {
        switch self {
        case .download:
            return Asset.homeDownload.image
        case .upload:
            return Asset.homeUpload.image
        }
    }
    var title: String {
        switch self {
        case .download:
            return "Download"
        case .upload:
            return "Upload"
        }
    }
}

class SpeedView: UIView {

    private lazy var directionView: UIImageView = {
        var view = UIImageView()
        return view
    }()
    private lazy var valueLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.RedHatDisplay.medium.font(size: 16),
            color: .white
        )
        label.text = "-"
        return label
    }()
    private lazy var typeLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.RedHatDisplay.regular.font(size: 14),
            color: Asset.mainGrey.color
        )
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
        let hStack = ViewFactory.stack(.horizontal, spacing: 12)
        let vStack = ViewFactory.stack(.vertical, spacing: 4)
        
        hStack.alignment = .center
        
        addSubview(hStack)
        hStack.addArrangedSubview(directionView)
        hStack.addArrangedSubview(vStack)
        vStack.addArrangedSubview(valueLabel)
        vStack.addArrangedSubview(typeLabel)
        
        directionView.snp.makeConstraints { make in
            make.size.equalTo(42)
        }
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func set(type: SpeedType) {
        self.directionView.image = type.icon
        self.typeLabel.text = type.title
    }
    
    func set(value: String) {
        self.valueLabel.text = value
    }

}
