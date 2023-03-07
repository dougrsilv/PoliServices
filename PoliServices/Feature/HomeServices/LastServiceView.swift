//
//  LastServiceView.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 28/02/23.
//

import UIKit

class LastServiceView: UIView {
    
    // MARK: - Properties
    
    lazy var titleLast: UILabel = {
        let label = UILabel()
        label.text = "Próximo Serviço"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleLastCard: UILabel = {
        let label = UILabel()
        label.text = "Nome do serviço"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateAndHourTitleLastCard: UILabel = {
        let label = UILabel()
        label.text = "Data e Hora"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateAndHourLastCard: UILabel = {
        let label = UILabel()
        label.text = "30/11 as 19h"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var schedulingLastCard: UILabel = {
        let label = UILabel()
        label.text = "Agendamento"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageLastCard: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "book.fill")
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var lastCardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLast)
        addSubview(lastCardView)
        lastCardView.addSubview(titleLastCard)
        lastCardView.addSubview(dateAndHourTitleLastCard)
        lastCardView.addSubview(dateAndHourLastCard)
        lastCardView.addSubview(imageLastCard)
        lastCardView.addSubview(schedulingLastCard)
        
        NSLayoutConstraint.activate([
            titleLast.topAnchor.constraint(equalTo: topAnchor),
            titleLast.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            lastCardView.topAnchor.constraint(equalTo: titleLast.bottomAnchor, constant: 4),
            lastCardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lastCardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lastCardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lastCardView.heightAnchor.constraint(equalToConstant: 142),
            
            titleLastCard.topAnchor.constraint(equalTo: lastCardView.topAnchor, constant: 16),
            titleLastCard.leadingAnchor.constraint(equalTo: lastCardView.leadingAnchor, constant: 16),
            
            dateAndHourTitleLastCard.leadingAnchor.constraint(equalTo: lastCardView.leadingAnchor, constant: 16),
            dateAndHourTitleLastCard.bottomAnchor.constraint(equalTo: dateAndHourLastCard.topAnchor, constant: -3),
            
            dateAndHourLastCard.leadingAnchor.constraint(equalTo: lastCardView.leadingAnchor, constant: 16),
            dateAndHourLastCard.bottomAnchor.constraint(equalTo: lastCardView.bottomAnchor, constant: -16),
            
            schedulingLastCard.topAnchor.constraint(equalTo: dateAndHourLastCard.bottomAnchor, constant: -3),
            schedulingLastCard.leadingAnchor.constraint(equalTo: lastCardView.leadingAnchor, constant: 16),
            
            imageLastCard.trailingAnchor.constraint(equalTo: lastCardView.trailingAnchor, constant: -4),
            imageLastCard.bottomAnchor.constraint(equalTo: lastCardView.bottomAnchor, constant: -16),
            imageLastCard.heightAnchor.constraint(equalToConstant: 55),
            imageLastCard.widthAnchor.constraint(equalToConstant: 71),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
