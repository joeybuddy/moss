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
import Eureka

class CreateSubscriptionViewController: FormViewController {

    var viewModel: ViewModel!
    var context: NSManagedObjectContext!
    var saveButton: UIBarButtonItem!
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy, h:mm a"
        return formatter
    }()
    
    convenience init(viewModel: ViewModel) {
        self.init()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
        self.viewModel = viewModel
        initialize()
    }
    
    private func initialize() {
        let deleteButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: .deleteButtonPressed)
        navigationItem.leftBarButtonItem = deleteButton
        
        self.saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: .saveButtonPressed)
        navigationItem.rightBarButtonItem = self.saveButton
        
        view.backgroundColor = .white
    }
    
    // MARK: - Actions
    @objc fileprivate func saveButtonPressed(_ sender: UIBarButtonItem) {
        if form.validate().isEmpty {
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    @objc fileprivate func deleteButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Delete this item?", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let delete = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.viewModel.delete()
            _ = self?.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(delete)
        alert.addAction(cancel)
        
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        form
            +++ Section()
            <<< TextRow() {
                $0.title = "Name"
                $0.placeholder = "Subscription name"
                $0.value = viewModel.name
                $0.onChange { [unowned self] row in
                    self.viewModel.name = row.value
                }
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnBlur
                $0.cellUpdate {(cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            }
            <<< DecimalRow() {
                $0.title = "Price"
                $0.placeholder = "¥0.00"
                $0.formatter = DecimalFormatter()
                $0.value = viewModel.price?.doubleValue
                $0.onChange {[unowned self] row in
                    if let price = row.value {
                        self.viewModel.price = NSDecimalNumber(value: price)
                    }
                }
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func selectSubscriptionIcon(_ sender: UITapGestureRecognizer) {
        os_log("select image")
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.sourceType = .photoLibrary
//        imagePickerController.delegate = self
//        present(imagePickerController, animated: true, completion: nil)
    }
    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        //
//        os_log("cancelled")
//        dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        //
//        os_log("picked")
//        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
//            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
//        }
//        subscriptionIconImageView.image = selectedImage
//        dismiss(animated: true, completion: nil)
//    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === self.saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "Subscription", in: context)!
        let subscription = Subscription(entity: entity, insertInto: context)
        subscription.setValue(self.viewModel.name, forKey: "name")
        subscription.setValue(self.viewModel.price, forKey: "price")
        do {
            try context.save()
        } catch  {
            fatalError("error saving context")
        }
    }


}

// MARK: - Selectors
extension Selector {
    fileprivate static let saveButtonPressed = #selector(CreateSubscriptionViewController.saveButtonPressed(_:))
    fileprivate static let deleteButtonPressed = #selector(CreateSubscriptionViewController.deleteButtonPressed(_:))
}
