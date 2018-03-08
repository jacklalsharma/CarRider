//
//  OtpViewController.swift
//  CabRider
//
//  Created by Anurag on 25/02/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import Foundation
import Material
import UIKit
import TangramKit
import Alamofire
import RealmSwift
import Realm

class OtpViewController : BaseViewController{
    
    var login : Login?
    var isLogin : Bool?
    var signup : Signup?
    var mainView : UIView? ;
    var otpField : TextField?

    override
    func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight = UIApplication.shared.statusBarFrame.height

        //Or Label...
        let or: UILabel = UILabel()
        or.text = "Enter registered mobile number"
        or.textColor = Style.TextColor
        or.sizeToFit()
        or.tg_centerX.equal(0)
        or.tg_top.equal(25)
        
        
        //Number field.
        otpField = TextField()
        otpField?.tg_top.equal(12)
        otpField?.tg_bottom.equal(12)
        otpField?.tg_height.equal(.wrap)
        otpField?.tg_width.equal(UIScreen.main.bounds.width - 50)
        otpField?.placeholder = "ENTER OTP"
        otpField?.textAlignment = .center
        otpField?.detail = ""
        otpField?.textColor = Style.TextColor
        otpField?.detailLabel.isHidden = true
        otpField?.detailColor = Style.TextColor
        otpField?.placeholderLabel.textColor = Style.TextColor
        otpField?.dividerActiveColor = Style.AccentColor
        otpField?.placeholderActiveColor = Style.AccentColor
        otpField?.clearButtonMode = .whileEditing
        otpField?.keyboardType = UIKeyboardType.decimalPad
        otpField?.isVisibilityIconButtonEnabled = false
        otpField?.visibilityIconButton?.tintColor = Style.AccentColor
        
        //Number field layout
        let numberLayout = TGLinearLayout(.vert)
        numberLayout.tg_width.equal(self.view.frame.width - 50)
        numberLayout.tg_height.equal(.wrap)
        numberLayout.addSubview(otpField!)
        numberLayout.tg_centerX.equal(0)
        numberLayout.tg_top.equal(20)
        
        //Login button
        let btn = RaisedButton(title: "SUBMIT", titleColor: .white)
        btn.pulseColor = .white
        btn.backgroundColor = Style.AccentColor
        btn.tg_width.equal(UIScreen.main.bounds.width - 50)
        btn.tg_centerX.equal(0)
        btn.tg_height.equal(48)
        btn.tg_top.equal(20)
        
        let linearLayout = TGLinearLayout(.vert)
        linearLayout.tg_width.equal(self.view.frame.width)
        linearLayout.tg_height.equal(self.view.frame.height)
        linearLayout.tg_top.equal(statusBarHeight)
        linearLayout.addSubview(getToolbar(title: "OTP VERIFICATION", isBackMenu: true))
        linearLayout.addSubview(or)
        linearLayout.addSubview(numberLayout)
        linearLayout.addSubview(btn)
        
        mainView = self.view;
        mainView?.backgroundColor = Style.BackgroundColor
        mainView!.addSubview(linearLayout)
        requestOtp();
        btn.addTarget(self, action: #selector(submitOtp), for: .touchUpInside) ;
        menuButton.addTarget(self, action: #selector(onBackPressed), for: .touchUpInside)
    }
    
    @objc
    func onBackPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func submitOtp(){
        if((otpField?.text?.characters.count)! < 3){
            self.mainView?.showSnackMessage(descriptionText: "Enter valid OTP.", duration: SnackbarDuration.SHORT, type: SnackType.ERROR) ;
            return ;
        }
        
        var token : String? = "" ;
        if(isLogin!){
            token = login!.data.accesssToken;
        }else {
            token = signup!.data.accesssToken ;
        }
        
        let headers: HTTPHeaders = [
            "Authorization": token!
        ]
        
        let otp_code = otpField?.text;
        
        let parameters: Parameters = ["otp_code": otp_code] ;
        let dialogBox = ConstructDialog.ConstructProgressDialog(dialogTitle: "OTP Request", dialogMessage: "Please wait while we are requesting for the OTP...")
        self.present(dialogBox, animated: true, completion: nil)

        Alamofire.request(Endpoints.VERIFY_OTP, method: .post ,parameters : parameters, encoding: JSONEncoding.default ,headers:headers).responseJSON {response in
            print(response)

            let json = response.result.value as! [String : AnyObject] ;
            let success = json["success"] as! Bool
            if(success){
                self.saveUser() ;
                self.mainView!.showSnackMessage(descriptionText: "OTP successfully verified.", duration: SnackbarDuration.SHORT, type: SnackType.SUCCESS);
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0){
                    dialogBox.dismiss(animated: false, completion: nil) ;
                    self.dismiss(animated: true, completion: nil) ;
                    //self.present(BookRideViewController(), animated: true, completion: nil);
                }
            }else{
                dialogBox.dismiss(animated: true, completion: nil) ;
                self.mainView!.showSnackMessage(descriptionText: "OTP verification failed, try later.", duration: SnackbarDuration.SHORT, type: SnackType.ERROR);
            }
        }
    }
    
    func requestOtp(){
        var token : String? = "" ;
        if(isLogin!){
            token = login!.data.accesssToken;
        }else {
            token = signup!.data.accesssToken ;
        }
        let dialogBox = ConstructDialog.ConstructProgressDialog(dialogTitle: "OTP Request", dialogMessage: "Please wait while we are requesting for the OTP...")
        self.present(dialogBox, animated: true, completion: nil)
        
        let headers: HTTPHeaders = [
            "Authorization": token!
        ]
        let parameters: Parameters = ["":""] ;
        print(token!)
        
        
        Alamofire.request(Endpoints.REQUEST_OTP, method: .post ,parameters : parameters, encoding: JSONEncoding.default ,headers:headers).responseJSON {response in
            print(response)
            let json = response.result.value as! [String:AnyObject] ;
            let success = json["success"] as! Int ;
            if(success == 1){
                self.mainView!.showSnackMessage(descriptionText: "OTP successfully requested.", duration: SnackbarDuration.SHORT, type: SnackType.SUCCESS)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0){
                    dialogBox.dismiss(animated: false, completion: nil) ;
                }
            }else{
                dialogBox.dismiss(animated: false, completion: nil) ;
                self.mainView!.showSnackMessage(descriptionText: "OTP successfully requested.", duration: SnackbarDuration.SHORT, type: SnackType.ERROR)
            }
        }
    }
    
    func saveUser(){
        let realm = try! Realm() ;
        let user : CabUser = CabUser() ;
        if(isLogin!){
            user.accessToken = (login?.data.accesssToken)! ;
            user.countryCode = (login?.data.user.countryCode)! ;
            user.email = (login?.data.user.email)! ;
            user.fName = (login?.data.user.fname)! ;
            user.lName = (login?.data.user.lname)! ;
            user.id = (login?.data.user.id)! ;
            user.mobileNumber = (login?.data.user.mobileNumber)! ;
        }else{
            user.accessToken = (signup?.data.accesssToken)! ;
            user.countryCode = (signup?.data.user.countryCode)! ;
            user.email = (signup?.data.user.email)! ;
            user.fName = (signup?.data.user.fname)! ;
            user.lName = (signup?.data.user.lname)! ;
            user.id = (signup?.data.user.id)! ;
            user.mobileNumber = (signup?.data.user.mobileNumber)! ;
        }
        
        try! realm.write {
            realm.add(user) ;
            print("Saving USER")
        }
    }

}
