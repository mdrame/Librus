//
//  ViewController.swift
//  Librus
//
//  Created by Mohammed Drame on 3/15/21.
//

import UIKit

// https://api.yelp.com/v3/businesses/search

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(libraryTableView)
        libraryTableviewConstrain()
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
        return libraryCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    
    
    
    


}

