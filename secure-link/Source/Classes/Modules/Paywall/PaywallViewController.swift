//
//  PaywallViewController.swift
//  secure-link
//
//  Created by Александр on 04.07.2025.
//

import UIKit

class PaywallViewController: UIViewController {

    var viewModel: PaywallViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
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
        
    }

}
