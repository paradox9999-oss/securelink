//
//  PinViewController.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import UIKit

class PinViewController: ViewController {

    var viewModel: PinViewModel?
    
    private lazy var pinControl: PinControlView = {
        var control = PinControlView(numberOfPages: PinViewModel.numberOfPins)
        control.configure(numberOfPages: PinViewModel.numberOfPins)
        return control
    }()
    private lazy var titleLabel: UILabel = {
        let label = ViewFactory.label(
            font: FontFamily.RedHatDisplay.medium.font(size: 24),
            color: .white
        )
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBindings()
        viewModel?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        let passcodeKeyboardView = PasscodeNumberView()
        passcodeKeyboardView.didTapKey = { [weak self] key in
            self?.viewModel?.keyButtonTapped(key: key)
        }
        passcodeKeyboardView.didBackTapped = { [weak self] in
            self?.viewModel?.backButtonTapped()
        }
        view.addSubview(passcodeKeyboardView)
        passcodeKeyboardView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(34)
            make.left.right.equalToSuperview()
        }
        
        if self.viewModel?.state == .enter {
            let faceIdButton = UIButton(configuration: .plain(), primaryAction: UIAction { [weak self] _ in
                self?.viewModel?.faceIDDidTap()
            })

            var config = UIButton.Configuration.plain()
            config.title = L10n.Pin.useFaceId
            config.image = Asset.pinFaceId.image
            config.imagePadding = 8
            config.imagePlacement = .leading
            config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
            config.baseForegroundColor = Asset.mainLightBlue.color
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: FontFamily.RedHatDisplay.medium.font(size: 16),
                .foregroundColor: Asset.mainLightBlue.color
            ]
            config.attributedTitle = AttributedString(L10n.Pin.useFaceId, attributes: AttributeContainer(attributes))
            
            faceIdButton.configuration = config

            view.addSubview(faceIdButton)
            faceIdButton.snp.makeConstraints { make in
                make.top.equalTo(passcodeKeyboardView.snp.bottom).inset(-24)
                make.centerX.equalToSuperview()
            }
        }
        
        view.addSubview(pinControl)
        pinControl.snp.makeConstraints { make in
            make.bottom.equalTo(passcodeKeyboardView.snp.top).inset(-44)
            make.centerX.equalToSuperview()
            make.height.equalTo(10)
        }
        
        view.addSubview(titleLabel)
        titleLabel.text = L10n.Pin.enterPasscode
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(pinControl.snp.bottom).inset(40)
            make.centerX.equalToSuperview()
        }
        
    }
    
    private func setupBindings() {
        self.viewModel?.didUpdateUI = { [weak self] in
            self?.titleLabel.text = self?.viewModel?.state.title
            if let inputNumberCount = self?.viewModel?.inputNumberCount {
                if inputNumberCount < 4 {
                    for index in inputNumberCount...3 {
                        self?.pinControl.unfill(page: index)
                    }
                }
                self?.pinControl.fill(page: inputNumberCount - 1)
            } else {
                self?.pinControl.unfill(page: 0)
                self?.pinControl.unfill(page: 1)
                self?.pinControl.unfill(page: 2)
                self?.pinControl.unfill(page: 3)
            }
        }
        self.viewModel?.didShowAlert = { [weak self] message in
            self?.showToast(message: message)
        }
    }
    

}
