//
//  VehicleViewCell.swift
//  CabRider
//
//  Created by Anurag on 06/03/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import Foundation
import UIKit
import Material

class VehicleViewCell : UICollectionViewCell{
    
    let profileImageButton: FlatButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.setImage(UIImage(named: "Profile"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let btn = FlatButton(title : "NAME",  titleColor : .white)
        btn.pulseColor = Style.TextColor ;
        btn.cornerRadiusPreset = CornerRadiusPreset.cornerRadius3
        btn.titleLabel?.textAlignment = .left
        //return btn ;
        
        
        
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    func addViews(){
        backgroundColor = Style.BackgroundColor
        addSubview(profileImageButton)
        profileImageButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        profileImageButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        profileImageButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        profileImageButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
