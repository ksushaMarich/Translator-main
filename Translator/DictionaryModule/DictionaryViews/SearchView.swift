//
//  SearchView.swift
//  Translator
//
//  Created by Ксения Маричева on 28.02.2025.
//
import UIKit

class CenteredSearchBar: UIControl {
    private let searchIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .gray
        return imageView
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.textAlignment = .left
        textField.borderStyle = .none
        return textField
    }()
    
    private var isActive = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = .white
        
        addSubview(searchIcon)
        addSubview(textField)
        
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let iconSize: CGFloat = 18
        let spacing: CGFloat = 8
        
        if isActive {
            searchIcon.frame = CGRect(x: spacing, y: (bounds.height - iconSize) / 2, width: iconSize, height: iconSize)
            textField.frame = CGRect(x: searchIcon.frame.maxX + spacing, y: 0, width: bounds.width - searchIcon.frame.maxX - 2 * spacing, height: bounds.height)
            textField.textAlignment = .left
        } else {
            let totalWidth = iconSize + spacing + textField.intrinsicContentSize.width
            let startX = (bounds.width - totalWidth) / 2
            
            searchIcon.frame = CGRect(x: startX, y: (bounds.height - iconSize) / 2, width: iconSize, height: iconSize)
            textField.frame = CGRect(x: searchIcon.frame.maxX + spacing, y: 0, width: bounds.width - searchIcon.frame.maxX - spacing, height: bounds.height)
            textField.textAlignment = .center
        }
    }
    
    
    
    @objc private func textFieldDidBeginEditing() {
        isActive = true
        UIView.animate(withDuration: 0.3) {
            self.layoutSubviews()
        }
    }
    
    @objc private func textFieldDidEndEditing() {
        isActive = false
        UIView.animate(withDuration: 0.3) {
            self.layoutSubviews()
        }
    }
}
