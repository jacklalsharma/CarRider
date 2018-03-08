//
//  ViewController.swift
//  CabRider
//
//  Created by Anurag on 15/02/18.
//  Copyright © 2018 Anurag. All rights reserved.
//

import UIKit
import Foundation
import NVActivityIndicatorView
import TangramKit
import RealmSwift
import Realm

class ViewController: UIViewController, NVActivityIndicatorViewable  {
    
    var token : String? ;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        super .loadView()
        
        print(self.restorationIdentifier)

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "rider_splash.png")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        //self.view.insertSubview(backgroundImage, at: 0)
        
        
        //Mask Color
        let maskColor = UIImageView(frame: UIScreen.main.bounds)
        maskColor.contentMode = UIViewContentMode.scaleAspectFill
        maskColor.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let relativeLayout = TGRelativeLayout()
        relativeLayout.tg_backgroundImage = backgroundImage.image
        self.view = relativeLayout
        
        //App Name Label...
        let name: UILabel = UILabel()
        let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 35)]
        let attributedString = NSMutableAttributedString(string: "High Way Trip Rider", attributes:attrs)
        name.attributedText = attributedString
        name.textColor = Style.AccentColor
        name.sizeToFit()
        name.tg_centerX.equal(0)
        name.tg_top.equal(0)
        
        //App Logo...
        let logo = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120));
        logo.image = UIImage(named: "ic_logo_img.png")
        logo.image = logo.image!.withRenderingMode(.alwaysTemplate)
        logo.tintColor = Style.AccentColor
        logo.tg_centerX.equal(0)
        logo.tg_top.equal(20)
        
        let loaderFrame = CGRect(x: 0, y: 0, width: 70, height: 70)
        let loader = NVActivityIndicatorView(frame: loaderFrame, type: NVActivityIndicatorType.lineScalePulseOut, color: Style.AccentColor, padding: 0)
        loader.tg_centerX.equal(0)
        loader.tg_top.equal(30)
        loader.startAnimating()
        
        
        //App Loding Label...
        let loading: UILabel = UILabel()
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 35)]
        let attributedString2 = NSMutableAttributedString(string: "Loading...", attributes:attrs2)
        loading.attributedText = attributedString2
        loading.textColor = Style.AccentColor
        loading.sizeToFit()
        loading.tg_centerX.equal(0)
        loading.tg_top.equal(30)
        
        
        let linearLayout = TGLinearLayout(.vert)
        linearLayout.tg_width.equal(relativeLayout.frame.width)
        linearLayout.tg_height.equal(.wrap)
        linearLayout.addSubview(name)
        linearLayout.addSubview(logo)
        linearLayout.addSubview(loader)
        linearLayout.addSubview(loading)
        
        linearLayout.tg_centerY.equal(0)
        linearLayout.tg_centerX.equal(0)
        
        relativeLayout.addSubview(maskColor)
        relativeLayout.addSubview(linearLayout)
        
        let realm = try! Realm() ;
        let user = realm.objects(CabUser.self).first ;
        if(user != nil){
            print(user?.id)
            token = (user?.accessToken)!;
            print(token)
        }else{
            token = "NULL" ;
            print(token)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0){
            if (self.token == "NULL"){
                self.present(OnBoardingViewController(), animated: true, completion: nil);
            }else{
                //self.present(ForgotPasswordViewController(), animated: true, completion: nil);
                
                let bookRideCV = BookRideViewController() ;
                bookRideCV.user = user;
                self.present(NavigationViewController(), animated: true, completion: nil);
                //self.performSegue(withIdentifier: "loadBookRideCV", sender: self)
            }
        }
    }
    
    override
    func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let size = CGSize(width: 30, height: 30)
        
        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType(rawValue: sender.tag)!)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage("Authenticating...")
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.stopAnimating()
        }
    }
    
}

