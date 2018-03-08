//
//  SignupViewController.swift
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

class SignupViewController : BaseViewController, MRCountryPickerDelegate{
    
    var mainView : UIView?
    var fName : TextField?;
    var lName : TextField?;
    var email : TextField?;
    var numberField : TextField?;
    var passwordField : TextField?;
    var code : String?;

    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight = UIApplication.shared.statusBarFrame.height

        let gloginBtn = RaisedButton(title: "GOOGLE SIGNUP", titleColor: .white)
        gloginBtn.pulseColor = .white
        gloginBtn.backgroundColor = Style.AccentColor
        gloginBtn.tg_width.equal(UIScreen.main.bounds.width - 50)
        gloginBtn.tg_centerX.equal(0)
        gloginBtn.tg_height.equal(48)
        gloginBtn.tg_top.equal(20)
        
        let floginBtn = RaisedButton(title: "FACEBOOK SIGNUP", titleColor: .white)
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
        or.tg_top.equal(8)
        
        
        //First Name field.
        fName = TextField()
        fName?.tg_bottom.equal(12)
        fName?.tg_height.equal(.wrap)
        fName?.tg_width.equal(UIScreen.main.bounds.width - 50)
        fName?.placeholder = "First Name"
        fName?.detail = ""
        fName?.textColor = Style.TextColor
        fName?.detailLabel.isHidden = true
        fName?.detailColor = Style.TextColor
        fName?.placeholderLabel.textColor = Style.TextColor
        fName?.dividerActiveColor = Style.AccentColor
        fName?.placeholderActiveColor = Style.AccentColor
        fName?.clearButtonMode = .whileEditing
        fName?.keyboardType = UIKeyboardType.decimalPad
        fName?.isVisibilityIconButtonEnabled = false
        fName?.visibilityIconButton?.tintColor = Style.AccentColor
        
        //First Name field layout
        let fNameLayout = TGLinearLayout(.vert)
        fNameLayout.tg_width.equal(self.view.frame.width - 50)
        fNameLayout.tg_height.equal(.wrap)
        fNameLayout.addSubview(fName!)
        fNameLayout.tg_top.equal(10)
        fNameLayout.tg_centerX.equal(0)
        
        //Last Name field.
        lName = TextField()
        lName?.tg_bottom.equal(12)
        lName?.tg_height.equal(.wrap)
        lName?.tg_width.equal(UIScreen.main.bounds.width - 50)
        lName?.placeholder = "Last Name"
        lName?.detail = ""
        lName?.textColor = Style.TextColor
        lName?.detailLabel.isHidden = true
        lName?.detailColor = Style.TextColor
        lName?.placeholderLabel.textColor = Style.TextColor
        lName?.dividerActiveColor = Style.AccentColor
        lName?.placeholderActiveColor = Style.AccentColor
        lName?.clearButtonMode = .whileEditing
        lName?.keyboardType = UIKeyboardType.decimalPad
        lName?.isVisibilityIconButtonEnabled = false
        lName?.visibilityIconButton?.tintColor = Style.AccentColor
        
        //Last Name field layout
        let lNameLayout = TGLinearLayout(.vert)
        lNameLayout.tg_width.equal(self.view.frame.width - 50)
        lNameLayout.tg_height.equal(.wrap)
        lNameLayout.addSubview(lName!)
        lNameLayout.tg_top.equal(12)
        lNameLayout.tg_centerX.equal(0)
        
        //Email field.
        email = TextField()
        email?.tg_bottom.equal(12)
        email?.tg_height.equal(.wrap)
        email?.tg_width.equal(UIScreen.main.bounds.width - 50)
        email?.placeholder = "Email"
        email?.detail = ""
        email?.textColor = Style.TextColor
        email?.detailLabel.isHidden = true
        email?.detailColor = Style.TextColor
        email?.placeholderLabel.textColor = Style.TextColor
        email?.dividerActiveColor = Style.AccentColor
        email?.placeholderActiveColor = Style.AccentColor
        email?.clearButtonMode = .whileEditing
        email?.keyboardType = UIKeyboardType.decimalPad
        email?.isVisibilityIconButtonEnabled = false
        email?.visibilityIconButton?.tintColor = Style.AccentColor
        
        //Email field layout
        let emailLayout = TGLinearLayout(.vert)
        emailLayout.tg_width.equal(self.view.frame.width - 50)
        emailLayout.tg_height.equal(.wrap)
        emailLayout.addSubview(email!)
        emailLayout.tg_top.equal(12)
        emailLayout.tg_centerX.equal(0)
        
        
        
        //Country code picker...
        let countryCode = MRCountryPicker()
        countryCode.tg_height.equal(100)
        countryCode.tg_width.equal(self.view.frame.width - 50)
        countryCode.setCountryByName("India")
        countryCode.tg_centerX.equal(0)
        code = "+91"
        
