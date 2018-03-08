//  SGSnackBar
//
//  Created by Shubhank Gupta on 01/17/2016.

//    Copyright (c) 2016 Shubhank Gupta <shubhankscores@gmail.com>
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in
//    all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//    THE SOFTWARE.
import Foundation
import UIKit
import Material

public enum SnackbarDuration : Int {
    case SHORT = 3
    case LONG = 6
}

public enum SnackType : Int {
    case SUCCESS = 1
    case ERROR = 2
    case WARNING = 3
    case INFO = 4
}

private func delay(delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay){
        closure()
    }
}

//category to show snackbar simply on the view
public extension UIView {
    
    func showSnackMessage(descriptionText: String, duration:SnackbarDuration, type : SnackType) {
        SGSnackBarView.showSnackMessage(descriptionText: descriptionText, duration: duration, superView: self, type : type)
    }
}

public class SGSnackBarView: UIView {
    
    // appearance properties
    @objc public dynamic var snackBarBgColor: UIColor?
    @objc public dynamic var descLabelTextColor: UIColor?
    @objc public dynamic var actionButtonBackgroundColor: UIColor?
    @objc public dynamic var actionButtonTextColor: UIColor?
    
    private var actionButton:UIButton!
    private var descriptionLabel:UILabel!
    var snackIcon: IconButton!
    
    var bottomConstraint:NSLayoutConstraint!
    var buttonClickedClosure:(()->())?
    var actionButtonText:String?
    var descriptionText:String!
    
    // helper method to initialize and show Snackbar
    public class func showSnackMessage(descriptionText: String, duration:SnackbarDuration,  superView:UIView!, type: SnackType) {
        
        let snackBar = SGSnackBarView()
        snackBar.descriptionText = descriptionText
        
        snackBar.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(snackBar)
        
        snackBar.bottomConstraint = NSLayoutConstraint(item: snackBar, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1.0, constant: 90)
        superView.addConstraint(snackBar.bottomConstraint)
        superView.addConstraint(NSLayoutConstraint(item: snackBar, attribute: .left, relatedBy: .equal, toItem: superView, attribute: .left, multiplier: 1.0, constant: 0))
        superView.addConstraint(NSLayoutConstraint(item: snackBar, attribute: .right, relatedBy: .equal, toItem: superView, attribute: .right, multiplier: 1.0, constant: 0))
        superView.addConstraint(NSLayoutConstraint(item: snackBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60))
        
        snackBar.addDescriptionLabel()
        //snackBar.addActionButton()
        
        snackBar.setupDefaultUI(type: type)
        snackBar.setupAppearanceDefaults()
        snackBar.animateIn()
        snackBar.automaticDismissSetup(duration: duration)
    }
    
    func addDescriptionLabel() {
        descriptionLabel = UILabel()
        let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15)]
        let attributedString = NSMutableAttributedString(string: descriptionText, attributes:attrs)
        descriptionLabel.backgroundColor = UIColor.clear
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.attributedText = attributedString
        descriptionLabel.numberOfLines = 2
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descriptionLabel)
        
        self.addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 14))
        self.addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -100))
    }
    
    func addActionButton() {
        actionButton = UIButton(type: UIButtonType.custom)
        actionButton.showsTouchWhenHighlighted = true
        actionButton.setTitleColor( UIColor.white, for: UIControlState.normal)
        actionButton.isHidden = true
        if self.actionButtonText != nil {
            actionButton.isHidden = false
            actionButton.setTitle(actionButtonText?.uppercased(), for: UIControlState.normal)
            actionButton.addTarget(self, action: #selector(SGSnackBarView.doneTapped), for: UIControlEvents.touchUpInside)
        }
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(actionButton)
        
        self.addConstraint(NSLayoutConstraint(item: actionButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 15))
        self.addConstraint(NSLayoutConstraint(item: actionButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -15))
        self.addConstraint(NSLayoutConstraint(item: actionButton, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -10))
        self.addConstraint(NSLayoutConstraint(item: actionButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: (self.superview?.frame.size.width)! * 0.22))
    }
    
    func setupDefaultUI(type : SnackType) {
        self.descriptionLabel.textColor = UIColor.white
        //self.actionButton.backgroundColor = UIColor.red
        if type.rawValue == 1{
            self.backgroundColor = Style.SuccessColor
        } else if (type.rawValue == 2){
            self.backgroundColor = Style.ErrorColor
        } else if(type.rawValue == 3){
            self.backgroundColor = Style.WarningColor
        } else if(type.rawValue == 4){
            self.backgroundColor = Style.InfoColor
        }
    }
    
    func setupAppearanceDefaults() {
        if self.snackBarBgColor != nil {
            self.backgroundColor = self.snackBarBgColor
        }
        
        if self.descLabelTextColor != nil {
            self.descriptionLabel.textColor = descLabelTextColor
        }
        
        if self.actionButtonBackgroundColor != nil {
            self.actionButton.backgroundColor = actionButtonBackgroundColor
        }
        
        if self.actionButtonTextColor != nil {
            self.actionButton.setTitleColor( self.actionButtonTextColor, for: UIControlState.normal)
        }
    }
    
    func animateIn() {
        self.layoutIfNeeded()
        
        self.bottomConstraint.constant = 0
        UIView.animate(withDuration: 1.2, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.curveEaseOut,  animations: { () -> Void in
            self.layoutIfNeeded()
        },
                                   completion: { (completed) -> Void in
        }
        )
    }
    
    func automaticDismissSetup(duration: SnackbarDuration) {
        delay(delay: Double(duration.rawValue)) { () -> () in
            self.animateOutsideScreen()
        }
        
    }
    
    func animateOutsideScreen() {
        self.bottomConstraint.constant = 90
        UIView.animate(withDuration: 1.2, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            self.layoutIfNeeded()
        }, completion: { (completed) -> Void in
            self.removeFromSuperview()
        }
        )
    }
    
    @objc
    func doneTapped() {
        self.animateOutsideScreen()
        
        if self.buttonClickedClosure != nil {
            self.buttonClickedClosure!()
        }
    }
}
