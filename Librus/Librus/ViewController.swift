//
//  ViewController.swift
//  Librus
//
//  Created by Mohammed Drame on 3/15/21.
//

import UIKit
import CoreLocation



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    private var networking: Networking = Networking()
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationService()
        // Do any additional setup after loading the view.
        view.addSubview(libraryTableView)
        libraryTableviewConstrain()
        
        //        networking.getLibrary(lng: 10, lat: 20)
        
    }
    
    private  lazy var libraryTableView: UITableView = {
        let libraryTableView = UITableView(frame: .zero)
        libraryTableView.translatesAutoresizingMaskIntoConstraints = false
        libraryTableView.register(LibraryCell.self, forCellReuseIdentifier: LibraryCell.cellIdenfier)
        libraryTableView.separatorStyle = .none
        //        libraryTableView.isSpringLoaded = true
        return libraryTableView
    }()
    
    private func libraryTableviewConstrain() {
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
        libraryCell?.selectionStyle = .none
        libraryCell!.libraryNameLabel.text = "Newark Library"
        libraryCell!.distanceLabel.text = "0.7 mils"
        libraryCell!.libraryAddressLabel.text = "547 Spring Street, Newark NJ, 07108"
        return libraryCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let goToMap = UIContextualAction(style: .normal, title: "GO") { (action, view, nil) in
            print("Go to Google map")
        }
        return UISwipeActionsConfiguration(actions: [goToMap])
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Allowed")
        case .denied, .notDetermined, .restricted:
            print("No access to location service")
        default:
            print("Unhandled case")
        }
        switch manager.accuracyAuthorization {
        case .reducedAccuracy:
            print("Low access")
        case .fullAccuracy:
            print("Full access")
        default:
            print("This shouldn't happen!")
        }
    }
    
    //
    private func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            //            checkLocationAuthorization(locationManager)
        } else {
            // Show alert telling user that location service is off
            print("location service off")
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    //    func checkLocationAuthorization(_ manager: CLLocationManager) {
    //        switch manager.authorizationStatus {
    //        case .authorizedAlways, .authorizedWhenInUse:
    //            print("Allowed")
    //        case .denied, .notDetermined, .restricted:
    //            print("No access to location service")
    //        default:
    //            print("Unhandled case")
    //        }
    //        switch manager.accuracyAuthorization {
    //        case .reducedAccuracy:
    //            print("Low access")
    //        case .fullAccuracy:
    //            print("Full access")
    //        default:
    //            print("This shouldn't happen!")
    //        }
    //    }
    
    
    
    
    
    
    
    
    
}

