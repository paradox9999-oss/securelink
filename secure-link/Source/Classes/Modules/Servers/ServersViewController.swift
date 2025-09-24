//
//  ServersViewController.swift
//  secure-link
//
//  Created by Александр on 19.06.2025.
//

import UIKit

class ServersViewController: ViewController {

    var viewModel: ServersViewModel?
    
    private lazy var tableView: UITableView = {
        var view = UITableView(frame: .zero, style: .plain)
        view.register(ServerCell.self, forCellReuseIdentifier: ServerCell.identifier)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.separatorStyle = .none
//        view.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
//        view.separatorColor = Asset.mainGrey.color
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }

    private func setupUI() {
        self.navigationItem.title = "Servers"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
        }
    }

}

extension ServersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.servers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = self.viewModel?.servers[indexPath.row] else {
            return UITableViewCell()
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: ServerCell.identifier) as? ServerCell {
            let isSelected = item.id == self.viewModel?.selectServer
            cell.configure(server: item, isSelected: isSelected)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = self.viewModel?.servers[indexPath.row] else {
            return
        }
        
        self.viewModel?.didSelectServer(id: item.id)
        self.tableView.reloadData()
    }
    
}
