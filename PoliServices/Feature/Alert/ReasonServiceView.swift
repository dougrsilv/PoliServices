//
//  ReasonServiceView.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 11/03/23.
//

import UIKit

protocol ReasonServiceViewDelegate: AnyObject {
    func countText(count: Int, reason: String)
    func reasonText(reason: String)
}

class ReasonServiceView: UIView {
    
    // MARK: - Properties
    
    let pickerView = UIPickerView()
    var products: [ReasonModel] = []
    weak var delegate: ReasonServiceViewDelegate?
    
    lazy var reasonSelectService: UITextField = {
        let field = UITextField()
        field.placeholder = "Opção"
        field.textContentType = .username
        field.textColor = .black
        field.layer.borderWidth = 1.0
        field.layer.cornerRadius = 5
        field.backgroundColor = .white
        field.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftViewMode = .always
        field.heightAnchor.constraint(equalToConstant: 45).isActive = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var reasonTextService: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "Digite o motivo.."
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.delegate = self
        tv.placeholderShouldCenter = false
        tv.layer.borderWidth = 1.0
        tv.layer.cornerRadius = 5
        tv.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
        tv.heightAnchor.constraint(equalToConstant: 80).isActive = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isHidden = true
        return tv
    }()
    
    lazy var characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [reasonSelectService, reasonTextService])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        reasonSelectService.inputView = pickerView
        
        addSubview(stackView)
        addSubview(characterCountLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            characterCountLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 2),
            characterCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setupData(setup: [ReasonModel]) {
        products = setup
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Fuctions
    
    func checkMaxLength(_ textView: UITextView) {
        if (textView.text.count) > 100 {
            textView.deleteBackward()
        }
    }
}

// MARK: - UIPickerDelegate

extension ReasonServiceView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return products.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return products[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        reasonSelectService.text = products[row].description
        delegate?.reasonText(reason: reasonSelectService.text ?? "")
        reasonSelectService.resignFirstResponder()
        if reasonSelectService.text == "Outro" {
            reasonTextService.isHidden = false
            characterCountLabel.isHidden = false
        } else {
            reasonTextService.isHidden = true
            characterCountLabel.isHidden = true
        }
    }
}

// MARK: - UITextViewDelegate

extension ReasonServiceView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        delegate?.countText(count: count, reason: reasonSelectService.text ?? "")
        characterCountLabel.text = "\(count)/100"
    }
}