        //Number field.
        numberField = TextField()
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
        numberLayout.tg_top.equal(10)
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
        let singupBtn = RaisedButton(title: "SIGNUP", titleColor: .white)
        singupBtn.pulseColor = .white
        singupBtn.backgroundColor = Style.AccentColor
        singupBtn.tg_width.equal(UIScreen.main.bounds.width - 50)
        singupBtn.tg_centerX.equal(0)
        singupBtn.tg_height.equal(48)
        singupBtn.tg_top.equal(40)
        
        
        let join: UILabel = UILabel()
        join.text = "By joining you agree to our"
        join.textColor = Style.TextColor
        join.sizeToFit()
        join.tg_centerX.equal(0)
        join.tg_top.equal(8)
        
        let tnc: UILabel = UILabel()
        tnc.text = "Terms & Privacy"
        tnc.textColor = Style.AccentColor
        tnc.sizeToFit()
        tnc.tg_centerX.equal(0)
        tnc.tg_top.equal(4)
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scrollView.contentSize = self.view.frame.size
        scrollView.tg_centerY.equal(0)
        scrollView.tg_centerX.equal(0)
        
        let linearLayout = TGLinearLayout(.vert)
        linearLayout.tg_width.equal(self.view.frame.width)
        linearLayout.tg_height.equal(self.view.frame.height)
        linearLayout.tg_top.equal(statusBarHeight)
        linearLayout.addSubview(getToolbar(title: "SIGNUP", isBackMenu: true))
        linearLayout.addSubview(gloginBtn)
        linearLayout.addSubview(floginBtn)
        linearLayout.addSubview(or)
        linearLayout.addSubview(fNameLayout)
        linearLayout.addSubview(lNameLayout)
        linearLayout.addSubview(emailLayout)
        linearLayout.addSubview(countryCode)
        linearLayout.addSubview(numberLayout)
        linearLayout.addSubview(passLayout)
        linearLayout.addSubview(singupBtn)
        linearLayout.addSubview(join)
        linearLayout.addSubview(tnc)
        //linearLayout.tg_top.equal(10)
        
        mainView = self.view
        self.view.backgroundColor = Style.BackgroundColor
        mainView!.addSubview(linearLayout)
        //scrollView.addSubview(linearLayout)
        menuButton.addTarget(self, action: #selector(onBackPressed), for: .touchUpInside)
        
        singupBtn.addTarget(self, action: #selector(signup), for: .touchUpInside)
        
    }
    
    @objc
    func signup(){
        let numberCount = numberField?.text?.characters.count;
        let passCount = passwordField?.text?.characters.count;
        let emailCount = email?.text?.characters.count;
        let fNameCount = fName?.text?.characters.count;
        let lNameCount = lName?.text?.characters.count;
        
        if(fNameCount! < 1){
            mainView!.showSnackMessage(descriptionText: "Provide valid first name.", duration: SnackbarDuration.SHORT, type: SnackType.ERROR);
            return;
        }
        
        if(lNameCount! < 1){
            mainView!.showSnackMessage(descriptionText: "Provide valid last name.", duration: SnackbarDuration.SHORT, type: SnackType.ERROR);
            return;
        }
        
        if(emailCount! < 1){
            mainView!.showSnackMessage(descriptionText: "Provide valid email id.", duration: SnackbarDuration.SHORT, type: SnackType.ERROR);
            return;
        }
        
        if(numberCount! < 10){
            mainView!.showSnackMessage(descriptionText: "Provide valid mobile number.", duration: SnackbarDuration.SHORT, type: SnackType.ERROR);
            return;
        }
        
        if(passCount! < 6){
            mainView!.showSnackMessage(descriptionText: "assword must be 6 character long", duration: SnackbarDuration.SHORT, type: SnackType.ERROR);
            return;
        }
        
        let parameters: Parameters = ["country_code": code, "mobile_number": numberField?.text, "password": passwordField?.text,
                                      "fname" : fName?.text, "lname": lName?.text, "email": email?.text] ;
        
        let dialogBox = ConstructDialog.ConstructProgressDialog(dialogTitle: "User Signup", dialogMessage: "Please wait while we are signing you up...")
        self.present(dialogBox, animated: true, completion: nil) ;
        let url = Endpoints.SIGNUP_URL ;
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
                    //Failed to signup...
                    dialogBox.dismiss(animated: true, completion: nil)
                    let errorMessage = responseJSON["text"] as! String;
                    self.mainView!.showSnackMessage(descriptionText: errorMessage, duration: SnackbarDuration.SHORT, type: SnackType.ERROR)
                    return;
                } else if(success == 1){
                    self.mainView!.showSnackMessage(descriptionText: "Successfully signed up.", duration: SnackbarDuration.SHORT, type: SnackType.SUCCESS)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0){
                        let decoder = JSONDecoder()
                        let signup = try! decoder.decode(Signup.self, from: response.data!)
                        let otpViewController = OtpViewController();
                        otpViewController.signup = signup;
                        otpViewController.login = nil;
                        otpViewController.isLogin = false;
                        dialogBox.dismiss(animated: true, completion: nil)
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
    func onBackPressed(){
        print("HERE")
        self.dismiss(animated: true, completion: nil)
    }
    
    // a picker item was selected
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage){
        code = phoneCode;
    }
    
    
}



