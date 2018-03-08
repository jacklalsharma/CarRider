//
//  PlaceSearchViewController.swift
//  CabRider
//
//  Created by Anurag on 07/03/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import Foundation
import UIKit
import Material
import TangramKit

class PlaceSearchViewController : BaseViewController{
    
    var bookRideVC : BookRideViewController? ;
    var label : UITextField? ;
    var isSrcMode : Bool? ;
    
    override
    func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);

        let height = UIApplication.shared.statusBarFrame.height

        let linearLayout = TGLinearLayout(.vert)
        linearLayout.tg_width.equal(self.view.frame.width)
        linearLayout.tg_height.equal(self.view.frame.height)
        linearLayout.backgroundColor = Style.BackgroundColor

        if(isSrcMode == true){
            linearLayout.addSubview(getToolbar(title: "SEARCH PICKUP LOCATION", isBackMenu: true))
            linearLayout.addSubview(getTrackRideMenu(title: "Select Pickup Location", isSrcPlaceLabel: true))
        }else{
            linearLayout.addSubview(getToolbar(title: "SEARCH DROP LOCATION", isBackMenu: true))
            linearLayout.addSubview(getTrackRideMenu(title: "Select Drop Location", isSrcPlaceLabel: false))
        }
        linearLayout.tg_top.equal(height)

        menuButton.addTarget(self, action: #selector(onBackPressed), for: .touchUpInside)
        self.view.addSubview(linearLayout)
    }
    
    @objc
    func onBackPressed(){
        dismiss(animated: true, completion: nil)
    }
    
    func getFlatButton() -> FlatButton{
        let btn = FlatButton(title : "",  titleColor : .white)
        btn.pulseColor = Style.TextColor ;
        btn.cornerRadiusPreset = CornerRadiusPreset.cornerRadius3
        btn.tg_width.equal(self.view.frame.bounds.width - 10)
        btn.tg_height.equal(48)
        btn.tg_centerX.equal(0)
        btn.titleLabel?.textAlignment = .left
        return btn ;
    }
    
    func getUIImageView(isSrcPlaceLabel : Bool) -> UIView{
        let logo = UIView();
        logo.tintColor = Style.AccentColor
        logo.backgroundColor = Style.AccentColor
        logo.tg_height.equal(12)
        logo.tg_left.equal(20)
        logo.tg_width.equal(12)
        logo.layer.cornerRadius = 6
        logo.tg_top.equal(18)
        if(isSrcPlaceLabel == true){
            logo.backgroundColor = Color.green.darken1
        }
        return logo;
    }
    
    func getUILabel(title : String) -> UILabel{
        let name: UILabel = UILabel()
        let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)]
        let attributedString = NSMutableAttributedString(string: title, attributes:attrs)
        name.attributedText = attributedString
        name.textColor = Style.TextColor
        name.tg_top.equal(15)
        name.tg_left.equal(10)
        name.sizeToFit()
        return name;
    }
    
    func getTextBox(title : String) -> UITextField{
        let textField = UITextField();
        textField.tg_left.equal(10)
        textField.text = title
        return textField;
    }
    
    func getRaisedButton() -> RaisedButton{
        let btn = RaisedButton(title : "",  titleColor : .white)
        btn.pulseColor = .white ;
        btn.cornerRadiusPreset = CornerRadiusPreset.cornerRadius3
        btn.tg_width.equal(self.view.frame.bounds.width - 10)
        btn.tg_centerX.equal(0)
        btn.tg_height.equal(48)
        btn.titleLabel?.textAlignment = .left
        return btn ;
    }
    
    //Menu item returning Track Ride
    func getTrackRideMenu(title : String, isSrcPlaceLabel : Bool) -> TGRelativeLayout{
        let btn = getFlatButton() ;
        let relativeLayout = TGRelativeLayout();
        relativeLayout.tg_width.equal(self.view.frame.bounds.width) ;
        relativeLayout.tg_height.equal(48) ;
        let logo = getUIImageView(isSrcPlaceLabel: isSrcPlaceLabel) ;
        let name: UITextField = getTextBox(title: title) ;
        
        
        let linearLayout = TGLinearLayout(.horz) ;
        linearLayout.tg_width.equal(self.view.frame.bounds.width) ;
        linearLayout.tg_height.equal(48) ;
        linearLayout.addSubview(logo) ;
        linearLayout.addSubview(name) ;
        
        relativeLayout.addSubview(getRaisedButton())
        relativeLayout.addSubview(linearLayout)
        //relativeLayout.addSubview(btn) ;
        relativeLayout.tg_centerY.equal(0)
        relativeLayout.tg_centerX.equal(0)
        relativeLayout.tg_top.equal(40)
        label = name;
        return relativeLayout;
    }
    
}
