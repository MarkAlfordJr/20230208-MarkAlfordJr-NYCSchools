//
//  SchoolResponseTableViewCell.swift
//  20230208-MarkAlfordJr-NYCSchools
//
//  Created by Mark Alford on 2/8/23.
//

import UIKit

class SchoolResponseTableViewCell: UITableViewCell {

    static let identifier = "SchoolResponseTableViewCell"
    
    // MARK: UI Components
    var dbnText: UILabel = {
        let text = UILabel()
        text.text = "dbn text"
        text.textAlignment = .left
        text.font = UIFont.boldSystemFont(ofSize: 12)
        text.numberOfLines = 0
        return text
    }()
    
    var schoolNameText: UILabel = {
        let text = UILabel()
        text.text = "School Name High"
        text.textAlignment = .left
        text.font = UIFont.boldSystemFont(ofSize: 16)
        text.numberOfLines = 0
        return text
    }()
    
    var phoneNumberText: UILabel = {
        let text = UILabel()
        text.text = "000-000-0000"
        text.textAlignment = .right
        text.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        text.numberOfLines = 0
        return text
    }()

    var neighborHoodText: UILabel = {
        let text = UILabel()
        text.text = "SchoolPark Creek"
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        text.numberOfLines = 0
        return text
    }()
    var locationText: UILabel = {
        let text = UILabel()
        text.text = "12345 Schoolview Ave City, ST, USA, 12343"
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        text.numberOfLines = 0
        return text
    }()

    //MARK: - Setup
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.systemBackground
        contentView.addSubview(dbnText)
        contentView.addSubview(schoolNameText)
        contentView.addSubview(phoneNumberText)
        contentView.addSubview(neighborHoodText)
        contentView.addSubview(locationText)
        subViewContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func subViewContraints() {
        dbnText.translatesAutoresizingMaskIntoConstraints = false
        schoolNameText.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberText.translatesAutoresizingMaskIntoConstraints = false
        neighborHoodText.translatesAutoresizingMaskIntoConstraints = false
        locationText.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // dbn text
            dbnText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dbnText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            // schoolName text
            schoolNameText.topAnchor.constraint(equalTo: dbnText.bottomAnchor, constant: 8),
            schoolNameText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            schoolNameText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            // phone number
            phoneNumberText.centerYAnchor.constraint(equalTo: dbnText.centerYAnchor),
            phoneNumberText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            // neighborhood text
            neighborHoodText.topAnchor.constraint(equalTo: schoolNameText.bottomAnchor, constant: 8),
            neighborHoodText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            // location text
            locationText.topAnchor.constraint(equalTo: neighborHoodText.bottomAnchor, constant: 8),
            locationText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            locationText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            locationText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    //MARK: - Value Configuration
    public func configureCell(dbn: String, school: String, phone: String, neighborhood: String, address: String) {
        dbnText.text = dbn
        schoolNameText.text = school
        phoneNumberText.text = phone
        neighborHoodText.text = neighborhood
        locationText.text = address
    }
}
