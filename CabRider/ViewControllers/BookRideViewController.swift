//
//  BookRideViewController.swift
//  CabRider
//
//  Created by Anurag on 26/02/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import TangramKit
import Material
import NVActivityIndicatorView
import Alamofire
import RealmSwift
import Realm

class BookRideViewController : DPCenterContentViewController, UISearchDisplayDelegate{
    var menuButton: IconButton!

    var vehicleTypes : VehicleTypes? ;
    var googleMap : GMSMapView? ;
    var mapInited : Bool? ;
    
    var user : CabUser? ;
    var srcLabel : UILabel?
    var destLabel : UILabel?
    var isSrcMode : Bool? ;
    var dot : UIView?
    let BOTTOM_LAYOUT_HEIGHT = 100;
    let BTN_LAYOUT_HEIGHT = 48;
    let VEHICLE_LIST_LAYOUT_HEIGHT = 52;
    
    var vehicleListLayout : TGLinearLayout? ;
    var loader : NVActivityIndicatorView? ;
    var loaderText : UILabel? ;
    
    
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm() ;
        user = realm.objects(CabUser.self).first ;
        
        mapInited = false;
        isSrcMode = true;
        //Status bar color change
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = Style.AccentColor
        }
        UIApplication.shared.statusBarStyle = .lightContent
        let height = UIApplication.shared.statusBarFrame.height
        
        let camera = GMSCameraPosition.camera(withLatitude: 12.9716, longitude: 77.5946, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.tg_height.equal(view.bounds.height)
        mapView.tg_width.equal(view.bounds.width)
        mapView.isMyLocationEnabled = true ;
        mapView.delegate = self
        
        
        let relative = TGLinearLayout(.vert)
        relative.tg_height.equal(view.bounds.height)
        relative.tg_width.equal(view.bounds.width)
        
        relative.addSubview(getToolbar(title: "HIGH WAY TRIP RIDE", isBackMenu: false, isMarginBottom: true))
        relative.addSubview(mapView)
        
        let main = TGRelativeLayout()
        main.tg_height.equal(view.bounds.height)
        main.tg_width.equal(view.bounds.width)
        main.addSubview(relative)
        
        let addressLayout = TGLinearLayout(.vert)
        addressLayout.tg_width.equal(view.bounds.width - 40)
        addressLayout.tg_height.equal(100);
        addressLayout.addSubview(getTrackRideMenu(title: "Pickup Location", isSrcPlaceLabel: true))
        addressLayout.addSubview(getTrackRideMenu(title: "Drop Location", isSrcPlaceLabel: false))
        addressLayout.tg_centerX.equal(0)
        addressLayout.tg_top.equal(70)
        
        main.addSubview(addressLayout)
        let marker = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35));
        marker.image = UIImage(named: "bg_markerhome.9.png")
        marker.tg_height.equal(50)
        marker.tg_width.equal(70)
        marker.tg_centerX.equal(0)
        marker.tg_centerY.equal(0)
        main.addSubview(marker)
        
        dot = UIView();
        dot?.tg_width.equal(12)
        dot?.tg_height.equal(12)
        dot?.layer.cornerRadius = 6;
        dot?.backgroundColor = Color.green.darken1
        dot?.tg_centerY.equal(-5)
        dot?.tg_centerX.equal(0)
        main.addSubview(dot!)
        
        let bottomLayout = TGLinearLayout(.vert)
        bottomLayout.tg_width.equal(view.bounds.width)
        bottomLayout.tg_height.equal(100)
        bottomLayout.tg_centerX.equal(0)
        
        vehicleListLayout = TGLinearLayout(.horz);
        vehicleListLayout?.tg_width.equal(view.bounds.width)
        vehicleListLayout?.tg_height.equal(VEHICLE_LIST_LAYOUT_HEIGHT)
        vehicleListLayout?.tg_centerX.equal(0)
        vehicleListLayout?.backgroundColor = Style.BackgroundColor
        
        let loaderFrame = CGRect(x: 0, y: 0, width: 70, height: 40)
        loader = NVActivityIndicatorView(frame: loaderFrame, type: NVActivityIndicatorType.lineScalePulseOut, color: Style.AccentColor, padding: 0)
        loader?.tg_top.equal(6)
        loader?.startAnimating()
        vehicleListLayout?.addSubview(loader!)
        loaderText = getUILabel(title: "Loading vehicles near to you");
        vehicleListLayout?.addSubview(loaderText!)
        bottomLayout.addSubview(vehicleListLayout!)
        
        let btnLayout = TGLinearLayout(.horz)
        btnLayout.tg_width.equal(view.bounds.width)
        btnLayout.tg_height.equal(48)
        btnLayout.addSubview(getRaisedButton(title: "RIDE LATER", isRideNowBtn : false))
        btnLayout.addSubview(getRaisedButton(title: "RIDE NOW", isRideNowBtn : true))
        btnLayout.tg_centerX.equal(0)
        main.tg_top.equal(height)

        bottomLayout.addSubview(btnLayout)
        bottomLayout.tg_centerY.equal((view.frame.size.height)/2 - 100 + 50 - height)
        main.addSubview(bottomLayout)
        self.view.addSubview(main)
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
    
    //Returns the Flat Button with no text on it...
    func getFlatButton() -> FlatButton{
        let btn = FlatButton(title : "",  titleColor : .white)
        btn.pulseColor = Style.TextColor ;
        btn.cornerRadiusPreset = CornerRadiusPreset.cornerRadius3
        btn.tg_width.equal(self.view.frame.bounds.width - 10)
        btn.tg_height.equal(BTN_LAYOUT_HEIGHT)
        btn.tg_centerX.equal(0)
        btn.titleLabel?.textAlignment = .left
        return btn ;
    }
    
    //Returns the flat button with specified width and height...
    func getFlatButton(width : Int , height : Int) -> FlatButton{
        let btn = FlatButton(title : "",  titleColor : .white)
        btn.pulseColor = Style.TextColor ;
        btn.cornerRadiusPreset = CornerRadiusPreset.cornerRadius3
        btn.tg_width.equal(width - 10)
        btn.tg_height.equal(height)
        btn.tg_centerX.equal(0)
        btn.titleLabel?.textAlignment = .left
        return btn ;
    }
    
    //Returns the raised button for address bar...
    func getRaisedButton(title : String, isRideNowBtn : Bool) -> RaisedButton{
        let btn = RaisedButton(title : title,  titleColor : .white)
        btn.backgroundColor = Style.AccentColor
        if(isRideNowBtn == false){
            btn.titleLabel?.textColor = .black
            btn.backgroundColor = Style.TextColor
        }
        btn.pulseColor = .white ;
        btn.tg_width.equal(self.view.frame.bounds.width/2)
        btn.tg_centerX.equal(0)
        btn.tg_height.equal(BTN_LAYOUT_HEIGHT)
        btn.titleLabel?.textAlignment = .left
        return btn ;
    }
    
    //Returns the raised button with no text on it...
    func getRaisedButton() -> RaisedButton{
        let btn = RaisedButton(title : "",  titleColor : .white)
        btn.pulseColor = .white ;
        btn.cornerRadiusPreset = CornerRadiusPreset.cornerRadius3
        btn.tg_width.equal(self.view.frame.bounds.width - 10)
        btn.tg_centerX.equal(0)
        btn.tg_height.equal(BTN_LAYOUT_HEIGHT)
        btn.titleLabel?.textAlignment = .left
        return btn ;
    }
    
    //Returns the raised button with specified width and height...
    func getRaisedButton(width : Int, height : Int) -> RaisedButton{
        let btn = RaisedButton(title : "",  titleColor : .white)
        btn.pulseColor = .white ;
        btn.cornerRadiusPreset = CornerRadiusPreset.cornerRadius3
        btn.tg_width.equal(width - 10)
        btn.tg_centerX.equal(0)
        btn.tg_height.equal(height)
        btn.titleLabel?.textAlignment = .left
        return btn ;
    }
    
    //Menu item returning Track Ride
    func getTrackRideMenu(title : String, isSrcPlaceLabel : Bool) -> TGRelativeLayout{
        let btn = getFlatButton() ;
        let relativeLayout = TGRelativeLayout();
        relativeLayout.tg_width.equal(self.view.frame.bounds.width) ;
        relativeLayout.tg_height.equal(BTN_LAYOUT_HEIGHT) ;
        let logo = getUIImageView(isSrcPlaceLabel: isSrcPlaceLabel) ;
        let name: UILabel = getUILabel(title: title) ;
        
        
        let linearLayout = TGLinearLayout(.horz) ;
        linearLayout.tg_width.equal(self.view.frame.bounds.width) ;
        linearLayout.tg_height.equal(BTN_LAYOUT_HEIGHT) ;
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
    
    @objc
    func openSrcPlaceSearch(){
        let placeSearchVC = PlaceSearchViewController();
        placeSearchVC.bookRideVC = self;
        placeSearchVC.isSrcMode = true;

        
        self.present(placeSearchVC, animated: true, completion: nil)
        isSrcMode = true;
        dot?.backgroundColor = Color.green.darken1;
    }
    
    @objc
    func openDestPlaceSearch(){
        let placeSearchVC = PlaceSearchViewController();
        placeSearchVC.bookRideVC = self;
        placeSearchVC.isSrcMode = false;
        self.present(placeSearchVC, animated: true, completion: nil)
        isSrcMode = false;
        dot?.backgroundColor = Color.red.darken1
    }
    
    func getVehicleImage(image : String) -> UIImageView{
        let logo = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 40));
        var imageType : String? ;
        if(image == "MICRO"){
            imageType = "ic_cab_selection_micro_pressed.png";
        }else if(image == "MINI"){
            imageType = "ic_cab_selection_mini_pressed.png";
        }else if(image == "SEDAN"){
            imageType = "ic_cab_selection_sedan_pressed.png"
        }else if(image == "AUTO"){
            imageType = "ic_cab_selection_erick_pressed.png"
        }else if(image == "PRIME"){
            imageType = "ic_cab_prime_pressed.png";
        }else{
            imageType = "ic_cab_selection_sedan_pressed.png"
        }
        
        logo.image = UIImage(named: imageType!)
        logo.tg_height.equal(40)
        logo.tg_left.equal(10)
        logo.tg_width.equal(35)
        logo.tg_top.equal(2)
        return logo;
    }
    
    func getVehicleCell(data : Vtype, tag : Int) -> UIView{
        let btn = getFlatButton(width : 120, height : 40) ;
        let relativeLayout = TGRelativeLayout();
        relativeLayout.tg_width.equal(120) ;
        relativeLayout.tg_height.equal(40) ;
        let logo = getVehicleImage(image: data.code) ;
        let name: UILabel = getUILabel(title: data.name, marginTop: 12, marginLeft: 8) ;
        
        let linearLayout = TGLinearLayout(.horz) ;
        linearLayout.tg_width.equal(120) ;
        linearLayout.tg_height.equal(40) ;
        linearLayout.addSubview(logo) ;
        linearLayout.addSubview(name) ;
        
        relativeLayout.addSubview(getRaisedButton(width : 120, height : 40))
        relativeLayout.addSubview(linearLayout)
        relativeLayout.addSubview(btn) ;
        btn.tag = tag
        btn.addTarget(self, action: #selector(self.vehicleTypesListItemClick(sender:)), for: .touchUpInside)
        relativeLayout.tg_centerY.equal(0)
        relativeLayout.tg_centerX.equal(0)
        
        let uiView = UIView()
        uiView.tg_width.equal(120)
        uiView.tg_height.equal(40)
        uiView.addSubview(relativeLayout)
        return uiView;
    }
    
    //Click listener on the item present in list of vehicle types in horizontal
    //scroll view
    @objc
    func vehicleTypesListItemClick(sender: UIButton){
        print(sender.tag)
        getNearbyDrivers(vehicleCode: (vehicleTypes?.data.vtypes[sender.tag].code)!);
    }
    
    func addNearbyVehiclesList(vehicleTypes : VehicleTypes) -> ASHorizontalScrollView{
        
        let horizontalScrollView:ASHorizontalScrollView = ASHorizontalScrollView(frame:CGRect(x: 0, y: 0, width: view.frame.size.width, height: 52))
        horizontalScrollView.marginSettings_320 = MarginSettings(leftMargin: 5, miniMarginBetweenItems: 1, miniAppearWidthOfLastItem: 20)
        horizontalScrollView.marginSettings_480 = MarginSettings(leftMargin: 5, miniMarginBetweenItems: 1, miniAppearWidthOfLastItem: 20)
        horizontalScrollView.marginSettings_414 = MarginSettings(leftMargin: 5, miniMarginBetweenItems: 1, miniAppearWidthOfLastItem: 20)
        horizontalScrollView.marginSettings_736 = MarginSettings(leftMargin: 5, miniMarginBetweenItems: 2, miniAppearWidthOfLastItem: 30)
        horizontalScrollView.defaultMarginSettings = MarginSettings(leftMargin: 5, miniMarginBetweenItems: 2, miniAppearWidthOfLastItem: 20)
        horizontalScrollView.uniformItemSize = CGSize(width: 120, height: 52)
        //horizontalScrollView.setItemsMarginOnce()
        
        
        
        for index in 0...vehicleTypes.data.vtypes.count - 1{
            if(index == 0){
                getNearbyDrivers(vehicleCode: vehicleTypes.data.vtypes[index].code)
            }
            horizontalScrollView.addItem(getVehicleCell(data : vehicleTypes.data.vtypes[index], tag : index))
        }
        return horizontalScrollView;
    }
    
    /**
     * This function is to load the types of vehicles available
     * like mini, sedan, micro, etc...
     */
    func getVehicleTypes(){
        let url = Endpoints.VEHICLE_TYPES

        Alamofire.request(url)
        .responseJSON { response in
            print(response)
            if(response.result.value == nil){
                self.view.showSnackMessage(descriptionText: "Failed to fetch vehicle details", duration: SnackbarDuration.SHORT, type: SnackType.ERROR)
            }else{
                let responseJSON = response.result.value as! [String:AnyObject]
                let success = responseJSON["success"] as! Int
                
                if( success == 0){
                    self.view.showSnackMessage(descriptionText: "Failed to fetch vehicle details", duration: SnackbarDuration.SHORT, type: SnackType.ERROR)
                }else{
                    let decoder = JSONDecoder()
                    self.vehicleTypes = try! decoder.decode(VehicleTypes.self, from: response.data!)
                    self.loader?.isHidden = true
                    self.loaderText?.isHidden = true
                    self.vehicleListLayout?.addSubview(self.addNearbyVehiclesList(vehicleTypes: self.vehicleTypes!))
                }
            }
        }
    }
    
    /**
     * This function is to load the list of drivers of particular vehcile like mini available near to user's current
     * location and show them into the google map.
     */
    func getNearbyDrivers(vehicleCode : String){
        let lat = googleMap?.camera.target.latitude as! Double;
        let lng = googleMap?.camera.target.longitude as! Double;
        var url = Endpoints.NEARBY_DRIVERS;
        
        url.append("/")
        url.append(String(format : "%f", lat))
        url.append(",")
        url.append(String(format : "%f", lng))
        url.append("/")
        url.append(vehicleCode)
        print(url)
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Helper.getAuthHeader(token: (user?.accessToken)!)).responseJSON{response in
            print(response)
        }
    }
    
    //Toolbar for this view controller
    func getToolbar(title : String, isBackMenu : Bool, isMarginBottom : Bool = false) -> Card{
        if(isBackMenu == true){
            menuButton = IconButton(image: Icon.cm.arrowBack, tintColor: Color.grey.base)
        }else{
            menuButton = IconButton(image: Icon.cm.menu, tintColor: Color.grey.base)
            menuButton.addTarget(self, action: #selector(toggleDrawer), for: .touchUpInside)
        }
        
        let toolbar = Toolbar(leftViews: [menuButton])
        toolbar.title = title
        toolbar.titleLabel.textColor = Style.AccentColor
        toolbar.titleLabel.textAlignment = .left
        toolbar.tg_height.equal(45)
        toolbar.tg_width.equal(Screen.bounds.width)
        toolbar.detail = ""
        toolbar.detailLabel.textAlignment = .left
        toolbar.detailLabel.textColor = Color.grey.base
        //toolbar.tg_top.equal(5)
        
        let card = Card()
        card.tg_width.equal(Screen.bounds.width)
        card.tg_height.equal(45)
        card.borderColor = .red
        card.toolbar = toolbar
        card.toolbarEdgeInsetsPreset = .square3
        card.toolbarEdgeInsets.bottom = 5
        card.toolbarEdgeInsets.right = 8
        card.toolbarEdgeInsets.left = 0
        //
        if(isMarginBottom){
            //card.tg_top.equal(8)
            card.tg_bottom.equal(8)
        }
        return card;
    }
    
    //Opens or closes the drawer menu...
    @objc
    func toggleDrawer(){
        if DPSlideMenuManager.shared.drawer?.drawerState == .leftOpen {
            DPSlideMenuManager.shared.drawer?.leftClose()
        } else {
            DPSlideMenuManager.shared.drawer?.leftOpen()
        }
    }
    
    //Gets the address of the center of google maps' lat and lng...
    func getAddress(handler: @escaping (String) -> Void)
    {
        var address: String = ""
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: (googleMap?.camera.target.latitude)!, longitude: (googleMap?.camera.target.longitude)!)
        //selectedLat and selectedLon are double values set by the app in a previous process
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark?
            placeMark = placemarks?[0]
            
            // Address dictionary
            //print(placeMark.addressDictionary ?? "")
            
            // Location name
            if let locationName = placeMark?.addressDictionary?["Name"] as? String {
                address += locationName + ", "
            }
            
            // Street address
            if let street = placeMark?.addressDictionary?["Thoroughfare"] as? String {
                address += street + ", "
            }
            
            // City
            if let city = placeMark?.addressDictionary?["City"] as? String {
                address += city + ", "
            }
            
            // Zip code
            if let zip = placeMark?.addressDictionary?["ZIP"] as? String {
                //address += zip + ", "
            }
            
            // Country
            if let country = placeMark?.addressDictionary?["Country"] as? String {
                //address += country
            }
            
            // Passing address back
            handler(address)
        })
    }
    
}



//Google map extension
extension BookRideViewController : GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        //This method is called each time the map stops moving and settles in a new position, where you then make a call to
        //reverse geocode the new position and update the addressLabel‘s text.
        
        if(mapInited == false){
            self.getVehicleTypes()
            self.googleMap = mapView;
            mapInited = true;
        }
        getAddress{
            (address) in
                print(address)
            if(self.isSrcMode == true){
                self.srcLabel?.text = address;
            }else{
                self.destLabel?.text = address ;
            }
        }
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        //This method runs when the user taps the Locate button; the map will then center on the user’s location.
        //Returning false again indicates that it does not override the default behavior when tapping the button.
        return false;
    }
    
    func mapViewSnapshotReady(_ mapView: GMSMapView) {
        // map ready to use
    }
    
    
}


