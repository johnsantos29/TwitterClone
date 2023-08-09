//
//  TweetTableViewCell.swift
//  TwitterClone
//
//  Created by John Erick Santos on 10/8/2023.
//

import UIKit

final class TweetTableViewCell: UITableViewCell {
    static let identifier = "TweetTableViewCell"

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person")
        imageView.backgroundColor = .red

        return imageView
    }()

    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "John Santos"
        label.font = .systemFont(ofSize: 18, weight: .bold)

        return label
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "@johnsantos29"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel

        return label
    }()

    private let tweetContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is my mockup tweet. It is going to take multiple lines. I believe some more text is enough but lets add more anyway... And cheers youtube!"
        label.numberOfLines = 0

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(avatarImageView)
        contentView.addSubview(displayNameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(tweetContentLabel)

        configureConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func configureConstraints() {
        let avatarImageConstraints = [
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
        ]

        let displayNameConstraints = [
            displayNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            displayNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
        ]

        let usernameConstraints = [
            usernameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.trailingAnchor, constant: 10),
            usernameLabel.centerYAnchor.constraint(equalTo: displayNameLabel.centerYAnchor),
        ]

        let tweetConstraints = [
            tweetContentLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            tweetContentLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 10),
            tweetContentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            tweetContentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ]

        NSLayoutConstraint.activate(avatarImageConstraints)
        NSLayoutConstraint.activate(displayNameConstraints)
        NSLayoutConstraint.activate(usernameConstraints)
        NSLayoutConstraint.activate(tweetConstraints)
    }
}
