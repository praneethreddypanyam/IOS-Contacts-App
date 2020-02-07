//
//  ContactsViewController.swift
//  ContactsApplication
//
//  Created by Praneet Reddy on 01/02/20.
//  Copyright © 2020 PraneethReddy. All rights reserved.
//

import UIKit
import CoreData

class ContactsViewController: UITableViewController {
    

    struct Section {
        let letter : String
        let usernames : [String]
    }

    var contactsDetails = [Contact]()
    var usernames = [String]()
    var sections = [Section]()    
    var contacts: [NSManagedObject] = []
    var keys = [String]()
    
    var sortedUsernames = [String]()
    var groupedDictionary = [String : [String]]()

    override func viewDidLoad() {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        fetch()
        super.viewDidLoad()
        tableView.reloadData()
        tableView.tableFooterView = UIView()   //To remove unwanted empty cells
    }

    // MARK: - Table view data source
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map{$0.letter}
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].letter
    }
    
    func fetch(){
        usernames = [String]()
        contactsDetails = [Contact]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        do{
            contacts = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            if let constants = contacts as? [Contact] {
                for i in 0..<(constants.count){
                    contactsDetails.append(constants[i])
                    usernames.append(constants[i].name!)
                }
            }
            groupedDictionary = Dictionary(grouping: usernames, by: {String($0.prefix(1).capitalized)})
            keys = groupedDictionary.keys.sorted()
            sections = keys.map{ Section(letter: $0, usernames: groupedDictionary[$0]!.sorted()) }
        } catch let error as NSError{
            print("Could not fetch. \(error)")
        }
    }
    
    func save(name: String, phoneNumber: String, email: String, company: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Contact", in: managedObjectContext) else { return }
        let contact = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        contact.setValue(name, forKey: "name")
        contact.setValue(phoneNumber, forKey: "phoneNumber")
        contact.setValue(email, forKey: "email")
        contact.setValue(company, forKey: "company")
        do{
            try managedObjectContext.save()
            contacts.append(contact)
            fetch()
        }catch let error as NSError{
            print("Couldn't save. \(error)")
        }
    }
    
    func delete(_ contact: NSManagedObject,at index: Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        managedObjectContext.delete(contact)
        contacts.remove(at: index)
        do{
            try managedObjectContext.save()
            fetch()
        }catch let error as NSError{
            print(error)
        }
    
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].usernames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let section = sections[indexPath.section]
        let username = section.usernames[indexPath.row]
        cell.textLabel?.text = username
        return cell
    }
    
    
    func update(indexPath: Int, name: String, phoneNumber: String, email: String, company: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let contact = contacts[indexPath]
        contact.setValue(name, forKey: "name")
        contact.setValue(phoneNumber, forKey: "phoneNumber")
        contact.setValue(email, forKey: "email")
        contact.setValue(company, forKey: "company")
        
        do{
            try managedObjectContext.save()
            contacts[indexPath] = contact
            fetch()
        }catch let error as NSError{
            print("Couldn't save. \(error)")
        }
    }
    
    //MARK: - Navigation
    
    @IBAction func unwindToContactList(segue: UIStoryboardSegue){
        if let viewController = segue.source as? AddContactViewController{
            guard let name: String = viewController.nameTextField.text, let phoneNumber: String = viewController.phoneNumberTextField.text, let email: String = viewController.emailTextField.text, let company: String = viewController.companyTextField.text else { return }
            if name != "" && phoneNumber != ""{
                if let indexPath = viewController.indexPathForContact{
                    let index = indexFinder(indexPath: indexPath)
                    update(indexPath: index, name: name, phoneNumber: phoneNumber, email: email, company: company)
                }else{
                    save(name: name, phoneNumber: phoneNumber, email: email, company: company)
                }
                
            }
                
        } else if let viewController = segue.source as? ContactDetailViewController{
            if viewController.isDeleted{
                guard let indexPath: IndexPath = viewController.indexPath else { return }
                let index = indexFinder(indexPath: indexPath)
                let contact = contacts[index]
                delete(contact, at: index)
            }
        }
        tableView.reloadData()
    }
       
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contactDetailSegue"{
            guard let navViewController = segue.destination as? UINavigationController else { return }
            guard let viewController = navViewController.topViewController as? ContactDetailViewController else{ return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let index = indexFinder(indexPath: indexPath)
            let contact = contactsDetails[index]
            viewController.contact = contact
            viewController.indexPath = indexPath
        }
    }
    
    func indexFinder(indexPath: IndexPath) -> Int {
        let rowKey = indexPath.row
        let selectionKey = indexPath.section
        let value = groupedDictionary[keys[selectionKey]]?.sorted()
        let final = value![rowKey]
        let index = usernames.firstIndex(of: final)
        return index!
    }
    
    
    override func tableView(_ tableView: UITableView,trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
        UISwipeActionsConfiguration? {
        let configuration = UISwipeActionsConfiguration(actions: [UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, completionHandler) in
            let index = self.indexFinder(indexPath: indexPath)
            let contact = self.contactsDetails[index]
            self.delete(contact, at: index)
            tableView.reloadData()
            completionHandler(true)
        })
        ])
            return configuration
        }
    
}
