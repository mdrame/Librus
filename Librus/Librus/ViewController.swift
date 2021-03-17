//
//  ViewController.swift
//  Librus
//
//  Created by Mohammed Drame on 3/15/21.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var networking: Networking = Networking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(libraryTableView)
        libraryTableviewConstrain()
        networking.getLibrary(lng: 10, lat: 20)
    }
    
    lazy var libraryTableView: UITableView = {
        let libraryTableView = UITableView(frame: .zero)
        libraryTableView.translatesAutoresizingMaskIntoConstraints = false
        libraryTableView.register(LibraryCell.self, forCellReuseIdentifier: LibraryCell.cellIdenfier)
        libraryTableView.separatorStyle = .none
//        libraryTableView.isSpringLoaded = true
        return libraryTableView
    }()
    
    func libraryTableviewConstrain() {
        libraryTableView.delegate = self
        libraryTableView.dataSource = self
        NSLayoutConstraint.activate([
            libraryTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            libraryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            libraryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            libraryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let libraryCell = tableView.dequeueReusableCell(withIdentifier: LibraryCell.cellIdenfier, for: indexPath) as? LibraryCell
        libraryCell!.libraryNameLabel.text = "Newark Library"
        libraryCell!.distanceLabel.text = "0.7 mils"
        libraryCell!.libraryAddressLabel.text = "547 Spring Street, Newark NJ, 07108"
        return libraryCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    
    
    
    


}

