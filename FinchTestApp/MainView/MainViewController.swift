//
//  MainViewController.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

import UIKit

protocol MainViewControllerOutput {
    func tapAddButton()
}

final class MainViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: MainViewControllerOutput?
    var tableViewManager: MainTableViewInput?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.systemBackground()
        
        return tableView
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backBarItem = UIBarButtonItem()
        backBarItem.title = "Назад"
        navigationItem.backBarButtonItem = backBarItem
        
        CoreDataManager.shared.fetchPlace()
        tableViewManager?.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        drawView()
    }
    
    private func drawView() {
        
        title = "Любимые места"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        
        view.systemBackground()
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        tableViewManager?.setup(tableView: tableView)
    }
    
    // MARK: - Actions
    
    @objc private func didTapAddButton() {
        presenter?.tapAddButton()
    }
}

//MARK: - MainTableViewPresenter
extension MainViewController: MainViewInput {
    
}
