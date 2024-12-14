//
//  BadgeView.swift
//  BookStoreApp
//
//  Created by  Ivan Kiskyak on 14.12.24.
//

import UIKit

class BadgeView: UICollectionReusableView {
    private let badgeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBadge(isHidden: Bool) {
        badgeLabel.isHidden = isHidden
    }
}

//MARK: - Setting View
private extension BadgeView {
    func setupView() {
        setupBadgeLabel()
        addSubview(badgeLabel)
    }
    
    func setupBadgeLabel() {
        badgeLabel.text = "Новинка"
        badgeLabel.frame = bounds
        badgeLabel.backgroundColor = .systemPurple
        badgeLabel.textColor = .white
        badgeLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 5
        badgeLabel.layer.masksToBounds = true
    }
}
