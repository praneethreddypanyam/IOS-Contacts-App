//
//  ContactDetailViewController.swift
//  ContactsApplication
//
//  Created by Praneet Reddy on 01/02/20.
//  Copyright © 2020 PraneethReddy. All rights reserved.
//

import UIKit
import CoreData

class ContactDetailViewController: UIViewController {
   
    var contact: NSManagedObject? = nil
    var isDeleted: Bool = false
    var indexPath: IndexPath? = nil
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = contact?.value(forKey: "name") as? String
        phoneLabel.text = contact?.value(forKey: "phoneNumber") as? String
        companyLabel.text = contact?.value(forKey: "company") as? String
        emailLabel.text = contact?.value(forKey: "email") as? String
        loadImageFromDiskWith(fileName: nameLabel.text!+".png")
    }
    // MARK: - Navigation
    func loadImageFromDiskWith(fileName: String){
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            if image != nil{
                imageView.image = image
            }
            else{
                let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName.lowercased())
                let image = UIImage(contentsOfFile: imageUrl.path)
                if image != nil{
                    imageView.image = image
                }
            }
        }
        else{
            print(fileName,"doesn't exist")
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBAction func done(_ sender: Any) {
        performSegue(withIdentifier: "unwindToContactList", sender: self)
    }
   
    @IBAction func deleteContact(_ sender: Any) {
        isDeleted = true
        performSegue(withIdentifier: "unwindToContactList", sender: self)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "editContact"{
            guard let viewController = segue.destination as? AddContactViewController else { return }
            viewController.titleText = "Edit Contact"
            viewController.contact = contact
            viewController.indexPathForContact = self.indexPath!
        }
    }
}
