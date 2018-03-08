//
//  ForgotPasswordViewController.swift
//  CabRider
//
//  Created by Anurag on 26/02/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import Foundation
import UIKit
import TangramKit
import MRCountryPicker
import Material
import Alamofire

class ForgotPasswordViewController : BaseViewController , MRCountryPickerDelegate{
 
    var mainView : UIView? ;
    var code : String? ;
    var numberField : TextField?
    var otpField : TextField? ;
    var newPassField : TextField? ;
    var info : UILabel? ;
    var btn : RaisedButton? ;
    var otpSent : Bool? ;
    var countryCode : MRCountryPicker? ;
    
    override
    func viewDidLoad() {
        super.viewDidLoad()

        otpSent = false;
        
        //Enter Label...
        let or: UILabel = UILabel()
        or.text = "Enter registered mobile number"
        or.textColor = Style.TextColor
        or.sizeToFit()
        or.tg_centerX.equal(0)
        or.tg_top.equal(20)
        
        
        //Country code picker...
        code = "+91"
        countryCode = MRCountryPicker()
        countryCode?.tg_height.equal(100)
        countryCode?.tg_width.equal(self.view.frame.width - 50)
        countryCode?.setCountryByName("India")
        countryCode?.tg_centerX.equal(0)
        countryCode?.countryPickerDelegate = self
        
        
        //Number field.
        numberField = TextField()
        numberField?.tg_top.equal(12)
        numberField?.tg_bottom.equal(12)
        numberField?.tg_height.equal(.wrap)
        numberField?.tg_width.equal(UIScreen.main.bounds.width - 50)
        numberField?.placeholder = "Mobile Number"
        numberField?.detail = ""
        numberField?.textColor = Style.TextColor
        numberField?.detailLabel.isHidden = true
        numberField?.detailColor = Style.TextColor
        numberField?.placeholderLabel.textColor = Style.TextColor
        numberField?.dividerActiveColor = Style.AccentColor
        numberField?.placeholderActiveColor = Style.AccentColor
        numberField?.clearButtonMode = .whileEditing
        numberField?.keyboardType = UIKeyboardType.decimalPad
        numberField?.isVisibilityIconButtonEnabled = false
        numberField?.visibilityIconButton?.tintColor = Style.AccentColor
        
        //Number field layout
        let numberLayout = TGLinearLayout(.vert)
        numberLayout.tg_width.equal(self.view.frame.width - 50)
        numberLayout.tg_height.equal(.wrap)
        numberLayout.addSubview(numberField!)
        numberLayout.tg_centerX.equal(0)

        //Info Label...
        info = UILabel()
        info?.text = "The password reset OTP has been sent to your registered mail and mobile number."
        info?.textColor = Style.TextColor
        info?.tg_width.equal(UIScreen.main.bounds.width - 50)
        info?.tg_height.equal(.wrap)
        info?.sizeToFit()
        info?.textAlignment = .center
        info?.numberOfLines = 5;
        info?.tg_centerX.equal(0)
        info?.tg_top.equal(12)
        info?.isHidden = true ;
        
        //Otp field.
        otpField = TextField()
        otpField?.tg_top.equal(12)
        otpField?.tg_bottom.equal(12)
        otpField?.tg_height.equal(.wrap)
        otpField?.tg_width.equal(UIScreen.main.bounds.width - 50)
        otpField?.placeholder = "Otp"
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
        otpField?.isHidden = true ;
        
        
        //Otp field layout
        let otpLayout = TGLinearLayout(.vert)
        otpLayout.tg_width.equal(self.view.frame.width - 50)
        otpLayout.tg_height.equal(.wrap)
        otpLayout.addSubview(otpField!)
        otpLayout.tg_centerX.equal(0)
        otpLayout.tg_top.equal(20)
        
        
        
        //New pass field.
        newPassField = TextField()
        newPassField?.tg_top.equal(12)
        newPassField?.tg_bottom.equal(12)
        newPassField?.tg_height.equal(.wrap)
        newPassField?.tg_width.equal(UIScreen.main.bounds.width - 50)
        newPassField?.placeholder = "New Password"
        newPassField?.detail = ""
        newPassField?.textColor = Style.TextColor
        newPassField?.detailLabel.isHidden = true
        newPassField?.detailColor = Style.TextColor
        newPassField?.placeholderLabel.textColor = Style.TextColor
        newPassField?.dividerActiveColor = Style.AccentColor
        newPassField?.placeholderActiveColor = Style.AccentColor
        newPassField?.clearButtonMode = .whileEditing
        newPassField?.keyboardType = UIKeyboardType.decimalPad
        newPassField?.isVisibilityIconButtonEnabled = false
        newPassField?.visibilityIconButton?.tintColor = Style.AccentColor
        newPassField?.isHidden = true;
        
        //New pass field layout
        let newLayout = TGLinearLayout(.vert)
        newLayout.tg_width.equal(self.view.frame.width - 50)
        newLayout.tg_height.equal(.wrap)
        newLayout.addSubview(newPassField!)
        newLayout.tg_centerX.equal(0)
        newLayout.tg_top.equal(8)
        
        
        let height = UIApplication.shared.statusBarFrame.height
        //button
        btn = RaisedButton(title: "REQUEST PASSWORD CHANGE", titleColor: .white)
        btn?.pulseColor = .white
        btn?.backgroundColor = Style.AccentColor
        btn?.tg_width.equal(UIScreen.main.bounds.width)
        btn?.tg_centerX.equal(0)
        btn?.tg_height.equal(48)
        btn?.tg_centerY.equal((view.frame.size.height)/2 - 48 + 24)
        btn?.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        
        let linearLayout = TGLinearLayout(.vert)
        linearLayout.tg_width.equal(self.view.frame.width)
        linearLayout.tg_height.equal(self.view.frame.height)
        linearLayout.tg_top.equal(height)
        linearLayout.addSubview(getToolbar(title: "FORGOT PASSWORD", isBackMenu: true))
        linearLayout.addSubview(or)
        linearLayout.addSubview(countryCode!)
        linearLayout.addSubview(numberLayout)
        linearLayout.addSubview(info!)
        linearLayout.addSubview(otpLayout)
        linearLayout.addSubview(newLayout)
        
        let relative = TGRelativeLayout()
        relative.tg_height.equal(UIScreen.main.bounds.height)
        relative.tg_width.equal(UIScreen.main.bounds.width)
        relative.addSubview(linearLayout)
        relative.addSubview(btn!)
        
        mainView = self.view;
        mainView!.addSubview(relative)
        mainView?.backgroundColor = Style.BackgroundColor
        menuButton.addTarget(self, action: #selector(onBackPressed), for: .touchUpInside)
    }
    
    // a picker item was selected
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage){
        if(otpSent!){
            return;
        }
        code = phoneCode
        print(phoneCode)
    }
    
