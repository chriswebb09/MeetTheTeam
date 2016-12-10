//
//  TeamCell.swift
//  Team
//
//  Created by Christopher Webb-Orenstein on 12/9/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class TeamCell: UICollectionViewCell {
    var client = APIClient()
    
    static let reuseIdentifier = "Cell"
    
    var teamMemberImage: UIImageView = {
        var teamMemberImage = UIImageView()
        teamMemberImage.layer.borderWidth = 2
        teamMemberImage.clipsToBounds = true
        return teamMemberImage
    }()
    
    var teamMemberNameLabel: UILabel = {
        var teamMemberNameLabel = UILabel()
        teamMemberNameLabel.sizeToFit()
        teamMemberNameLabel.font = UIFont(name: "HelveticaNeue", size: 22)
        return teamMemberNameLabel
    }()
    
    var teamMemberTitleLabel: UILabel = {
        var teamMemberTitleLabel = UILabel()
        teamMemberTitleLabel.sizeToFit()
        teamMemberTitleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        return teamMemberTitleLabel
    }()
    
    var teamMemberBioText: UITextView = {
        var teamMemberBioText = UITextView()
        teamMemberBioText.sizeToFit()
        teamMemberBioText.font = UIFont(name: "HelveticaNeue-Light", size: 11)
        teamMemberBioText.textAlignment = .center
        teamMemberBioText.isScrollEnabled = true
        teamMemberBioText.isEditable = false
        return teamMemberBioText
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        isUserInteractionEnabled = true
        backgroundColor = UIColor.white
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true;
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width:0,height: 2.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false;
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }
    
    func configureCell(teamMember: TeamMember) {
        layoutSubviews()
        setupConstraints()
        
        self.layoutIfNeeded()
        teamMemberImage.layer.cornerRadius =  teamMemberImage.frame.height / 2.0
        client.downloadImage(url: URL(string:teamMember.avatar)!, handler: { image in
            DispatchQueue.main.async {
                self.teamMemberImage.image = image
                self.teamMemberTitleLabel.text = teamMember.title
                self.teamMemberNameLabel.text = "\(teamMember.firstName) \(teamMember.lastName)"
                self.teamMemberBioText.text = teamMember.bio
            }
        })
    }
    
    func setupConstraints() {
        contentView.addSubview(teamMemberNameLabel)
        teamMemberNameLabel.translatesAutoresizingMaskIntoConstraints = false
        teamMemberNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: contentView.bounds.width * 0.2).isActive = true
        teamMemberNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: contentView.bounds.height * -0.12).isActive = true
        
        contentView.addSubview(teamMemberImage)
        teamMemberImage.translatesAutoresizingMaskIntoConstraints = false
        teamMemberImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: contentView.bounds.height * 0.1).isActive = true
        teamMemberImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        teamMemberImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4).isActive = true
        teamMemberImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8).isActive = true
        
        contentView.addSubview(teamMemberTitleLabel)
        teamMemberTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        teamMemberTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: contentView.bounds.width * 0.2).isActive = true
        teamMemberTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: contentView.bounds.height * 0.12).isActive = true
        
        contentView.addSubview(teamMemberBioText)
        teamMemberBioText.translatesAutoresizingMaskIntoConstraints = false
        teamMemberBioText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        teamMemberBioText.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35).isActive = true
        teamMemberBioText.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.98).isActive = true
        teamMemberBioText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: contentView.bounds.height * -0.05).isActive = true
    }
}


