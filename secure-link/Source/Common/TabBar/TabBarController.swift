//
//  TabBarController.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import UIKit

class TabNavigationController: UINavigationController {

    let tabItem: TabItem
    
    init(tab: TabItem, root: UIViewController) {
        self.tabItem = tab
        super.init(rootViewController: root)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        self.tabBarItem.image = self.tabItem.icon
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
    }

}


class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override var selectedIndex: Int {
        didSet {
            self.customTabBarView.updateUI(selectedIndex: selectedIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.tabBar.isTranslucent = true
        self.tabBar.backgroundColor = .clear
        self.tabBar.tintColor = .clear
        
        addCustomTabBarView()
        hideTabBarBorder()

        self.customTabBarView.didSelect = { [weak self] index in
            self?.selectedIndex = index
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = ""
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private lazy var customTabBarView: TabbarView = {
        var view = TabbarView()
        return view
    }()

    private func addCustomTabBarView() {
        self.tabBar.isHidden = true
        self.view.addSubview(customTabBarView)
        customTabBarView.snp.makeConstraints { make in
            make.top.equalTo(self.tabBar.snp.top)
            make.centerX.equalToSuperview()
        }
    }
    
    func set(items: [TabNavigationController]) {
        self.customTabBarView.set(items: items.map({ $0.tabItem }))
        self.setViewControllers(items, animated: false)
    }
    
    func hideTabBarBorder()  {
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
//        self.tabBar.clipsToBounds = true
    }
    
}
