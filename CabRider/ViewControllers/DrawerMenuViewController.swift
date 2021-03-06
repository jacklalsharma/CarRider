//
//  DrawerMenuViewController.swift
//  CabRider
//
//  Created by Anurag on 27/02/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import Foundation
import Material
import UIKit
import TangramKit
import Realm
import RealmSwift

class DrawerMenuViewController : DPBaseEmbedViewController {
    
    var user : CabUser? ;
    
    override init(nibName nibNameOrNil: String?,
                  bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
    }
    
    required internal init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm() ;
        user = realm.objects(CabUser.self).first ;
        
        print("HERE IN DRAWER MENU")
        print(self.view.frame.bounds.width)
        let linearlayout = TGLinearLayout(.vert) ;
        linearlayout.tg_width.equal(self.view.frame.bounds.width) ;
        linearlayout.tg_height.equal(self.view.frame.bounds.height) ;
        
        //App Logo...
        let logo = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50));
        logo.image = UIImage(named: "ic_user.png")
        logo.image = logo.image!.withRenderingMode(.alwaysTemplate)
        logo.tintColor = .white
        logo.tg_height.equal(80)
        logo.tg_left.equal(20)
        logo.tg_width.equal(80)
        logo.tg_centerX.equal(0)
        
        let name: UILabel = UILabel()
        let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)]
        let attributedString = NSMutableAttributedString(string: (user?.fName)!, attributes:attrs)
        name.attributedText = attributedString
        name.textColor = .white
        name.tg_left.equal(20)
        name.sizeToFit()
        name.tg_top.equal(35)
        
        let userLayout = TGLinearLayout(.horz) ;
        userLayout.tg_width.equal(self.view.frame.bounds.width) ;
        userLayout.tg_height.equal(80) ;
        userLayout.addSubview(logo)
        userLayout.addSubview(name)
        
        let profileBtn = FlatButton(title : "",  titleColor : .white)
        profileBtn.pulseColor = .white ;
        profileBtn.tg_width.equal(self.view.frame.bounds.width)
        profileBtn.tg_height.equal(80)
        profileBtn.titleLabel?.textAlignment = .left
        profileBtn.addTarget(self, action: #selector(openProfileVC), for: .touchUpInside)
        
        
        let relativelayout = TGRelativeLayout();
        relativelayout.tg_width.equal(self.view.frame.bounds.width) ;
        relativelayout.tg_height.equal(80);
        relativelayout.tg_top.equal(50)
        relativelayout.addSubview(userLayout)
        relativelayout.addSubview(profileBtn)
        relativelayout.tg_bottom.equal(30)
        
        linearlayout.addSubview(relativelayout)
        linearlayout.addSubview(getTrackRideMenu(imageName: "ic_track_rider.png",title: "Track Ride", tag: 0))
        linearlayout.addSubview(getTrackRideMenu(imageName: "ic_my_trips.png", title: "My Trips", tag: 1)) ;
        linearlayout.addSubview(getTrackRideMenu(imageName: "ic_create_trip.png", title: "Schedule Trip", tag: 2)) ;
        linearlayout.addSubview(getTrackRideMenu(imageName: "ic_trip_history.png", title: "Trip History", tag: 3)) ;
        linearlayout.addSubview(getTrackRideMenu(imageName: "ic_refer.png", title: "Refer To Friend", tag: 4)) ;
        self.view.addSubview(linearlayout) ;
        //linearlayout.backgroundColor = Style.AccentColor ;
        view.backgroundColor = Style.AccentColor
    }
    
    func getUIImageView(image : String) -> UIImageView{
        let logo = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35));
        logo.image = UIImage(named: image)
        logo.image = logo.image!.withRenderingMode(.alwaysTemplate)
        logo.tintColor = .white
        logo.tg_height.equal(35)
        logo.tg_left.equal(20)
        logo.tg_width.equal(35)
        logo.tg_top.equal(6)
        return logo;
    }
    
    func getUILabel(title : String) -> UILabel{
        let name: UILabel = UILabel()
        let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)]
        let attributedString = NSMutableAttributedString(string: title, attributes:attrs)
        name.attributedText = attributedString
        name.textColor = .white
        name.tg_top.equal(15)
        name.tg_left.equal(20)
        name.sizeToFit()
        return name;
    }
    
    func getFlatButton() -> FlatButton{
        let btn = FlatButton(title : "",  titleColor : .white)
        btn.pulseColor = .white ;
        btn.tg_width.equal(self.view.frame.bounds.width)
        btn.tg_height.equal(48)
        btn.titleLabel?.textAlignment = .left
        return btn ;
    }
    
    //Menu item returning Track Ride
    func getTrackRideMenu(imageName : String, title : String, tag : Int) -> TGRelativeLayout{
        let btn = getFlatButton() ;
        btn.addTarget(self, action: #selector(trackRideClick), for: .touchUpInside)
        
        let relativeLayout = TGRelativeLayout();
        relativeLayout.tg_width.equal(self.view.frame.bounds.width) ;
        relativeLayout.tg_height.equal(48) ;
        let logo = getUIImageView(image: imageName) ;
        let name: UILabel = getUILabel(title: title) ;
        
        let linearLayout = TGLinearLayout(.horz) ;
        linearLayout.tg_width.equal(self.view.frame.bounds.width) ;
        linearLayout.tg_height.equal(48) ;
        linearLayout.addSubview(logo) ;
        linearLayout.addSubview(name) ;
        
        relativeLayout.addSubview(linearLayout)
        btn.tag = tag
        btn.addTarget(self, action: #selector(trackRideClick(_:)), for: .touchUpInside)
        relativeLayout.addSubview(btn) ;
        return relativeLayout;
    }
    
    //Menu Item track ride click..
    @objc
    func trackRideClick(_ sender : UIButton){
        print(sender.tag)
        DPSlideMenuManager.shared.drawer?.leftClose()
        switch sender.tag {
        case 0:
            break
            
        case 1:
            break
            
        case 2:
            
            break
            
        case 3:
            present(TripHistoryVC(), animated: true, completion: nil);
            break
            
        case 4:
            
            break
            
        case 5:
            
            break
            
        case 6:
            
            break
            
        default:
            
            break;
        }
    }
    
    @objc
    func openProfileVC(){
        DPSlideMenuManager.shared.drawer?.leftClose()
        self.present(ProfileViewController(), animated: true, completion: nil)
    }
}


