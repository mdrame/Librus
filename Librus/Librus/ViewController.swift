//
//  ViewController.swift
//  Librus
//
//  Created by Mohammed Drame on 3/15/21.
//

import UIKit
import CoreLocation
import MapKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    private var networking: Networking = Networking()
    private let locationManager = CLLocationManager()
    private var listOFLibraries: [Business] = []
    private let regionDistance: CLLocationDistance = 1000
    private let colors: [UIColor] = [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9328868985, green: 0.3016234636, blue: 0.9596740603, alpha: 1),#colorLiteral(red: 0.9438698888, green: 0.8653196692, blue: 0.2051090002, alpha: 1),#colorLiteral(red: 0, green: 0.8713548779, blue: 0.943228364, alpha: 1),#colorLiteral(red: 1, green: 0.2480090559, blue: 0.353962481, alpha: 1),#colorLiteral(red: 0.2920596004, green: 0.2827538252, blue: 0.2876347601, alpha: 1)]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        checkLocationService()
        view.addSubview(libraryTableView)
        libraryTableviewConstrain()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let regionDistance = 1000
        let long = (locationManager.location?.coordinate.longitude)!
        let lati = (locationManager.location?.coordinate.latitude)!
        print(" 📍 - Long: \(long), 🗺 - Lat: \(lati)")
        networking.getLibrary(lng: Double(long), lat: Double(lati)) { [weak self] (welcomObjectData) in
            DispatchQueue.main.async {
//                print(" WelcomeDataModel: \(welcomObjectData)")
                guard let wd = welcomObjectData else  {
                    print("No Data ")
                    return }
                self?.listOFLibraries = wd
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
       
        DispatchQueue.main.async { [self] in
            libraryCell?.configCellViews(with: business, background: colors )
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
        let goToMap = UIContextualAction(style: .destructive, title: "") { [self] (action, view, nil) in
            print("Go to Google Map")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mapKitViewStoryBoard") as! MapViewController
            let destinationCordinate = listOFLibraries[indexPath.row].coordinates
            let lon = destinationCordinate.longitude
            let lat = destinationCordinate.latitude
            let destinationCord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            vc.destinationCordinate = destinationCord
            print("")
            self.navigationController?.pushViewController(vc,
             animated: true)
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


