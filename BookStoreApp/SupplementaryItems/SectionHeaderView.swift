//
//  SectionHeaderView.swift
//  BookStoreApp
//
//  Created by  Ivan Kiskyak on 13.12.24.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        label.text = text
    }

}

//MARK: - Setting View
private extension SectionHeaderView {
    func setupView() {
        addSubview(label)
        setupLabel()
    }
    
    func setupLabel() {
        label.frame = bounds
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
    }
}
