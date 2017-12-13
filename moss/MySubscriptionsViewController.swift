//
//  ViewController.swift
//  moss
//
//  Created by Yufeng Guo on 07/12/2017.
//  Copyright © 2017 Yufeng Guo. All rights reserved.
//

import UIKit
import os.log

class MySubscriptionsViewController: UIViewController {
    
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var gridSubscriptions: UITableView!
    
//    @IBAction func _onCreateClick(_ sender: UIButton) {
//        if sender == btnCreate{
//            let CreateSubscriptionViewController = self.storyboard!.instantiateViewController(withIdentifier: "CreateSubscriptionViewController")
////            self.present(CreateSubscriptionViewController, animated: true, completion: nil)
//            self.navigationController?.pushViewController(CreateSubscriptionViewController, animated: true)
//        }
//    }
    
    // MARK actions
    @IBAction func unwindToMySubscriptions(sender: UIStoryboardSegue){
        if let _ = sender.source as? CreateSubscriptionViewController {
            os_log("welcome back")
        }
    }
    
    
    // MARK private methods
    func initializeMySubscriptions() {
//        let subscriptions: [(String,Decimal)] = [
//            ("Evernote", 168),
//            ("Netease Music", 10)
//        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeMySubscriptions()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

