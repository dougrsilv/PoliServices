//
//  ServiceDetailView.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 09/03/23.
//

import UIKit

protocol ServiceDetailViewDelegate: AnyObject {
    func clickCancelButton()
}

class ServiceDetailView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: ServiceDetailViewDelegate?
    
    private lazy var serviceButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        button.setTitle("Cancelar serviço", for: .normal)
        button.layer.cornerRadius = 27
        button.backgroundColor = .red
        button.tintColor = .white
        button.clipsToBounds = true
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.addTarget(self, action: #selector(onEnterTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var serviceDetailCardView = {
        let view = ServiceDetailCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackViewService: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [serviceDetailCardView, serviceButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        
        addSubview(stackViewService)
        
        NSLayoutConstraint.activate([
            stackViewService.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 22),
            stackViewService.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            stackViewService.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Fuctions
    
    func setupDate(setup: ServiceDetailModel) {
        if setup.desabilyButton == "1" {
            serviceButton.isEnabled = false
        }
    }
    
    @objc func onEnterTap() {
        delegate?.clickCancelButton()
    }
    
}
