//
//  MainViewController.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import UIKit

class HomeViewController: ViewController {

    var viewModel: HomeViewModel?
    
    private lazy var topServerView: HomeServerView = {
        let view = HomeServerView()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeServer))
        view.addGestureRecognizer(tapRecognizer)
        
        return view
    }()
    private lazy var connectionLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.RedHatDisplay.medium.font(size: 18),
            color: Asset.mainGrey.color
        )
        label.text = "Not Connection"
        label.textAlignment = .center
        return label
    }()
    private lazy var timeLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.RedHatDisplay.bold.font(size: 32),
            color: Asset.mainGrey.color
        )
        label.text = "00:00:00"
        label.textAlignment = .center
        return label
    }()
    private lazy var connectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Connect best server", for: .normal)
        button.titleLabel?.font = FontFamily.RedHatDisplay.medium.font(size: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Asset.mainPrimary.color

        button.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.viewModel?.connectTapped()
        }), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBindings()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = ""
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        connectButton.layoutIfNeeded()
        connectButton.rounded()
    }
    
    private func setupUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let vStack = ViewFactory.stack(.vertical, spacing: 30)
        let connectionStack = ViewFactory.stack(.vertical, spacing: 6)
        let shieldView = UIImageView(image: Asset.homeShield.image)
        let utilityView = UIView()
//        utilityView.backgroundColor = .blue
        vStack.alignment = .center
        
        view.addSubview(vStack)
        vStack.addArrangedSubview(topServerView)
        vStack.addArrangedSubview(shieldView)
        vStack.addArrangedSubview(connectionStack)
        vStack.addArrangedSubview(utilityView)
        vStack.addArrangedSubview(connectButton)
        connectionStack.addArrangedSubview(connectionLabel)
        connectionStack.addArrangedSubview(timeLabel)
        
        vStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(32)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(24)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(60)
        }
        shieldView.snp.makeConstraints { make in
            make.height.equalTo(272)
        }
        topServerView.snp.makeConstraints { make in
            make.width.equalTo(280)
            make.height.equalTo(56)
        }
        connectButton.snp.makeConstraints { make in
            make.width.equalTo(vStack.snp.width)
        }
        utilityView.snp.makeConstraints { make in
            make.width.equalTo(vStack.snp.width)
        }
    }
    
    private func setupBindings() {
        self.viewModel?.didUpdate = { [weak self] cred in
            DispatchQueue.main.async {
                self?.topServerView.configure(cred: cred)
            }
        }
        self.viewModel?.didChangeStatus = { [weak self] status in
            self?.connectionLabel.text = status.title
//            self?.connectView.state = status
            
            switch status {
            case .connect:
                self?.connectButton.setTitle("Disconnect", for: .normal)
                self?.connectButton.setTitleColor(Asset.mainSecondary.color, for: .normal)
                self?.connectButton.bordered(width: 1, color: Asset.mainSecondary.color)
                self?.connectButton.setTitleColor(Asset.mainSecondary.color, for: .normal)
                self?.connectButton.backgroundColor = .clear
            case .disconnect:
                self?.connectButton.setTitle("Connect best server", for: .normal)
                self?.connectButton.setTitleColor(.white, for: .normal)
                self?.connectButton.backgroundColor = Asset.mainPrimary.color
                self?.connectButton.layer.borderWidth = 0
            case .connecting:
                self?.connectButton.setTitle("Connecting best server", for: .normal)
                self?.connectButton.setTitleColor(Asset.mainPurple.color, for: .normal)
                self?.connectButton.backgroundColor = .clear
                self?.connectButton.layer.borderWidth = 0
                self?.connectButton.setTitleColor(Asset.mainSecondary.color, for: .normal)
            case .disconnecting:
                self?.connectButton.setTitle("Disconnecting...", for: .normal)
                self?.connectButton.setTitleColor(Asset.mainPurple.color, for: .normal)
                self?.connectButton.backgroundColor = .clear
                self?.connectButton.layer.borderWidth = 0
                self?.connectButton.setTitleColor(Asset.mainSecondary.color, for: .normal)
            }
        }
        self.viewModel?.didShowError = { [weak self] errorString in
            self?.showToast(message: errorString)
        }
        self.viewModel?.didCheckSpeed = { [weak self] (download, upload) in
            DispatchQueue.main.async {
//                self?.downloadView.configure(type: .download, value: download)
//                self?.uploadView.configure(type: .upload, value: upload)
            }
        }
        self.viewModel?.didUpdateTime = { [weak self] time in
            if let time = time {
                self?.timeLabel.attributedText = AttributedTextFactory.attributed(
                    string: time,
                    font: FontFamily.RedHatDisplay.bold.font(size: 32),
                    colors: [Asset.mainBlue.color, Asset.mainPink.color]
                )
            } else {
                self?.timeLabel.attributedText = nil
                self?.timeLabel.text = "00:00:00"
            }

        }
    }
    
    @objc
    private func changeServer() {
        self.viewModel?.selectServerTapped()
    }

}
