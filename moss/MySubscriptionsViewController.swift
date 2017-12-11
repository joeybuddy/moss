//
//  ViewController.swift
//  moss
//
//  Created by Yufeng Guo on 07/12/2017.
//  Copyright © 2017 Yufeng Guo. All rights reserved.
//

import UIKit

class MySubscriptionsViewController: UIViewController {
    
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var gridSubscriptions: UITableView!
    
    @IBAction func _onCreateClick(_ sender: UIButton) {
            if sender == btnCreate{
                txtTitle.text = "how are you"
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "CreateSubscriptionViewController")
                self.present(newViewController, animated: true, completion: nil)
//                let CreateSubscription = self.storyboard?.instantiateViewController(withIdentifier: "CreateSubscription") as! CreateSubscription
//                self.navigationController?.pushViewController(CreateSubscription, animated: true)
            }
    }
    
    func initializeMySubscriptions() {
        let subscriptions: [(String,Decimal)] = [
            ("Evernote", 168),
            ("Netease Music", 10)
        ]
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

