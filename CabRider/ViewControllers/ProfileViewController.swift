//
//  ProfileViewController.swift
//  CabRider
//
//  Created by Anurag on 01/03/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import Foundation
import UIKit
import Material
import TangramKit
import MRCountryPicker
import Realm
import RealmSwift

class ProfileViewController : BaseViewController, MRCountryPickerDelegate {
    
    var dialog : DialogBox? ;
    var bookRideVC : BookRideViewController? ;
    var fName : TextField?;
    var lName : TextField?;
    var email : TextField?;
    var numberField : TextField?;
    var passwordField : TextField?;
    var code : String?;
    var user : CabUser? ;


    override
    func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight = UIApplication.shared.statusBarFrame.height

        let realm = try! Realm() ;
        user = realm.objects(CabUser.self).first ;
        
        
        let linearLayout = TGLinearLayout(.vert)
        linearLayout.tg_width.equal(view.bounds.width)
        linearLayout.tg_height.equal(view.bounds.height)
        linearLayout.tg_top.equal(statusBarHeight)
        
        
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
        fName?.text = user?.fName
        
        //First Name field layout
        let fNameLayout = TGLinearLayout(.vert)
        fNameLayout.tg_width.equal(self.view.frame.width - 50)
        fNameLayout.tg_height.equal(.wrap)
        fNameLayout.addSubview(fName!)
        fNameLayout.tg_top.equal(40)
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
        lName?.text = user?.lName
        
        //Last Name field layout
        let lNameLayout = TGLinearLayout(.vert)
        lNameLayout.tg_width.equal(self.view.frame.width - 50)
        lNameLayout.tg_height.equal(.wrap)
        lNameLayout.addSubview(lName!)
        lNameLayout.tg_top.equal(20)
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
        email?.text = user?.email
        
        //Email field layout
        let emailLayout = TGLinearLayout(.vert)
        emailLayout.tg_width.equal(self.view.frame.width - 50)
        emailLayout.tg_height.equal(.wrap)
        emailLayout.addSubview(email!)
        emailLayout.tg_top.equal(20)
        emailLayout.tg_centerX.equal(0)
        
        
        
        //Country code picker...
        let countryCode = MRCountryPicker()
        countryCode.tg_height.equal(100)
        countryCode.tg_width.equal(self.view.frame.width - 50)
        countryCode.setCountryByPhoneCode((user?.countryCode)!)
        countryCode.tg_centerX.equal(0)
        code = user?.countryCode
        
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
        numberField?.text = user?.mobileNumber;
        
        //Number field layout
        let numberLayout = TGLinearLayout(.vert)
        numberLayout.tg_width.equal(self.view.frame.width - 50)
        numberLayout.tg_height.equal(.wrap)
        numberLayout.addSubview(numberField!)
        numberLayout.tg_top.equal(20)
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
        
        
        //Update button
        let update = RaisedButton(title: "UPDATE PROFILE", titleColor: .white)
        update.pulseColor = .white
        update.backgroundColor = Style.AccentColor
        update.tg_width.equal(UIScreen.main.bounds.width - 50)
        update.tg_centerX.equal(0)
        update.tg_height.equal(48)
        update.tg_top.equal(40)
        update.addTarget(self, action: #selector(updateUser), for: .touchUpInside)
        
        linearLayout.addSubview(getToolbar(title: "UPDATE PROFILE", isBackMenu: true))
        linearLayout.addSubview(fNameLayout)
        linearLayout.addSubview(lNameLayout)
        linearLayout.addSubview(emailLayout)
        linearLayout.addSubview(countryCode)
        linearLayout.addSubview(numberLayout)
        linearLayout.addSubview(passLayout)
        linearLayout.addSubview(update)
        
        
        let logout = RaisedButton(title: "LOGOUT", titleColor: .white)
        logout.pulseColor = .white
        logout.backgroundColor = Color.grey.base
        logout.tg_width.equal(UIScreen.main.bounds.width - 50)
        logout.tg_centerX.equal(0)
        logout.tg_height.equal(48)
        logout.tg_centerY.equal((view.frame.size.height)/2 - 48 + 24)
        logout.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
        
        let relativeLayout = TGRelativeLayout()
        relativeLayout.tg_width.equal(view.bounds.width)
        relativeLayout.tg_height.equal(view.bounds.height)
        relativeLayout.addSubview(linearLayout)
        relativeLayout.addSubview(logout)
        
        view.addSubview(relativeLayout)
        view.backgroundColor = Style.BackgroundColor
        menuButton.addTarget(self, action: #selector(onBackPressed), for: .touchUpInside)

    }
    
    // a picker item was selected
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage){
        code = phoneCode;
    }
    
    override
    func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    
    @objc
    func onBackPressed(){
        self.dismiss(animated: true, completion: nil);
    }
    
    @objc
    func logoutUser(){
        dialog = ConstructDialog.ConstructTwoButtonDialog(dialogTitle : "LOGOUT", dialogMessage : "Do you really want to logout from the app ?", leftBtnText : "No", rightBtnText : "Yes")
        self.present(dialog!, animated: true, completion: nil)
        dialog?.leftButton?.addTarget(self, action: #selector(noBtnPressed), for: .touchUpInside)
        dialog?.rightButton?.addTarget(self, action: #selector(rightBtnPressed), for: .touchUpInside)
    }
    
    @objc
    func noBtnPressed(){
        dialog?.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func rightBtnPressed(){
        
        dialog?.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func updateUser(){
        
    }
}
