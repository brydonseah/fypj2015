
//  LoginViewController.swift
//  test1
//
//  Created by fypjadmin on 6/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var myArray: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
//        dispatch_sync(dispatch_get_global_queue(
//            Int(QOS_CLASS_USER_INTERACTIVE.value), 0)) {
//                var ref = Firebase(url: "https://fypjquest2015.firebaseio.com/activities")
//                ref.queryOrderedByKey().observeEventType(.Value, withBlock: {
//                    snapshot in
//                    if let i = snapshot.value as? NSDictionary {
//                        for item in i{
//                            if let value = item.value as? NSDictionary {
//                                var e = Event()
//                                e.uniqueKey = item.key as! String
//                                e.title = value["name"] as! String
//                                e.date = value["datetime"] as! String
//                                e.code = value["code"] as! String
//                                println("done")
//                                self.myArray.append(e)
//
//                            }
//                        }
//                    }
//                })
        
//                ref.queryOrderedByKey().observeEventType(.ChildAdded, withBlock: { snapshot in
//                    
//                    let name = snapshot.value["name"] as! String
//                    let datetime = snapshot.value["datetime"] as! String
//                    let code = snapshot.value["code"] as! String
//                    let key = snapshot.key as String
//                    
//                    var e = Event()
//                    e.uniqueKey = key
//                    e.title = name
//                    e.date = datetime
//                    e.code = code
//                    println("LoginView")
//                    self.myArray.append(e)
//                })
//
        
//    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "Teacher") {
            // initialize new view controller and cast it as your view controller
            let tab: UITabBarController = segue.destinationViewController as! UITabBarController
            let nav: UINavigationController = tab.viewControllers?.first as! UINavigationController
            let evc: EventsViewController = nav.viewControllers?.first as! EventsViewController
            
            if(self.myArray.count == 0){
            println("NO data")
            // your new view controller should have property that will store passed value
            } else {
                evc.dataArray = self.myArray
            }
        }
    }


}
