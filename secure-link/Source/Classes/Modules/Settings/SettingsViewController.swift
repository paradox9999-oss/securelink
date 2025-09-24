//
//  SettingsViewController.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import UIKit

class SettingsViewController: ViewController {

    var viewModel: SettingsViewModel?
    
    private lazy var headerBanner: UIView = {
        var view = SettingsPaywallBannerView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 136)

        let tapRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(paywallDidTapped)
        )
        view.addGestureRecognizer(tapRecognizer)
        
        return view
    }()
    private lazy var tableView: UITableView = {
        var view = UITableView(frame: .zero, style: .grouped)
        view.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
        view.register(FaceIDSettingCell.self, forCellReuseIdentifier: FaceIDSettingCell.identifier)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        view.separatorColor = Asset.mainGrey.color
        view.tableHeaderView = headerBanner
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "Settings"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    @objc
    private func paywallDidTapped() {
        viewModel?.bannerTapped()
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.groups.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = viewModel?.groups[section]
        return group?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let group = viewModel?.groups[indexPath.section]
        guard let item = group?.items[indexPath.row] else {
            return UITableViewCell()
        }
        
        switch item {
        case .faceId:
            if let cell = tableView.dequeueReusableCell(withIdentifier: FaceIDSettingCell.identifier) as? FaceIDSettingCell {
                cell.configure(item: item, isEnable: viewModel?.faceIdEnable ?? false)
                cell.didSwitch = { [weak self] in
                    self?.viewModel?.faceIdSwitched()
                }
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier) as? SettingCell {
                cell.configure(item: item)
                return cell
            }
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 14
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let group = viewModel?.groups[section]
        let view = UIView()
        let label = UILabel()
        let text = group?.title.uppercased() ?? ""
        let attributed = AttributedTextFactory.attributed(
            string: text,
            font: FontFamily.RedHatDisplay.bold.font(size: 10),
            colors: [Asset.mainPink.color, Asset.mainPurple.color]
        )
        label.attributedText = attributed
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview()
            make.left.equalToSuperview().inset(24)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelect(indexPath: indexPath)
    }
    
}
