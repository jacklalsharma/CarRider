//
//  LoginViewController.swift
//  CabRider
//
//  Created by Anurag on 20/02/18.
//  Copyright © 2018 Anurag. All rights reserved.
//

import Foundation
import UIKit
import Material
import TangramKit
import MRCountryPicker
import Alamofire

class LoginViewController : BaseViewController, MRCountryPickerDelegate{

    var numberField : TextField?
    var passwordField : TextField?
    var code : String?;
    var mainView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight = UIApplication.shared.statusBarFrame.height

        //Google login button
        let gloginBtn = RaisedButton(title: "GOOGLE LOGIN", titleColor: .white)
        gloginBtn.pulseColor = .white
        gloginBtn.backgroundColor = Style.AccentColor
        gloginBtn.tg_width.equal(UIScreen.main.bounds.width - 50)
        gloginBtn.tg_centerX.equal(0)
        gloginBtn.tg_height.equal(48)
        gloginBtn.tg_top.equal(20)
        
        //Facebook login button
        let floginBtn = RaisedButton(title: "FACEBOOK LOGIN", titleColor: .white)
        floginBtn.pulseColor = .white
        floginBtn.backgroundColor = Color.blue.darken1
        floginBtn.tg_width.equal(UIScreen.main.bounds.width - 50)
        floginBtn.tg_centerX.equal(0)
        floginBtn.tg_centerY.equal(0)
        floginBtn.tg_height.equal(48)
        floginBtn.tg_top.equal(20)
        
        
        //Or Label...
        let or: UILabel = UILabel()
        or.text = "OR"
        or.textColor = Style.TextColor
        or.sizeToFit()
        or.tg_centerX.equal(0)
        or.tg_top.equal(12)
        
        
        //Country code picker...
        code = "+91"
        let countryCode = MRCountryPicker()
        countryCode.tg_height.equal(150)
        countryCode.tg_width.equal(self.view.frame.width - 50)
        countryCode.setCountryByName("India")
        countryCode.tg_centerX.equal(0)
        countryCode.countryPickerDelegate = self
        
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
        
        
        //Password field.
        passwordField = TextField()
        passwordField?.tg_top.equal(12)
        passwordField?.tg_height.equal(.wrap)
        passwordField?.tg_width.equal(UIScreen.main.bounds.width - 50)
        passwordField?.placeholder = "Password"
        passwordField?.detail = "At least 6 characters"
        passwordField?.detailColor = Style.TextColor
        passwordField?.textColor = Style.TextColor
        passwordField?.placeholderLabel.textColor = Style.TextColor
        passwordField?.dividerActiveColor = Style.AccentColor
        passwordField?.placeholderActiveColor = Style.AccentColor
        passwordField?.clearButtonMode = .whileEditing
        passwordField?.isVisibilityIconButtonEnabled = true
        passwordField?.visibilityIconButton?.tintColor = Style.AccentColor
        
        
        //Password field layout
        let passLayout = TGLinearLayout(.vert)
        passLayout.tg_width.equal(self.view.frame.width - 50)
        passLayout.tg_height.equal(.wrap)
        passLayout.addSubview(passwordField!)
        passLayout.tg_centerX.equal(0)
        
        
        //Login button
        let loginBtn = RaisedButton(title: "LOGIN", titleColor: .white)
        loginBtn.pulseColor = .white
        loginBtn.backgroundColor = Style.AccentColor
        loginBtn.tg_width.equal(UIScreen.main.bounds.width - 50)
        loginBtn.tg_centerX.equal(0)
        loginBtn.tg_height.equal(48)
        loginBtn.tg_top.equal(40)
        
        //Forgot Passworf Label...
        let forgot: FlatButton = FlatButton(title: "Forgot Password?", titleColor: Style.TextColor)
        forgot.sizeToFit()
        forgot.tg_centerX.equal(0)
        forgot.tg_top.equal(12)
        forgot.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scrollView.contentSize = self.view.frame.size
        scrollView.tg_centerY.equal(0)
        scrollView.tg_centerX.equal(0)
        
