//
//  ViewController.swift
//  multi-line-stackview
//
//  Created by Chase Choi on 2022/6/18.
//

import UIKit

class ViewController: UIViewController {
    
    private let shortName = "Lorem Ipsum"
    private let longName = "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups."
    
    private let shouldShowLongTextButton: UISwitch = {
        let button = UISwitch()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var multiLineStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, statusLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .brown
        label.text = shortName
        return label
    }()
        
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "🏖"
        label.textAlignment = .center
        label.backgroundColor = .gray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureConstraints()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        applyStackViewConfiguration()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applyStackViewConfiguration()
    }
    
    private func configureViews() {
        view.addSubview(shouldShowLongTextButton)
        view.addSubview(multiLineStackView)
        
        shouldShowLongTextButton.addTarget(self, action: #selector(didTapSwitchButton(sender:)), for: .valueChanged)
    }

    private func configureConstraints() {
        statusLabel.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        statusLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        
        NSLayoutConstraint.activate([
            shouldShowLongTextButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            shouldShowLongTextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            multiLineStackView.topAnchor.constraint(equalTo: shouldShowLongTextButton.bottomAnchor, constant: 20),
            multiLineStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            multiLineStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    private func applyStackViewConfiguration() {
        multiLineStackView.axis = nameLabel.isTruncated ? .vertical : .horizontal
    }
    
    @objc private func didTapSwitchButton(sender: UISwitch) {
        nameLabel.text = shouldShowLongTextButton.isOn ? longName : shortName
    }
}

fileprivate extension UILabel {
    var isTruncated: Bool {
        return intrinsicContentSize.width > frame.width
    }
}
