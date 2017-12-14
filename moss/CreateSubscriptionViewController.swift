//
//  CreateSubscriptionViewController.swift
//  moss
//
//  Created by Yufeng Guo on 11/12/2017.
//  Copyright © 2017 Yufeng Guo. All rights reserved.
//

import UIKit
import os.log
import CoreData

class CreateSubscriptionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var subscriptionIconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func selectSubscriptionIcon(_ sender: UITapGestureRecognizer) {
        os_log("select image")
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //
        os_log("cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //
        os_log("picked")
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        subscriptionIconImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Subscription", in: context)!
        let subscription = Subscription(entity: entity, insertInto: context)
        subscription.setValue("Evernote", forKey: "name")
        do {
            try context.save()
        } catch  {
            fatalError("error saving context")
        }
    }


}
