//
//  ViewController.swift
//  Translator
//
//  Created by Ксения Маричева on 28.01.2025.
//

import UIKit

protocol MainViewControllerProtocol: AnyObject {
    func showTranslation(text: String)
    func setLanguages(_ languages: SelectedLanguages)
}

class MainViewController: UIViewController {

    var presenter: MainPresenterProtocol?
    
    // MARK: - language stackView
    private lazy var languageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var turnOverView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "arrow.left.and.right")
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchTapped)))
        return view
    }()
    
    private lazy var sourceLanguageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sourceLanguageSelected)))
        return label
    }()
    
    private lazy var targetLanguageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        #warning("cделала взаимосвязанными шрифты, не знаю так можно делать или нет ")
        label.font = sourceLanguageLabel.font
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(targetLanguageSelected)))
        return label
    }()
    // MARK: - translateStackView
    private lazy var translateStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.axis = .vertical
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 1
        return view
    }()
    
    #warning("Заменила UITextField на UITextView, добавила в него placeholder")
    private lazy var translationTextView: TranslationTextView = {
        let textView = TranslationTextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .systemBackground
        textView.delegate = self
        textView.placeholder = "Text or website address"
        textView.placeholderColor = .gray
        #warning("Это нужно для того что бы курсор был там же где placeholder")
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        return textView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private lazy var translationLabel: TranslationLabel = {
        let label = TranslationLabel(textInsets: translationTextView.textContainerInset)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = translationTextView.backgroundColor
        label.font = translationTextView.font
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        #warning("Добавила функцию которая скрывает клавитауру, не уверенна что это правильно так")
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        
        view.backgroundColor = Style.themeColor
        
        view.addSubview(languageStackView)
        view.addSubview(translateStackView)
        languageStackView.addArrangedSubview(sourceLanguageLabel)
        languageStackView.addArrangedSubview(turnOverView)
        languageStackView.addArrangedSubview(targetLanguageLabel)
        
        translateStackView.addArrangedSubview(translationTextView)
        translateStackView.addSubview(separatorView)
        translateStackView.addArrangedSubview(translationLabel)
        
        NSLayoutConstraint.activate([
            
            languageStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            languageStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            languageStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            languageStackView.heightAnchor.constraint(equalToConstant: 50),
            
            sourceLanguageLabel.widthAnchor.constraint(equalTo: turnOverView.widthAnchor, multiplier: 5.5),
            targetLanguageLabel.widthAnchor.constraint(equalTo: sourceLanguageLabel.widthAnchor),
            
            translateStackView.topAnchor.constraint(equalTo: languageStackView.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            translateStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            translateStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            translateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            translationLabel.heightAnchor.constraint(equalTo: translationTextView.heightAnchor, multiplier: 3.5),
            
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.centerXAnchor.constraint(equalTo: translateStackView.centerXAnchor),
            separatorView.widthAnchor.constraint(equalTo: translateStackView.widthAnchor, multiplier: 0.9),
            separatorView.topAnchor.constraint(equalTo: translationTextView.bottomAnchor)
            
        ])
    }
    
    private func clear() {
        translationTextView.text = ""
        translationLabel.text = ""
    }
    
    @objc private func switchTapped() {
        presenter?.switchTapped()
    }
    
    @objc private func sourceLanguageSelected() {
        presenter?.sourceLanguageSelected()
    }
    
    @objc private func targetLanguageSelected() {
        presenter?.targetLanguageSelected()
    }
    
    #warning("Добавила не уверенна")
    @objc private func endEditing() {
        view.endEditing(true)
    }
}

extension MainViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
#warning("Ввод по enter")
        if text == "\n" {
            presenter?.enterButtonTapped(text: translationTextView.text)
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
    #warning("Появление и исчезновение placeholder")
        guard let textView = textView as? TranslationTextView else { return }
        textView.refreshPlaceholderVisibility(textViewIsEmpty: textView.text.isEmpty)
    }
    
    #warning("Сделала вот такой метод реализации не уверенна что так логичнее всего")
    func textViewDidBeginEditing(_ textView: UITextView) {
        translationLabel.text = ""
        translationTextView.text = ""
    }
}

extension MainViewController: MainViewControllerProtocol {
    
    func setLanguages(_ languages: SelectedLanguages) {
        sourceLanguageLabel.text = languages.source.description()
        targetLanguageLabel.text = languages.target.description()
        clear()
    }
    
    func showTranslation(text: String) {
        translationLabel.text = text
    }
}

