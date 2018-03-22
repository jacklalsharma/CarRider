//
//  RideLaterViewController.swift
//  CabRider
//
//  Created by Anurag on 22/03/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import Foundation
import TangramKit
import Material
import GooglePlaces

class RideLaterViewController : BaseViewController{
    
    var srcLabel : UILabel?
    var destLabel : UILabel?
    var isSrcMode : Bool? ;
    
    var pickupPlace : MyPlace! ;
    var dropPlace : MyPlace! ;
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight = UIApplication.shared.statusBarFrame.height

        let relativeLayout = TGRelativeLayout();
        relativeLayout.tg_width.equal(view.bounds.width)
        relativeLayout.tg_height.equal(view.bounds.height)
        relativeLayout.tg_top.equal(statusBarHeight)

        
        let addressLayout = TGLinearLayout(.vert)
        addressLayout.tg_width.equal(view.bounds.width - 40)
        addressLayout.tg_height.equal(100);
        addressLayout.addSubview(getTrackRideMenu(title: "Pickup Location", isSrcPlaceLabel: true))
        addressLayout.addSubview(getTrackRideMenu(title: "Drop Location", isSrcPlaceLabel: false))
        addressLayout.tg_centerX.equal(0)
        addressLayout.tg_top.equal(70)
        
        relativeLayout.addSubview(addressLayout)
        
        
        self.view.backgroundColor = Style.BackgroundColor
        self.view.addSubview(relativeLayout)
        relativeLayout.backgroundColor = Style.BackgroundColor
        
        relativeLayout.addSubview(getToolbar(title: "RIDE LATER", isBackMenu: true))
        menuButton.addTarget(self, action: #selector(onBackPressed), for: .touchUpInside)
        
        
    }
    
    @objc
    func onBackPressed(){
        //dismiss(animated: true, completion: nil)
        let picker = DateTimePicker.show()
        picker.highlightColor = Style.AccentColor
        picker.isDatePickerOnly = false // to hide time and show only date picker
        picker.completionHandler = { date in
            // do something after tapping done
        }
    }
    
    //Menu item returning Track Ride
    func getTrackRideMenu(title : String, isSrcPlaceLabel : Bool) -> TGRelativeLayout{
        let btn = getFlatButton() ;
        let relativeLayout = TGRelativeLayout();
        relativeLayout.tg_width.equal(self.view.frame.bounds.width) ;
        relativeLayout.tg_height.equal(48) ;
        let logo = getUIImageView(isSrcPlaceLabel: isSrcPlaceLabel) ;
        let name: UILabel = getUILabel(title: title) ;
        
        
        let linearLayout = TGLinearLayout(.horz) ;
        linearLayout.tg_width.equal(self.view.frame.bounds.width) ;
        linearLayout.tg_height.equal(48) ;
        linearLayout.addSubview(logo) ;
        linearLayout.addSubview(name) ;
        
        relativeLayout.addSubview(getRaisedButton())
        relativeLayout.addSubview(linearLayout)
        relativeLayout.addSubview(btn) ;
        relativeLayout.tg_centerY.equal(0)
        relativeLayout.tg_centerX.equal(0)
        
        if(isSrcPlaceLabel == true){
            srcLabel = name;
            srcLabel?.adjustsFontSizeToFitWidth = false
            srcLabel?.lineBreakMode = .byTruncatingTail
            btn.addTarget(self, action: #selector(openSrcPlaceSearch), for: .touchUpInside)
        }else{
            destLabel = name;
            destLabel?.lineBreakMode = .byTruncatingTail
            btn.addTarget(self, action: #selector(openDestPlaceSearch), for: .touchUpInside)
        }
        
        return relativeLayout;
    }
    
    //Returns the Flat Button with no text on it...
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
    
    //Returns the Image View having dot for address bar...
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
    
    //Returns the raised button with no text on it...
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
    
    //Returns the label for address bar...
    func getUILabel(title : String, marginTop : Int = 15, marginLeft : Int  = 10) -> UILabel{
        let name: UILabel = UILabel()
        //let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)]
        //let attributedString = NSMutableAttributedString(string: title, attributes:attrs)
        //name.attributedText = attributedString
        name.text = title
        name.tg_width.equal(view.frame.bounds.width - 60)
        name.textColor = Style.TextColor
        name.tg_top.equal(marginTop)
        name.tg_left.equal(marginLeft)
        name.sizeToFit()
        return name;
    }
    
    @objc
    func openSrcPlaceSearch(){
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self;
        self.present(autocompleteController, animated: true, completion: nil)
        isSrcMode = true;
    }
    
    @objc
    func openDestPlaceSearch(){
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self;
        self.present(autocompleteController, animated: true, completion: nil)
        isSrcMode = false;
    }
    
    func getLatLng(handler : @escaping (CLLocationCoordinate2D) -> Void){
        let geoCoder = CLGeocoder()
        var address : String! ;
        if(self.isSrcMode!){
            address = self.srcLabel?.text
        }else{
            address = self.destLabel?.text
        }
        
        geoCoder.geocodeAddressString(address, completionHandler: { (placemarks, error) -> Void in
            let placemark = placemarks![0];
            let lat = placemark.location?.coordinate.latitude ;
            let lng = placemark.location?.coordinate.longitude;
            
            if(self.isSrcMode!){
                self.pickupPlace = MyPlace()
                self.pickupPlace.address = address
                self.pickupPlace.lat = lat;
                self.pickupPlace.lng = lng;
            }else{
                self.dropPlace = MyPlace()
                self.dropPlace.address = address
                self.dropPlace.lat = lat;
                self.dropPlace.lng = lng;
            }
            
            let location = CLLocationCoordinate2D(latitude: lat as! CLLocationDegrees, longitude: lng as! CLLocationDegrees);
            handler(location)
            
        })
    }
}


extension RideLaterViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        //print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
        if(self.isSrcMode!){
            self.srcLabel?.text = place.formattedAddress
        }else{
            self.destLabel?.text = place.formattedAddress
        }
        
        getLatLng{
            (location) in
            if(self.isSrcMode == true){
                self.pickupPlace = MyPlace()
                self.pickupPlace.address = place.formattedAddress;
                self.pickupPlace.lat = location.latitude
                self.pickupPlace.lng = location.longitude
            }else{
                self.dropPlace = MyPlace()
                self.dropPlace.address = place.formattedAddress;
                self.dropPlace.lat = location.latitude
                self.dropPlace.lng = location.longitude
            }
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
