//
//  TranslationTextView.swift
//  Translator
//
//  Created by Ксения Маричева on 13.03.2025.
//

import UIKit


#warning("Новый кастомный класс")
class TranslationTextView: UITextView {
    
    //MARK: - naming
    private let placeholderLabel = UILabel()

    #warning("не знаю правильно ли так оставлять но мне очень понравилось это решение чата c didset")
    var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    var placeholderColor: UIColor = .lightGray {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }

    //MARK: - init
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        font = UIFont.systemFont(ofSize: 23)
        setupPlaceholder()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPlaceholder()
    }

    //MARK: - methods
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePlaceholderFrame()
    }
    
    private func setupPlaceholder() {
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.font = self.font
        placeholderLabel.numberOfLines = 0
        placeholderLabel.textAlignment = .left
        placeholderLabel.isUserInteractionEnabled = false
        
        addSubview(placeholderLabel)
        updatePlaceholderFrame()
    }

    private func updatePlaceholderFrame() {
        let inset = textContainerInset.left
        placeholderLabel.frame = CGRect(x: inset, y: textContainerInset.top, width: frame.width - 2 * inset, height: 0)
        placeholderLabel.sizeToFit()
    }

    #warning("Метод который отвечает за появление и пропадание плейсхолдера")
    func refreshPlaceholderVisibility(textViewIsEmpty: Bool) {
        placeholderLabel.isHidden = !textViewIsEmpty
    }
}
