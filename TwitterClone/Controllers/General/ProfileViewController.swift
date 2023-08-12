//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by John Erick Santos on 12/8/2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    private var isStatusBarHidden: Bool = true
    
    // MARK: - Components
    
    private let profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let statusBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.opacity = 0
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        navigationItem.title = "Profile"
        view.addSubview(profileTableView)
        view.addSubview(statusBarView)
        
        let profileTableHeaderView = ProfileTableHeaderView(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: 380))
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.tableHeaderView = profileTableHeaderView
        profileTableView.contentInsetAdjustmentBehavior = .never
        
        navigationController?.navigationBar.isHidden = true
        
        configureConstraints()
    }
    
    // MARK: - Constraints
    
    private func configureConstraints() {
        let profileTableViewConstraints = [
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        let statusBarViewConstraints = [
            statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBarView.topAnchor.constraint(equalTo: view.topAnchor),
            statusBarView.heightAnchor.constraint(equalToConstant: phoneHasNotch() ? 40 : 20),
        ]
        
        NSLayoutConstraint.activate(profileTableViewConstraints)
        NSLayoutConstraint.activate(statusBarViewConstraints)
    }
    
    private func phoneHasNotch() -> Bool {
        return view.bounds.height > 800
    }
}

// MARK: - Table View Delegate / DataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
            return UITableViewCell()
        }

        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPosition = scrollView.contentOffset.y

        if yPosition > 150 && isStatusBarHidden {
            isStatusBarHidden = false

            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBarView.layer.opacity = 1
            } completion: { _ in }
        } else if yPosition < 0 && !isStatusBarHidden {
            isStatusBarHidden = true

            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBarView.layer.opacity = 0
            } completion: { _ in }
        }
    }
}
