//
//  NewPlaceViewController.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

import UIKit

protocol NewPlaceViewOutput {
    func didTapdAddPlace(name: String, placeDescription: String, photo: UIImage)
}

final class NewPlaceViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: NewPlaceViewOutput?
    
    private let placePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "place")
        
        return imageView
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.placeholder = "Название места"
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.autocapitalizationType = .sentences
        textField.backgroundColor = .white
        textField.textColor = .black
        
        return textField
    }()
    
    private let placeDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Описание места"
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.autocapitalizationType = .none
        textView.backgroundColor = .white
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textColor = .black
        
        return textView
    }()
    
    private let photoАctivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.lockOrientation(.portrait,
                                   andRotateTo: .portrait)
        nameTextField.delegate = self
        placeDescriptionTextView.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        drawView()
    }

    
    private func drawView() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openPLibrary))
        placePhoto.addGestureRecognizer(tap)
        placePhoto.isUserInteractionEnabled = true
        
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(sender:)))
        tapScreen.cancelsTouchesInView = false
        
        view.systemBackground()
        nameTextField.textViewBackground()
        placeDescriptionTextView.textViewBackground()
        
        title = "Новое место"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(addNewPlace))
        
        view.addGestureRecognizer(tapScreen)
        view.addSubview(placePhoto)
        view.addSubview(nameTextField)
        view.addSubview(placeDescriptionTextView)
        view.addSubview(photoАctivityIndicator)
        
        NSLayoutConstraint.activate([
            
            placePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placePhoto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            placePhoto.widthAnchor.constraint(equalToConstant: 250),
            placePhoto.heightAnchor.constraint(equalToConstant: 250),
            
            photoАctivityIndicator.centerXAnchor.constraint(equalTo: placePhoto.centerXAnchor),
            photoАctivityIndicator.centerYAnchor.constraint(equalTo: placePhoto.centerYAnchor),
            
            nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            nameTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 30),
            
            placeDescriptionTextView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 25),
            placeDescriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            placeDescriptionTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            placeDescriptionTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func openPLibrary(){
        photoАctivityIndicator.isHidden = true
        photoАctivityIndicator.startAnimating()
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)
        }
    }
    
    @objc private func addNewPlace() {
        guard let name = nameTextField.text,
            let placeDescription = placeDescriptionTextView.text,
            let photo = placePhoto.image,
            !name.isEmpty,
            !placeDescription.isEmpty
            else { return showAlert() }
        presenter?.didTapdAddPlace(name: name, placeDescription: placeDescription, photo: photo)
    }
    
    @objc private func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //MARK: - Alert
    
    private func showAlert() {
        let alert = UIAlertController(title: nil, message: "Заполните все поля", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}

//MARK: - NewPlaceViewInput
extension NewPlaceViewController: NewPlaceViewInput {
    
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension NewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let choosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            placePhoto.image = choosenImage
        }
        photoАctivityIndicator.isHidden = false
        photoАctivityIndicator.stopAnimating()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        photoАctivityIndicator.isHidden = false
        photoАctivityIndicator.stopAnimating()
        dismiss(animated: true, completion: nil)
    }
}
// MARK: - UITextFieldDelegate
extension NewPlaceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
// MARK: - UITextViewDelegate
extension NewPlaceViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = .none
    }
}

