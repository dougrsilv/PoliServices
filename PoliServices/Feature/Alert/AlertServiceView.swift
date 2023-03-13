//
//  AlertServiceView.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 10/03/23.
//

import UIKit

protocol AlertServiceViewDelegate: AnyObject {
    func clickButtonCancel()
    func clickButtonSave(reason: String)
}

class AlertServiceView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: AlertServiceViewDelegate?
    
    lazy var reasonServiceView: ReasonServiceView = {
        let view = ReasonServiceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var serviceCancelButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        button.setTitle("Cancelar", for: .normal)
        button.layer.cornerRadius = 27
        button.backgroundColor = .systemRed
        button.tintColor = .white
        button.clipsToBounds = true
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.addTarget(self, action: #selector(onCancelEnterTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var serviceSaveButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        button.setTitle("Ok", for: .normal)
        button.layer.cornerRadius = 27
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.clipsToBounds = true
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.addTarget(self, action: #selector(onSaveEnterTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        reasonServiceView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        backgroundColor = .black.withAlphaComponent(0.6)
        alpha = 0
        alertView.alpha = 0
        alertView.layer.cornerRadius = 12
        
        addSubview(alertView)
        alertView.addSubview(reasonServiceView)
        alertView.addSubview(serviceCancelButton)
        alertView.addSubview(serviceSaveButton)
        
        alertView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        alertView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        alertView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        reasonServiceView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 10).isActive = true
        reasonServiceView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10).isActive = true
        reasonServiceView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10).isActive = true
        
        serviceCancelButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10).isActive = true
        serviceCancelButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -10).isActive = true
        
        serviceSaveButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10).isActive = true
        serviceSaveButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -10).isActive = true
        serviceSaveButton.widthAnchor.constraint(equalToConstant: 91).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.frame.origin.y = -100
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.frame.origin.y = 0
    }
    
    @objc func onCancelEnterTap() {
        delegate?.clickButtonCancel()
    }
    
    @objc func onSaveEnterTap() {
        delegate?.clickButtonSave(reason: reasonServiceView.reasonSelectService.text ?? "")
    }
}

extension AlertServiceView: ReasonServiceViewDelegate {
    func countText(count: Int, reason: String) {
        if count < 5 && reason == "Outro" {
            serviceSaveButton.isEnabled = false
        } else {
            serviceSaveButton.isEnabled = true
        }
    }
    
    func reasonText(reason: String) {
        if reason == "Outro" {
            serviceSaveButton.isEnabled = false
        } else {
            serviceSaveButton.isEnabled = true
        }
    }
}

