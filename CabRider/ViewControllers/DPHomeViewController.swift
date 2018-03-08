//
//  DPHomeViewController.swift
//  CabRider
//
//  Created by Anurag on 08/03/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import Foundation

class DPHomeViewController: DPCenterContentViewController {
    
    override init(nibName nibNameOrNil: String?,
                  bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
    }
    
    required internal init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Style.AccentColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
