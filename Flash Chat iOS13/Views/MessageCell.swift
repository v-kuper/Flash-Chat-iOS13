//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Vitali Kupratsevich on 20.07.25.
//  Copyright © 2025 Angela Yu. All rights reserved.
//
import UIKit

class MessageCell: UITableViewCell {
    let messageBubble = UIView()
    let label = UILabel()
    let leftImageView = UIImageView()
    let rightImageView = UIImageView()
    private var bubbleLeading: NSLayoutConstraint?
    private var bubbleTrailing: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(leftImageView)
        contentView.addSubview(rightImageView)
        contentView.addSubview(messageBubble)
        messageBubble.addSubview(label)

        messageBubble.layer.cornerRadius = 15
        messageBubble.clipsToBounds = true

        label.numberOfLines = 0

        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        messageBubble.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        leftImageView.image = UIImage(named: "YouAvatar")
        rightImageView.image = UIImage(named: "MeAvatar")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            leftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            leftImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            leftImageView.widthAnchor.constraint(equalToConstant: 40),
            leftImageView.heightAnchor.constraint(equalToConstant: 40),

            rightImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            rightImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            rightImageView.widthAnchor.constraint(equalToConstant: 40),
            rightImageView.heightAnchor.constraint(equalToConstant: 40),

            messageBubble.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            messageBubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            messageBubble.widthAnchor.constraint(lessThanOrEqualToConstant: 250),

            label.topAnchor.constraint(equalTo: messageBubble.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: messageBubble.bottomAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: messageBubble.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: messageBubble.trailingAnchor, constant: -10)
        ])

        // Bubble horizontal constraints for toggling
        bubbleLeading = messageBubble.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 10)
        bubbleTrailing = messageBubble.trailingAnchor.constraint(equalTo: rightImageView.leadingAnchor, constant: -10)
        // Set both inactive initially
        bubbleLeading?.isActive = false
        bubbleTrailing?.isActive = false
    }

    func configure(for message: Message, isCurrentUser: Bool) {
        label.text = message.body

        leftImageView.isHidden = isCurrentUser
        rightImageView.isHidden = !isCurrentUser

        // Toggle bubble constraints
        bubbleLeading?.isActive = false
        bubbleTrailing?.isActive = false
        
        if isCurrentUser {
            messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            label.textColor = UIColor(named: K.BrandColors.purple)
            bubbleTrailing?.isActive = true
        } else {
            messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            label.textColor = UIColor(named: K.BrandColors.lightPurple)
            bubbleLeading?.isActive = true
        }
    }
}
