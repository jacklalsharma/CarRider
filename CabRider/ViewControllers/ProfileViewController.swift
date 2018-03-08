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

class ProfileViewController : UIViewController {
    
    var bookRideVC : BookRideViewController? ;

    override
    func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override
    func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    
    @objc
    func onBackPressed(){
        print("HERE")
        //let onboarding = BookRideViewController()
        //appToolbarController?.present(bookRideVC!, animated: true, completion: nil)
        //self.dismiss(animated: true, completion: nil);
        //bookRideVC?.navigationController!.popViewController( animated: true)
    }
}
