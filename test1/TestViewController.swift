//
//  TestViewController.swift
//  test1
//
//  Created by fypjadmin on 6/5/15.
//  Copyright (c) 2015 nyp. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    var dataArray: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     self.retrieve()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrieve(){
        var ref = Firebase(url: "https://fypjquest2015.firebaseio.com/activities")
        ref.observeEventType(.Value, withBlock: {
            snapshot in
            if let i = snapshot.value as? NSDictionary {
                for item in i{
                    if let value = item.value as? NSDictionary {
                        var e = Event()
                        e.title = value["name"] as! String
                        e.date = value["datetime"] as! String
                        e.code = value["code"] as! String
                        self.dataArray.append(e)
                        println(self.dataArray.count)
                        
                    }
                }
            }
        })

    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "push"){
        let evc = segue.destinationViewController as! TestTableViewController
            if(self.dataArray.count == 0){
                println("nothing")
            } else {
                evc.events = self.dataArray
            }
      }
    }


}
