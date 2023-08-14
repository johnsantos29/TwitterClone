//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by John Erick Santos on 9/8/2023.
//

import FirebaseAuth
import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Components

    private let timelineTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)

        return tableView
    }()

    // MARK: - Life cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timelineTableView)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        configureNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
            style: .plain, target: self,
            action: #selector(didTapSignOut))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        timelineTableView.frame = view.frame
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false

        // Once view appeared, check if we have a user signed in
        handleAuthentication()
    }

    private func handleAuthentication() {
        if Auth.auth().currentUser == nil {
            let vc = OnboardingViewController()
            let navigationVc = UINavigationController(rootViewController: vc)
            navigationVc.modalPresentationStyle = .fullScreen
            present(navigationVc, animated: false)
        }
    }

    // MARK: - Button Actions

    @objc private func didTapSignOut() {
        try? Auth.auth().signOut()
        handleAuthentication()
    }

    // MARK: - Navigation bar

    private func configureNavigationBar() {
        let size: CGFloat = 36

        // Twitter logo in the middle
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = UIImage(named: "twitterLogo")

        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        middleView.addSubview(logoImageView)
        navigationItem.titleView = middleView

        // Profile image
        let profileImage = UIImage(systemName: "person")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(didTapProfile))
    }

    @objc func didTapProfile() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Table View Delegate / DataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath)
            as? TweetTableViewCell
        else {
            return UITableViewCell()
        }

        cell.delegate = self

        return cell
    }
}

// MARK: - TweetTableViewCellDelegate

extension HomeViewController: TweetTableViewCellDelegate {
    func tweetTableViewCellDidTapReply() {
        print("Reply")
    }

    func tweetTableViewCellDidTapRetweet() {
        print("Retweet")
    }

    func tweetTableViewCellDidTapLike() {
        print("Like")
    }

    func tweetTableViewCellDidTapShare() {
        print("Share")
    }
}
