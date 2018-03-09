//
//  NavigationViewController.swift
//  CabRider
//
//  Created by Anurag on 08/03/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import UIKit
import DPSlideMenuKit
import Material

class NavigationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Style.BackgroundColor
        
        let storyboard = UIStoryboard(name: "Navigation", bundle: nil)
        let drawer: DPDrawerViewController? = storyboard.instantiateViewController(withIdentifier :"DPDrawerViewController") as! DPDrawerViewController
        self.addChildViewController(drawer!)
        self.view.addSubview(drawer!.view)
        DPSlideMenuManager.shared.setDrawer(drawer: drawer)
        //present(viewController, animated: true, completion: nil)
        
        let leftMenuViewControllerName: [String] = ["DrawerMenuViewController"]
        
        let leftMenuViewControllers = UIViewController.generateViewControllersFrom(viewControllerNameArray: leftMenuViewControllerName, storyboardName: "Navigation", bundle: nil) as! [DPBaseEmbedViewController]
        
        
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "DPHomeViewController") as! BookRideViewController
        DPSlideMenuManager.shared.setup(leftContentEmbedViewControllers: leftMenuViewControllers,
                                        rightContentEmbedViewControllers: nil,
                                        centerContentViewController: homeViewController)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
