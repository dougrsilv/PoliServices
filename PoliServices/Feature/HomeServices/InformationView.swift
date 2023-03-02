//
//  InformationView.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 28/02/23.
//

import UIKit

class InformationView: UIView {
    
    // MARK: - Properties
    
    lazy var titleCard: UILabel = {
        let label = UILabel()
        label.text = "Sobre nós"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textCard: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var informationCardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1).cgColor
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textCard.text = "A DevServices é o melhor aplicativo para reservar seu agendamento com serviços. Aqui é um espaço que você consegue reservar um espaço na minha agenda e vamos resolver suas dúvidas.\nSelecione o tipo de atendimento e vamos pra cima!\n\n*Ilustrativo"
        
        addSubview(informationCardView)
        informationCardView.addSubview(titleCard)
        informationCardView.addSubview(textCard)
        
        NSLayoutConstraint.activate([
            informationCardView.topAnchor.constraint(equalTo: topAnchor),
            informationCardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            informationCardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            informationCardView.heightAnchor.constraint(greaterThanOrEqualTo: textCard.heightAnchor),
            
            titleCard.topAnchor.constraint(equalTo: informationCardView.topAnchor, constant: 12),
            titleCard.leadingAnchor.constraint(equalTo: informationCardView.leadingAnchor, constant: 12),

            textCard.topAnchor.constraint(equalTo: titleCard.bottomAnchor, constant: 4),
            textCard.leadingAnchor.constraint(equalTo: informationCardView.leadingAnchor, constant: 12),
            textCard.trailingAnchor.constraint(equalTo: informationCardView.trailingAnchor, constant: -12),
            textCard.bottomAnchor.constraint(equalTo: informationCardView.bottomAnchor, constant: -12),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

