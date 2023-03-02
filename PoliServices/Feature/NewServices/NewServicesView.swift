//
//  NewServicesView.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 01/03/23.
//

import UIKit

protocol NewServicesViewDelegate: AnyObject {
    func typeService(service: String)
}

class NewServicesView: UIView {
   
    // MARK: - Properties
    
    weak var delegate: NewServicesViewDelegate?
    
    let cell = "cell"
    
    private lazy var collectionViewTeste: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .none
        cv.register(NewServicesCell.self, forCellWithReuseIdentifier: cell)
        let cf: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        cf.scrollDirection = .vertical
        cv.setCollectionViewLayout(cf, animated: false)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        
        addSubview(collectionViewTeste)

        NSLayoutConstraint.activate([
            collectionViewTeste.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionViewTeste.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionViewTeste.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionViewTeste.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Delegate

extension NewServicesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath) as! NewServicesCell
        
        if indexPath.row == 0 {
            cell.titleService.text = "Código"
            cell.imageServices.image = UIImage(systemName: "pencil.slash")
            cell.imageServices.tintColor = .cyan
        } else if indexPath.row == 1 {
            cell.titleService.text = "Carreira"
            cell.imageServices.image = UIImage(systemName: "graduationcap.circle.fill")
            cell.imageServices.tintColor = .green
        } else if indexPath.row == 2 {
            cell.titleService.text = "Entrevista"
            cell.imageServices.image = UIImage(systemName: "books.vertical.fill")
            cell.imageServices.tintColor = .magenta
        } else if indexPath.row == 3 {
            cell.titleService.text = "Feedback"
            cell.imageServices.image = UIImage(systemName: "scribble.variable")
            cell.imageServices.tintColor = .brown
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            delegate?.typeService(service: "Código")
        } else if indexPath.row == 1 {
            delegate?.typeService(service: "Carreira")
        } else if indexPath.row == 2 {
            delegate?.typeService(service: "Entrevista")
        } else if indexPath.row == 3 {
            delegate?.typeService(service: "Feedback")
        }
    }
}
