//
//  NewServicesCell.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 01/03/23.
//

import UIKit

class NewServicesCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    lazy var imageServices: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var titleService: UILabel = {
        let label = UILabel()
        label.text = "Teste"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(imageServices)
        addSubview(titleService)
        
        NSLayoutConstraint.activate([
            imageServices.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            imageServices.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageServices.heightAnchor.constraint(equalToConstant: 60),
            imageServices.widthAnchor.constraint(equalToConstant: 60),
            
            titleService.topAnchor.constraint(equalTo: imageServices.bottomAnchor, constant: 12),
            titleService.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
