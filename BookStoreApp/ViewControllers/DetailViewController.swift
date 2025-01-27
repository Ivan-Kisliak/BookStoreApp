//
//  DetailViewController.swift
//  BookStoreApp
//
//  Created by  Ivan Kiskyak on 8.01.25.
//

import UIKit

final class DetailViewController: UIViewController {
    var book: Book?
    
    private var isHeartPressed = false
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
}

//MARK: - Setup View
private extension DetailViewController {
    func setupView() {
        view.backgroundColor = .black
        
        setupNavigationBar()
        setupImageView()
        setupTitleLabel()
        
        [imageView,
         titleLabel].forEach { view.addSubview($0)}
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Book"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupFavoriteButton()
    }
    
    func setupFavoriteButton() {
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonPressed)
        )
        
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    func setupFavoriteButtonFill() {
        let favoriteButtonFill = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonPressed)
        )
        
        navigationItem.rightBarButtonItem = favoriteButtonFill
        navigationItem.rightBarButtonItem?.tintColor = .red
    }

    func setupImageView() {
        if let bookImage = book?.image {
            imageView.image = UIImage(named: bookImage)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
    }
    
    func setupTitleLabel() {
        titleLabel.text = book?.title
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.7
    }
}

//MARK: - Actions
private extension DetailViewController {
    @objc func favoriteButtonPressed() {
        isHeartPressed.toggle()
        isHeartPressed ? setupFavoriteButtonFill() : setupFavoriteButton()
    }
}

//MARK: - Setup Layout
private extension DetailViewController {
    func setupLayout() {
        [imageView,
         titleLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
    }
}


