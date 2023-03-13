//
//  ServiceDetailCardView.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 09/03/23.
//

import UIKit

class ServiceDetailCardView: UIView {
    
    // MARK: - Properties
    
    lazy var titleServiceDetail: UILabel = {
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
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateStartTitleDetailCard: UILabel = {
        let label = UILabel()
        label.text = "Data Início"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var valueStartDateDetailCard: UILabel = {
        let label = UILabel()
        label.text = "03 de janeiro de 2023"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var hourTitleStartDetailCard: UILabel = {
        let label = UILabel()
        label.text = "Hora Início"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var hourStartDetailCard: UILabel = {
        let label = UILabel()
        label.text = "11:00 AM"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateFinishTitleDetailCard: UILabel = {
        let label = UILabel()
        label.text = "Data Encerramento"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var valueFinishDateDetailCard: UILabel = {
        let label = UILabel()
        label.text = "04 de janeiro de 2023"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var hourTitleFinishDetailCard: UILabel = {
        let label = UILabel()
        label.text = "Hora de Encerramento"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var hourFinishDetailCard: UILabel = {
        let label = UILabel()
        label.text = "12:00 AM"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var requestTitleDetailCard: UILabel = {
        let label = UILabel()
        label.text = "Data de Solicitação"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var requestDateDetailCard: UILabel = {
        let label = UILabel()
        label.text = "21 de dezembro de 2022"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageLastCard: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "book.fill")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var lastCardView: UIView = {
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
        
        addSubview(titleServiceDetail)
        addSubview(lastCardView)
        lastCardView.addSubview(titleLastCard)
        lastCardView.addSubview(dateStartTitleDetailCard)
        lastCardView.addSubview(valueStartDateDetailCard)
        lastCardView.addSubview(hourTitleStartDetailCard)
        lastCardView.addSubview(hourStartDetailCard)
        lastCardView.addSubview(dateFinishTitleDetailCard)
        lastCardView.addSubview(valueFinishDateDetailCard)
        lastCardView.addSubview(hourTitleFinishDetailCard)
        lastCardView.addSubview(hourFinishDetailCard)
        lastCardView.addSubview(requestTitleDetailCard)
        lastCardView.addSubview(requestDateDetailCard)
        lastCardView.addSubview(imageLastCard)
        
        NSLayoutConstraint.activate([
            titleServiceDetail.topAnchor.constraint(equalTo: topAnchor),
            titleServiceDetail.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            lastCardView.topAnchor.constraint(equalTo: titleServiceDetail.bottomAnchor, constant: 4),
            lastCardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lastCardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lastCardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lastCardView.heightAnchor.constraint(equalToConstant: 270),
            
            titleLastCard.topAnchor.constraint(equalTo: lastCardView.topAnchor, constant: 16),
            titleLastCard.leadingAnchor.constraint(equalTo: lastCardView.leadingAnchor, constant: 16),
            
            dateStartTitleDetailCard.topAnchor.constraint(equalTo: titleLastCard.bottomAnchor, constant: 40),
            dateStartTitleDetailCard.leadingAnchor.constraint(equalTo: lastCardView.leadingAnchor, constant: 16),
            
            valueStartDateDetailCard.topAnchor.constraint(equalTo: dateStartTitleDetailCard.bottomAnchor, constant: 2),
            valueStartDateDetailCard.leadingAnchor.constraint(equalTo: lastCardView.leadingAnchor, constant: 16),
            
            hourTitleStartDetailCard.topAnchor.constraint(equalTo: valueStartDateDetailCard.bottomAnchor, constant: 4),
            hourTitleStartDetailCard.leadingAnchor.constraint(equalTo: lastCardView.leadingAnchor, constant: 16),
            
            hourStartDetailCard.topAnchor.constraint(equalTo: hourTitleStartDetailCard.bottomAnchor, constant: 2),
            hourStartDetailCard.leadingAnchor.constraint(equalTo: lastCardView.leadingAnchor, constant: 16),
            
            dateFinishTitleDetailCard.topAnchor.constraint(equalTo: hourStartDetailCard.bottomAnchor, constant: 4),
            dateFinishTitleDetailCard.leadingAnchor.constraint(equalTo: lastCardView.leadingAnchor, constant: 16),
            
            valueFinishDateDetailCard.topAnchor.constraint(equalTo: dateFinishTitleDetailCard.bottomAnchor, constant: 2),
            valueFinishDateDetailCard.leadingAnchor.constraint(equalTo: lastCardView.leadingAnchor, constant: 16),
            
            hourTitleFinishDetailCard.topAnchor.constraint(equalTo: valueFinishDateDetailCard.bottomAnchor, constant: 4),
            hourTitleFinishDetailCard.leadingAnchor.constraint(equalTo: lastCardView.leadingAnchor, constant: 16),
            
            hourFinishDetailCard.topAnchor.constraint(equalTo: hourTitleFinishDetailCard.bottomAnchor, constant: 2),
            hourFinishDetailCard.leadingAnchor.constraint(equalTo: lastCardView.leadingAnchor, constant: 16),
            
            requestTitleDetailCard.topAnchor.constraint(equalTo: hourFinishDetailCard.bottomAnchor, constant: 4),
            requestTitleDetailCard.leadingAnchor.constraint(equalTo: lastCardView.leadingAnchor, constant: 16),
            
            requestDateDetailCard.topAnchor.constraint(equalTo: requestTitleDetailCard.bottomAnchor, constant: 2),
            requestDateDetailCard.leadingAnchor.constraint(equalTo: lastCardView.leadingAnchor, constant: 16),
            
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