    @objc
    func changePassword(){
        if(otpSent!){
            verifyOtp();
            return;
        }
        
        let mobileNo = numberField?.text;
        let count = mobileNo?.characters.count
        
        if (count! < 11) {
            self.mainView!.showSnackMessage(descriptionText: "Provide Valid Mobile Number", duration: SnackbarDuration.SHORT, type: SnackType.ERROR)
            return;
        }
        
        let dialogBox = ConstructDialog.ConstructProgressDialog(dialogTitle: "Requesting password change",
                                                                dialogMessage: "Please wait while we are requesting for your password change...")
        self.present(dialogBox, animated: true, completion: nil)
        
        let parameters : Parameters = ["country_code": code,"mobile_number": mobileNo] ;
        Alamofire.request(Endpoints.REQUEST_PASSWORD_RESET, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseJSON { response in
            print(response);
        
            let json = response.result.value as! [String : AnyObject] ;
            let success = json["success"] as! Int;
            if(success == 1){
                self.mainView?.showSnackMessage(descriptionText: "OTP sent to registered mail and mobile.", duration: SnackbarDuration.SHORT, type: SnackType.SUCCESS);
                self.countryCode?.isMotionEnabled = false ;
                self.numberField?.isEnabled = false;
                self.info?.isHidden = false;
                self.otpField?.isHidden = false;
                self.newPassField?.isHidden = false;
                self.newPassField?.visibilityIconButton?.tintColor = Style.AccentColor

                self.btn?.title = "RESET PASSWORD"
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0){
                    dialogBox.dismiss(animated: true, completion: nil) ;
                    self.otpSent! = true;
                }
            }else{
                dialogBox.dismiss(animated: true, completion: nil) ;
                self.mainView?.showSnackMessage(descriptionText: "Failed to send OTP, try again.", duration: SnackbarDuration.SHORT, type: SnackType.ERROR);
            }
         }
    }
    
    func verifyOtp(){
        let otpNo = otpField?.text;
        let count = otpNo?.characters.count
        let mobileNo = numberField?.text;

        if (count! < 1) {
            self.mainView!.showSnackMessage(descriptionText: "Provide valid OTP.", duration: SnackbarDuration.SHORT, type: SnackType.ERROR)
            return;
        }
        
        let newPass = newPassField?.text;
        let passCount = newPass?.characters.count ;
        if(passCount! < 1){
            self.mainView!.showSnackMessage(descriptionText: "Provide valid new password.", duration: SnackbarDuration.SHORT, type: SnackType.ERROR)
            return;
        }
        
        let dialogBox = ConstructDialog.ConstructProgressDialog(dialogTitle: "Resetting password",
                                                                dialogMessage: "Please wait while are resetting your password...")
        self.present(dialogBox, animated: true, completion: nil)
        
        let parameters : Parameters = ["country_code": code,"mobile_number": mobileNo, "otp_code" : otpNo, "new_password" : newPass] ;
        
        Alamofire.request(Endpoints.RESET_PASSWORD, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                
            print(response);
                let json = response.result.value as! [String : AnyObject] ;
                let success = json["success"] as! Int ;
                let msg = json["text"] as! String ;
                if(success == 1){
                    self.mainView!.showSnackMessage(descriptionText: "Password successfully changed.", duration: SnackbarDuration.SHORT, type: SnackType.SUCCESS)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0){
                        dialogBox.dismiss(animated: true, completion: nil) ;
                        self.dismiss(animated: true, completion: nil) ;
                        self.present(LoginViewController(), animated: true, completion: nil);
                    }
                }else{
                    dialogBox.dismiss(animated: true, completion: nil);
                    self.mainView!.showSnackMessage(descriptionText: msg, duration: SnackbarDuration.SHORT, type: SnackType.ERROR)
                }
        }
        
    }
    
    @objc
    func onBackPressed(){
        print("HERE")
        self.dismiss(animated: true, completion: nil)
        //let onboarding = OnBoardingViewController()
        //appToolbarController?.present(onboarding, animated: true, completion: nil)
    }
    
}
