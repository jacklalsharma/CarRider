//
//  TripHistoryVC.swift
//  CabRider
//
//  Created by Anurag on 09/03/18.
//  Copyright © 2018 DrawnzerGames. All rights reserved.
//

import UIKit
import TangramKit
import Alamofire
import Realm
import RealmSwift

class TripHistoryVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dialogBox : DialogBox? ;

    var mainView : UIView? ;
    var accessToken : String? ;
    var user : CabUser? ;

    private let myArray: NSArray = ["First","Second","Third"]
    private var myTableView: UITableView!
    var rideHistory : RideHistory! ;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let realm = try! Realm() ;
        user = realm.objects(CabUser.self).first ;
        accessToken = user?.accessToken
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let linearLayout = TGLinearLayout(.vert)
        linearLayout.tg_width.equal(self.view.frame.width)
        linearLayout.tg_height.equal(self.view.frame.height)
        linearLayout.tg_top.equal(statusBarHeight)
        linearLayout.addSubview(getToolbar(title: "RIDE HISTORY", isBackMenu: true))
        
        mainView = self.view
        self.view.backgroundColor = Style.BackgroundColor
        
        myTableView = UITableView()
        myTableView.tg_width.equal(self.view.frame.width)
        myTableView.tg_height.equal(self.view.frame.height)
        myTableView.register(RideHistoryTableCell.self, forCellReuseIdentifier: "cell")
        myTableView.dataSource = self
        myTableView.delegate = self
        linearLayout.addSubview(myTableView)
        
        mainView!.addSubview(linearLayout)
        menuButton.addTarget(self, action: #selector(onBackPressed), for: .touchUpInside)
        dialogBox = ConstructDialog.ConstructProgressDialog(dialogTitle: "Getting Ride History", dialogMessage: "Please wait while we are fetching your ride history...");
        self.present(dialogBox!, animated: true, completion: nil);
        getRideHistory()
    }
    
    @objc
    func onBackPressed(){
        dismiss(animated: true, completion: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getRideHistory(){
        let url = Endpoints.RIDE_HISTORY;
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Helper.getAuthHeader(token: accessToken!)).responseJSON{response in
            //print(response)
            self.dialogBox?.dismiss(animated: true, completion: nil)
            if(response.result.value == nil){
                self.view.showSnackMessage(descriptionText: "Faield to fetch ride history, try again later.", duration: SnackbarDuration.SHORT, type: SnackType.ERROR)
                return;
            }
            
            let responseJSON = response.result.value as! [String:AnyObject]
            let success = responseJSON["success"] as! Int
            
            if( success == 0){
                self.view.showSnackMessage(descriptionText: "Faield to fetch ride history, try again later.", duration: SnackbarDuration.SHORT, type: SnackType.ERROR)
            }else if(success == 1){
                let decoder = JSONDecoder()
                self.rideHistory = try! decoder.decode(RideHistory.self, from: response.data!)
                self.myTableView.reloadData();
            }
        }
    }
    
    func prepareRideList(rideHistory : RideHistory){
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Num: \(indexPath.row)")
        //print("Value: \(myArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(rideHistory == nil){
            return 0;
        }
        return rideHistory.data.rideRequests.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RideHistoryTableCell
        if(rideHistory != nil){
            cell.labUerName.text = rideHistory.data.rideRequests[indexPath.row].sourceAddress
        }else{
            cell.labUerName.text = "\(myArray[indexPath.row])"
        }
        return cell
    }
    
    

}
