//
//  RideHistoryTableCell.swift
//  CabRider
//
//  Created by Anurag on 18/03/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import Foundation
import UIKit

class RideHistoryTableCell : UITableViewCell{
    let imgUser = UIImageView()
    let labUerName = UILabel()
    let labMessage = UILabel()
    let labTime = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgUser.backgroundColor = Style.AccentColor
        
        imgUser.translatesAutoresizingMaskIntoConstraints = false
        labUerName.translatesAutoresizingMaskIntoConstraints = false
        labMessage.translatesAutoresizingMaskIntoConstraints = false
        labTime.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imgUser)
        contentView.addSubview(labUerName)
        contentView.addSubview(labMessage)
        contentView.addSubview(labTime)
        labUerName.textColor = Style.TextColor
        labUerName.tg_width.equal(contentView.frame.width)
        labUerName.tg_height.equal(48)
        let viewsDict = [
            "image" : imgUser,
            "username" : labUerName,
            "message" : labMessage,
            "labTime" : labTime,
            ]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(10)]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[labTime]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[username]-[message]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[username]-[image(10)]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[message]-[labTime]-|", options: [], metrics: nil, views: viewsDict))
    }
}
