//
//  ViewController.swift
//  moss
//
//  Created by Yufeng Guo on 07/12/2017.
//  Copyright © 2017 Yufeng Guo. All rights reserved.
//

import UIKit
import CoreData
import os.log

class MySubscriptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var subscriptions = [Subscription]()
    
    @IBOutlet weak var subscriptionsTableView: UITableView!
    @IBOutlet weak var btnCreate: UIButton!
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscription")
        do {
            let fetchedResults = try context.fetch(fetchRequest) as? [Subscription]
            if let result = fetchedResults {
                subscriptions = result
                gridSubscriptions.reloadData()
            }
        } catch {
            fatalError("erroring fetching subscriptions")
        }
    }
    
    
    // MARK private methods
    func initializeMySubscriptions() {
//        let subscriptions: [(String,Decimal)] = [
//            ("Evernote", 168),
//            ("Netease Music", 10)
//        ]
        
        gridSubscriptions.delegate = self
        gridSubscriptions.dataSource = self
        gridSubscriptions.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK: table view delegate methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subscriptionsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = subscriptions[indexPath.row].name
        return cell
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

