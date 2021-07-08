//
//  MainTableViewCell.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    
    private let placePhoto: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.layer.cornerRadius = 10
        photo.clipsToBounds = true
        
        return photo
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private let placeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func drawView() {
        
        contentView.addSubview(placePhoto)
        contentView.addSubview(nameLabel)
        contentView.addSubview(placeDescriptionLabel)
        
        let heightConstraint = placePhoto.heightAnchor.constraint(equalToConstant: 80)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        
        let bottomConstraint = placePhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        bottomConstraint.priority = .defaultLow
        bottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            
            placePhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            placePhoto.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            placePhoto.widthAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: placePhoto.rightAnchor, constant: 20),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            placeDescriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            placeDescriptionLabel.leftAnchor.constraint(equalTo: placePhoto.rightAnchor, constant: 20),
            placeDescriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
    }
    
    func setup(name: String, placeDescription: String, photo: UIImage) {
        nameLabel.text = name
        placeDescriptionLabel.text = placeDescription
        placePhoto.image = photo
    }
}

