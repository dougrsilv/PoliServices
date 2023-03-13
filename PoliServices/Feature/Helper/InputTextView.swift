//
//  InputTextView.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 11/03/23.
//

import UIKit

class InputTextView: UITextView {
    
    // MARK: - Properties
    
    var placeholderText: String? {
        didSet {
            placeholderLabel.text = placeholderText
        }
    }
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    var placeholderShouldCenter = true {
        didSet {
            if placeholderShouldCenter {
                placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
                placeholderLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            } else {
                placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
                placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlerTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func handlerTextDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    
}
