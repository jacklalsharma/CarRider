//
//  OnBoardingViewController.swift
//  CabRider
//
//  Created by Anurag on 16/02/18.
//  Copyright © 2018 Anurag. All rights reserved.
//

import Foundation
import UIKit
import Material
import NVActivityIndicatorView
import TangramKit
import FSPagerView

class OnBoardingViewController : UIViewController, NVActivityIndicatorViewable, FSPagerViewDataSource,FSPagerViewDelegate{
    
    fileprivate let imageNames = ["ic_logo_img.png","ic_logo_img.png","ic_logo_img.png","ic_logo_img.png","ic_logo_img.png","ic_logo_img.png"]
    
    fileprivate var numberOfItems = 3
    struct Raised {
        static let width: CGFloat = 150
        static let height: CGFloat = 44
        static let offsetY: CGFloat = -75
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "rider_splash.png")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        //self.view.insertSubview(backgroundImage, at: 0)
        
        
        //Mask Color
        let maskColor = UIImageView(frame: UIScreen.main.bounds)
        maskColor.contentMode = UIViewContentMode.scaleAspectFill
        maskColor.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        
        let accentColor = UIColor(red: CGFloat(237 / 255.0), green: CGFloat(85 / 255.0), blue: CGFloat(101 / 255.0), alpha: 1)
        
        //Status bar color change
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = accentColor
        }
        UIApplication.shared.statusBarStyle = .lightContent
        
        let relativeLayout = TGRelativeLayout()
        relativeLayout.tg_backgroundImage = backgroundImage.image
        self.view = relativeLayout
        
        //App Name Label...
        let name: UILabel = UILabel()
        let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 35)]
        let attributedString = NSMutableAttributedString(string: "High Way Trip Rider", attributes:attrs)
        name.attributedText = attributedString
        name.textColor = accentColor
        name.sizeToFit()
        name.tg_centerX.equal(0)
        name.tg_top.equal(50)
        
        
        
        //Button
        let loginBtn = RaisedButton(title: "LOGIN", titleColor: .white)
        loginBtn.pulseColor = Color.grey.base
        loginBtn.backgroundColor = Color.white
        loginBtn.setTitleColor(accentColor, for: .normal)
        loginBtn.setTitleColor(accentColor, for: UIControlState.highlighted)
        loginBtn.tg_width.equal(UIScreen.main.bounds.width - 50)
        loginBtn.tg_centerX.equal(0)
        loginBtn.tg_height.equal(48)
        loginBtn.tg_top.equal(UIScreen.main.bounds.height - 60)
        
        //Button
        let signupBtn = RaisedButton(title: "SIGNUP", titleColor: .white)
        signupBtn.pulseColor = .white
        signupBtn.backgroundColor = accentColor
        signupBtn.tg_width.equal(UIScreen.main.bounds.width - 50)
        signupBtn.tg_centerX.equal(0)
        signupBtn.tg_height.equal(48)
        signupBtn.tg_top.equal(20)
        signupBtn.tg_top.equal(UIScreen.main.bounds.height - 120)
        
        //View Pager
        let pagerFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20,height: UIScreen.main.bounds.height - 300)
        let viewPager = FSPagerView(frame: pagerFrame);
        viewPager.dataSource = self
        viewPager.delegate = self
        viewPager.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        viewPager.tg_centerX.equal(0)
        viewPager.tg_centerY.equal(0)
        
        relativeLayout.addSubview(maskColor)
        relativeLayout.addSubview(name)
        relativeLayout.addSubview(signupBtn)
        relativeLayout.addSubview(loginBtn)
        relativeLayout.addSubview(viewPager)
        
        loginBtn.addTarget(self, action: #selector(self.launchLoginScreen), for: .touchUpInside)
        signupBtn.addTarget(self, action: #selector(self.launchRegistrationScreen), for: .touchUpInside)
        
    }
    
    @objc func launchLoginScreen(){
        let loginScreen = LoginViewController();
        //self.dismiss(animated: true, completion: nil)
        self.present(loginScreen, animated: true, completion: nil)
    }
    
    @objc func launchRegistrationScreen(){
        let signupScreen = SignupViewController();
        //self.dismiss(animated: true, completion: nil)
        self.present(signupScreen, animated: true, completion: nil)
    }
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return numberOfItems
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.frame.size.width = 120;
        cell.imageView?.frame.size.height = 120;
        cell.imageView?.image = cell.imageView?.image!.withRenderingMode(.alwaysTemplate)
        cell.imageView?.tintColor = Color.grey.base
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = ""
        cell.imageView?.tg_centerX.equal(0)
        cell.imageView?.tg_centerY.equal(0)
        return cell
    }
    
    // MARK:- FSPagerView Delegate
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        //        pagerView.deselectItem(at: index, animated: true)
        //        pagerView.scrollToItem(at: index, animated: true)
        //        self.pageControl.currentPage = index
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        //        guard self.pageControl.currentPage != pagerView.currentIndex else {
        //            return
        //        }
        //        self.pageControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
        //
    }
    
}


