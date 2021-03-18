//
//  LibraryCell.swift
//  Librus
//
//  Created by Mohammed Drame on 3/16/21.
//

import UIKit

public class LibraryCell: UITableViewCell {
    public static var cellIdenfier = "libraryCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
        contentView.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        contentView.layer.cornerRadius = 10
        contentView.addSubview(libraryNameLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(libraryAddressLabel)
        constrains(view: libraryNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    let libraryNameLabel: UILabel = {
        let taskLabelLabel = UILabel()
        taskLabelLabel.text = "0.4 mils"
        taskLabelLabel.translatesAutoresizingMaskIntoConstraints = false
        taskLabelLabel.font = UIFont(name: "Arial", size: 30)
        return taskLabelLabel
    }()
    
    let distanceLabel: UILabel = {
        let distanceLabel = UILabel()
        distanceLabel.text = "0.9 mils"
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.font = UIFont(name: "Arial", size: 19)
        return distanceLabel
    }()
    
    let libraryAddressLabel: UILabel = {
        let libraryAddressLabel = UILabel()
        libraryAddressLabel.text = "20.5 mils"
        libraryAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        libraryAddressLabel.font = UIFont(name: "Arial", size: 15)
        return libraryAddressLabel
    }()
    
    func constrains(view: UIView) {
        NSLayoutConstraint.activate([
//            view.topAnchor.constraint(equalTo: view.topAnchor),
//            view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            distanceLabel.topAnchor.constraint(equalTo: view.bottomAnchor),
            distanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            libraryAddressLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor),
            libraryAddressLabel.centerXAnchor.constraint(equalTo: distanceLabel.centerXAnchor)
           
        ])
    }
    
    func configCellViews(library name: String, distance points: String, address location: String) {
        libraryNameLabel.text = name
        distanceLabel.text = points
        libraryAddressLabel.text = location
    }
    
}
