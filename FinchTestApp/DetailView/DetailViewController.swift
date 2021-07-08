//
//  DetailViewController.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

import UIKit

protocol DetailViewOutput: ViewOutput {
    
}

final class DetailViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: DetailViewOutput?
    
    private let placePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 8
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = .black
        
        return label
    }()
    
    private let placeDescriptionText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.backgroundColor = .white
        textView.textColor = .black
        
        return textView
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.lockOrientation(.portrait,
                                   andRotateTo: .portrait)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        drawView()
        presenter?.viewIsReady()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }
    
    private func drawView() {

        view.systemBackground()
        placeDescriptionText.textViewBackground()
        nameLabel.textViewBackground()
        view.addSubview(placePhoto)
        view.addSubview(nameLabel)
        view.addSubview(placeDescriptionText)

        NSLayoutConstraint.activate([
            
            placePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placePhoto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            placePhoto.widthAnchor.constraint(equalToConstant: 250),
            placePhoto.heightAnchor.constraint(equalToConstant: 250),
            
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            nameLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            placeDescriptionText.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 25),
            placeDescriptionText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            placeDescriptionText.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            placeDescriptionText.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
}

//MARK: - DetailViewInput
extension DetailViewController: DetailViewInput {
    func updateViewIfNeeded(with place: Place?) {
        guard let data = place?.photo else { return }
        nameLabel.text = place?.name
        placeDescriptionText.text = place?.placeDescription
        placePhoto.image = UIImage(data: data)
        title = place?.name
    }
}

