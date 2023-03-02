//
//  HomeServicesView.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 28/02/23.
//

import UIKit

protocol HomeServicesViewDelegate: AnyObject {
    func buttonService()
}

class HomeServicesView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: HomeServicesViewDelegate?
    
    lazy var titleServices: UILabel = {
        let label = UILabel()
        label.text = "Bem-Vindo ao \nDevServices"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subTitle: UILabel = {
        let label = UILabel()
        label.text = "30 de novembro"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var serviceButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        button.setTitle("Solicitar novo serviço", for: .normal)
        button.layer.cornerRadius = 27
        button.clipsToBounds = true
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.addTarget(self, action: #selector(onEnterTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var lineValueView: UIView = {
        let view = UIView()
        view.bounds = bounds.insetBy(dx: -0.5, dy: -0.5)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.302, green: 0.362, blue: 0.896, alpha: 1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var informtionView: InformationView = {
        let view = InformationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lastServiceView: LastServiceView = {
        let view = LastServiceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cardsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [lastServiceView, serviceButton])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
      }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
      }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleServices)
        
        contentView.addSubview(subTitle)
        contentView.addSubview(informtionView)
        contentView.addSubview(lineValueView)
        contentView.addSubview(cardsStackView)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleServices.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleServices.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            titleServices.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            
            subTitle.topAnchor.constraint(equalTo: titleServices.bottomAnchor, constant: 4),
            subTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            
            informtionView.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 32),
            informtionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            informtionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            lineValueView.topAnchor.constraint(equalTo: informtionView.bottomAnchor, constant: 232),
            lineValueView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 55),
            lineValueView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -55),
            lineValueView.heightAnchor.constraint(equalToConstant: 1),
            
            cardsStackView.topAnchor.constraint(equalTo: lineValueView.topAnchor, constant: 32),
            cardsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            cardsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            cardsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    @objc func onEnterTap() {
        delegate?.buttonService()
    }
    
    func setParameter(model: HomeServicesViewModel) {
        lastServiceView.titleLastCard.text = model.serviceNameCard
        lastServiceView.dateAndHourLastCard.text = model.serviceDateCard
        
        UIView.animate(withDuration: 0.3) {
            self.lastServiceView.alpha = model.hidesCard ? 1 : 0
            self.lastServiceView.isHidden = !model.hidesCard
            self.serviceButton.alpha = model.hidesCard ? 0 : 1
            self.serviceButton.isHidden = model.hidesCard
        }
    }
    
    func setParameterHiden(values: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.lastServiceView.alpha = values ? 1 : 0
            self.lastServiceView.isHidden = !values
            self.serviceButton.alpha = values ? 0 : 1
            self.serviceButton.isHidden = values
        }
    }
}
