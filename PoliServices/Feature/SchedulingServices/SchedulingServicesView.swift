//
//  SchedulingServicesView.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 02/03/23.
//

import UIKit

class SchedulingServicesView: UIView {
    
    // MARK: - Propeties
    
    lazy var titleService: UILabel = {
        let label = UILabel()
        label.text = "Selecine a data e hora para reservar"
        label.font = UIFont.systemFont(ofSize: 28)
        label.textColor = .black
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
        let date = UIDatePicker()
        date.minimumDate = Date()
        date.date = Calendar.current.date(byAdding: .minute, value: 1, to: Date()) ?? Date()
        date.preferredDatePickerStyle = .inline
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        
        addSubview(titleService)
        addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            titleService.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 22),
            titleService.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleService.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            datePicker.topAnchor.constraint(equalTo: titleService.bottomAnchor, constant: 32),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            datePicker.heightAnchor.constraint(equalToConstant: 363),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
