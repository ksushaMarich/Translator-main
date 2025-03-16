//
//  SearchView.swift
//  Translator
//
//  Created by Ксения Маричева on 28.02.2025.
//
import UIKit

class CenteredSearchBar: UIView {
    
    private lazy var iconSize: CGFloat = 18
    private lazy var spacing: CGFloat = 8
    private lazy var centerX = UIScreen.main.bounds.width / 2 - iconSize / 2
    
    private var leadingIconConstraint: NSLayoutConstraint!
    
    private let searchIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search"
        textField.textAlignment = .left
        textField.borderStyle = .none
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(searchIcon)
        addSubview(textField)
        
        leadingIconConstraint = searchIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: centerX)
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            heightAnchor.constraint(equalToConstant: 50),
            
            searchIcon.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            searchIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing),
            leadingIconConstraint, // используем созданный констрейнт
            searchIcon.widthAnchor.constraint(equalToConstant: iconSize),
            searchIcon.heightAnchor.constraint(equalTo: searchIcon.widthAnchor),
            
            textField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: spacing),
            textField.centerYAnchor.constraint(equalTo: searchIcon.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            textField.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    @objc private func textFieldDidBeginEditing() {
        leadingIconConstraint.constant = 8
        animateLayout()
    }
    
    @objc private func textFieldDidEndEditing() {
        leadingIconConstraint.constant = centerX
        animateLayout()
    }
    
    private func animateLayout() {
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
