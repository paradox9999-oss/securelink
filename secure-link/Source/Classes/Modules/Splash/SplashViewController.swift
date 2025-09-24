//
//  SplashViewController.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {

    var viewModel: SplashViewModel?
    
    private lazy var progressView: UIProgressView = {
        var view = UIProgressView()
        view.trackTintColor = Asset.mainAdditional.color
        view.progressTintColor = Asset.mainPrimary.color
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel?.viewDidLoad()
    }
    
    private func setupUI() {
        let logoView = UIImageView(image: Asset.logo.image)
        let backView = UIImageView(image: Asset.bg.image)
        let textContainerView = UIView()
        let descriptionLabel = ViewFactory.label(
            font: FontFamily.RedHatDisplay.semiBold.font(size: 20),
            color: .white
        )
        descriptionLabel.text = L10n.Splash.description
        descriptionLabel.textAlignment = .center
        backView.contentMode = .scaleAspectFill
        
        view.addSubview(backView)
        view.addSubview(logoView)
        view.addSubview(textContainerView)
        view.addSubview(progressView)
        textContainerView.addSubview(descriptionLabel)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        logoView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 243, height: 272))
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-74)
        }
        progressView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(20)
        }
        textContainerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.progressView.snp.top)
            make.top.equalTo(logoView.snp.bottom)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        DispatchQueue.main.asyncAfter(
            deadline: .now() + .milliseconds(250),
            execute: { [weak self] in
                self?.progressView.setProgress(1, animated: true)
                DispatchQueue.main.asyncAfter(
                    deadline: .now() + .milliseconds(1000),
                    execute: { [weak self] in
                        self?.viewModel?.progressDidLoad()
                    }
                )
            }
        )
    }
    
    var counter: Float = 0
    
    func animateProgressAnimation() {
        counter += 1
        let progress = counter / 8
        if counter < 8 {
            Timer.scheduledTimer(
                withTimeInterval: 0.25,
                repeats: false,
                block: { [weak self] completion in
                    self?.animateProgressAnimation()
                }
            )
        } else {
            self.viewModel?.progressDidLoad()
        }
        self.progressView.setProgress(progress, animated: true)
    }

}
