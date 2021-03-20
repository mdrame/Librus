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
    private let locationManager = CLLocationManager()
    private var listOFLibraries: [Business] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        checkLocationService()
        view.addSubview(libraryTableView)
        libraryTableviewConstrain()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let long = Double((locationManager.location?.coordinate.longitude)!)
        let lati = Double((locationManager.location?.coordinate.latitude)!)
        print(" 📍 - Long: \(long), 🗺 - Lat: \(lati)")
        networking.getLibrary(lng: long, lat: lati) { [weak self] (welcomObjectData) in
            DispatchQueue.main.async {
//                print(" WelcomeDataModel: \(welcomObjectData)")
                guard let wd = welcomObjectData else  {
                    print("No Data ")
                    return }
                self?.listOFLibraries = wd
                print("Array of business: \(self?.listOFLibraries[0].name)")
                self!.libraryTableView.reloadData()
            }
           
        }
        
    }
    
    private  lazy var libraryTableView: UITableView = {
        let libraryTableView = UITableView(frame: .zero)
        libraryTableView.translatesAutoresizingMaskIntoConstraints = false
        libraryTableView.register(LibraryCell.self, forCellReuseIdentifier: LibraryCell.cellIdenfier)
        libraryTableView.separatorStyle = .none
        //        libraryTableView.isSpringLoaded = true
        //        libraryTableView.backgroundColor = #colorLiteral(red: 0.1318426728, green: 0.1439217925, blue: 0.158605963, alpha: 1)
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
        return listOFLibraries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let libraryCell = tableView.dequeueReusableCell(withIdentifier: LibraryCell.cellIdenfier, for: indexPath) as? LibraryCell
        libraryCell?.selectionStyle = .none
        let business = listOFLibraries[indexPath.row]
       
        DispatchQueue.main.async {
            libraryCell?.configCellViews(with: business )
        }
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
        let goToMap = UIContextualAction(style: .destructive, title: "") { (action, view, nil) in
            print("Go to Google Map")
        }
        
        goToMap.backgroundColor = #colorLiteral(red: 0.5606392622, green: 0.9218434691, blue: 0.3199045658, alpha: 1)
        goToMap.image = #imageLiteral(resourceName: "swipe-right.png")
        let confug = UISwipeActionsConfiguration(actions: [goToMap])
        confug.performsFirstActionWithFullSwipe = true
        return confug
    }
    
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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
    
    
    private func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            switch locationManager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                print("Allowed")
            case .denied, .notDetermined, .restricted:
                print("No access to location service")
            default:
                print("Unhandled case")
            }
            switch locationManager.accuracyAuthorization {
            case .reducedAccuracy:
                print("Low access")
            case .fullAccuracy:
                print("Full access")
            default:
                print("This shouldn't happen!")
            }        } else {
                // Show alert telling user that location service is off
                print("location service off")
            }
    }
    
    private func setupLocationManager() {
        //        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
}

// Todo
// Decode JSON
// Set jSON data to UIViews
// Implement Swip feature ( if user swipe right, add library address to google map and start direction.
// Work on better UI
// Implement more detail ( user didTape tableView, show more detail about selected library, add call option )
// see if I can fix swip frame etc