        let linearLayout = TGLinearLayout(.vert)
        linearLayout.tg_width.equal(self.view.frame.width)
        linearLayout.tg_height.equal(self.view.frame.height)
        linearLayout.addSubview(getToolbar(title: "LOGIN", isBackMenu: true))
        linearLayout.addSubview(gloginBtn)
        linearLayout.addSubview(floginBtn)
        linearLayout.addSubview(or)
        linearLayout.addSubview(countryCode)
        linearLayout.addSubview(numberLayout)
        linearLayout.addSubview(passLayout)
        linearLayout.addSubview(loginBtn)
        linearLayout.addSubview(forgot)
        linearLayout.tg_top.equal(statusBarHeight)
        
        self.view.backgroundColor = Style.BackgroundColor
        self.view.addSubview(linearLayout)
        //scrollView.addSubview(linearLayout)
        mainView = self.view;
        //mainView!.addSubview(linearLayout)
        
        //Click listeners
        loginBtn.addTarget(self, action: #selector(self.login), for: .touchUpInside)
        gloginBtn.addTarget(self, action: #selector(self.gLogin), for: .touchUpInside)
        floginBtn.addTarget(self, action: #selector(self.fLogin), for: .touchUpInside)
        menuButton.addTarget(self, action: #selector(self.onBackPressed), for: .touchUpInside)
    }
    
    override func loadView() {
        super.loadView()
        
    }
    
    @objc
    func onBackPressed(){
        dismiss(animated: true, completion: nil)
    }
    
    // a picker item was selected
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage){
        code = phoneCode
        print(phoneCode)
    }
    
    @objc
    func login(){
        let mobileNo = numberField?.text;
        let password = passwordField?.text;
        let count = mobileNo?.characters.count
        let passCount = passwordField?.text?.characters.count
        
        if (count! < 10) {
            self.mainView!.showSnackMessage(descriptionText: "Provide Valid Mobile Number", duration: SnackbarDuration.SHORT, type: SnackType.ERROR)
            return;
        }
        
        if (passCount! < 6){
            self.mainView!.showSnackMessage(descriptionText: "Password must be 6 character long", duration: SnackbarDuration.SHORT, type: SnackType.ERROR)
            return
        }
        
        //Login using number and password...
        let url = Endpoints.LOGIN_URL
        
        let parameters: Parameters = ["country_code": code, "mobile_number": mobileNo, "password": password]
        let dialogBox = ConstructDialog.ConstructProgressDialog(dialogTitle: "User Login", dialogMessage: "Please wait while we are loggin you in...")
        self.present(dialogBox, animated: true, completion: nil)
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
    
                print(response)
                let responseJSON = response.result.value as! [String:AnyObject]
                let success = responseJSON["success"] as! Int
                
                if( success == 0){
                    //Failed to login...
                    dialogBox.dismiss(animated: true, completion: nil)
                    let errorMessage = responseJSON["text"] as! String;
                    self.mainView!.showSnackMessage(descriptionText: errorMessage, duration: SnackbarDuration.SHORT, type: SnackType.ERROR)
                    return;
                } else if(success == 1){
                    self.mainView!.showSnackMessage(descriptionText: "Successfully logged in.", duration: SnackbarDuration.SHORT, type: SnackType.SUCCESS)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0){
                        let decoder = JSONDecoder()
                        let login = try! decoder.decode(Login.self, from: response.data!)
                        let otpViewController = OtpViewController();
                        otpViewController.login = login;
                        otpViewController.isLogin = true;
                        dialogBox.dismiss(animated: false, completion: nil)
                        self.present(otpViewController, animated: true, completion: nil)
                    }
                }else{
                    let msg = responseJSON["text"] as! String ;
                    self.mainView!.showSnackMessage(descriptionText: msg, duration: SnackbarDuration.SHORT, type: SnackType.ERROR)
                    dialogBox.dismiss(animated: true, completion: nil)
                }
            
            }
    }
    
    @objc
    func gLogin(){
        
    }
    
    @objc
    func fLogin(){
        
    }
    
    @objc
    func forgotPassword(){
        var forgotVC = ForgotPasswordViewController();
        self.present(forgotVC, animated: true, completion: nil);
    }
    
}



