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
        contentView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        contentView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        contentView.layer.shadowOpacity = 0.9
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 1
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
        taskLabelLabel.numberOfLines = 4
        taskLabelLabel.textAlignment = .center
//        taskLabelLabel.adjustsFontForContentSizeCategory = true
        taskLabelLabel.allowsDefaultTighteningForTruncation = true
        taskLabelLabel.translatesAutoresizingMaskIntoConstraints = false
        taskLabelLabel.font = UIFont(name: "Arial", size: 28)
        taskLabelLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return taskLabelLabel
    }()
    
    let distanceLabel: UILabel = {
        let distanceLabel = UILabel()
        distanceLabel.text = "0.9 mils"
        distanceLabel.contentMode = .center
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.font = UIFont(name: "Arial", size: 19)
        distanceLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return distanceLabel
    }()
    
    let libraryAddressLabel: UILabel = {
        let libraryAddressLabel = UILabel()
        libraryAddressLabel.text = "20.5 mils"
        libraryAddressLabel.contentMode = .center
        libraryAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        libraryAddressLabel.font = UIFont(name: "Arial", size: 15)
        libraryAddressLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return libraryAddressLabel
    }()
    
    func constrains(view: UIView) {
        NSLayoutConstraint.activate([
//            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            view.widthAnchor.constraint(equalToConstant: contentView.frame.size.width / 2 + 90),
            distanceLabel.topAnchor.constraint(equalTo: view.bottomAnchor),
            distanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            libraryAddressLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor),
            libraryAddressLabel.centerXAnchor.constraint(equalTo: distanceLabel.centerXAnchor)
           
        ])
    }
    
    func configCellViews(with data: Business) {
        libraryNameLabel.text = data.name
        distanceLabel.text = String(data.distance)
        libraryAddressLabel.text = data.location.address1
    }
    
}
